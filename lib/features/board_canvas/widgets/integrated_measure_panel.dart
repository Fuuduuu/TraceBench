import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/measurement_projection.dart';
import '../theme/board_canvas_palette.dart';
import '../../measure_sheet/services/v2_save_measurement_writer.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/session/project_session.dart';

String _displayDirectionLabel(String from, String? to) {
  final trimmedFrom = from.trim();
  final trimmedTo = to?.trim();
  if (trimmedTo == null || trimmedTo.isEmpty) {
    return trimmedFrom;
  }
  return '$trimmedFrom -> $trimmedTo';
}

String? _firstPresentText(Iterable<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
  }
  return null;
}

const double _reservedPinControlGutterWidth = 40;
const Color _kMeasurePanelNavy = Color(0xFFF3ECDC);
const Color _kMeasurePanelSignal = Color(0xFFE7C25A);
const Color _kMeasurePanelSignalTint = Color(0xFF2A2416);
const Color _kMeasurePanelCoolSurface = Color(0xFF141310);
const Color _kMeasurePanelBodyFill = Color(0xFF1A1916);
const Color _kMeasurePanelRowFill = Color(0xFF0A0A0A);
const Color _kMeasurePanelRowRaised = Color(0xFF211E18);
const Color _kMeasurePanelRule = Color(0xFF332E22);

class IntegratedMeasurePanel extends ConsumerStatefulWidget {
  const IntegratedMeasurePanel({
    super.key,
    required this.projectState,
    required this.selectedComponentId,
    required this.selectedComponent,
    required this.relatedMeasurements,
    required this.relatedVisualTraces,
    required this.onContinueToMeasureSheet,
    required this.advancedDetailsBuilder,
    required this.footprintPreviewBuilder,
  });

  final ProjectState projectState;
  final String? selectedComponentId;
  final ComponentFact? selectedComponent;
  final List<MeasurementFact> relatedMeasurements;
  final List<VisualTraceFact> relatedVisualTraces;
  final VoidCallback onContinueToMeasureSheet;
  final List<Widget> Function(BuildContext context) advancedDetailsBuilder;
  final Widget Function(
    String? selectedTarget,
    String? selectedTargetLabel,
    int measurementCount,
  ) footprintPreviewBuilder;

  @override
  ConsumerState<IntegratedMeasurePanel> createState() =>
      _IntegratedMeasurePanelState();
}

class _IntegratedMeasurePanelState
    extends ConsumerState<IntegratedMeasurePanel> {
  static const List<String> _draftUnitOptions = ['V', 'Ω', 'Diode', 'Beep'];

  String? _selectedTarget;
  final Map<String, String> _draftValuesByTarget = {};
  final Map<String, String> _draftUnitsByTarget = {};
  bool _saveInFlight = false;
  String? _saveStatusMessage;
  String? _saveErrorMessage;
  String? _lastSuccessfulFormKey;

  _MeasureUnitSelection _unitSelection(String unitLabel) {
    switch (unitLabel) {
      case 'Ω':
        return const _MeasureUnitSelection(
          label: 'Ω',
          mode: 'resistance',
          schemaUnit: 'Ω',
        );
      case 'Diode':
        return const _MeasureUnitSelection(
          label: 'Diode',
          mode: 'diode',
          schemaUnit: 'diode',
        );
      case 'Beep':
        return const _MeasureUnitSelection(
          label: 'Beep',
          mode: 'continuity',
          schemaUnit: 'beep',
        );
      case 'V':
      default:
        return const _MeasureUnitSelection(
          label: 'V',
          mode: 'voltage',
          schemaUnit: 'V',
        );
    }
  }

  Object _readingValue(String rawValue) {
    return num.tryParse(rawValue) ?? rawValue;
  }

  String? _componentIdForTarget(String target) {
    final selectedComponentId = widget.selectedComponentId;
    if (selectedComponentId != null &&
        measurementEndpointMatchesComponent(target, selectedComponentId)) {
      return selectedComponentId;
    }
    return selectedComponentId;
  }

  String? _pinIdForTarget(String target) {
    final componentId = widget.selectedComponentId;
    if (componentId == null) {
      return null;
    }
    return target.startsWith('$componentId.') ? target : null;
  }

  String? _formKeyFor({
    required _MeasureTargetRowData? row,
    required String valueText,
    required String unitLabel,
  }) {
    if (widget.selectedComponentId == null ||
        row == null ||
        row.isExistingValue) {
      return null;
    }
    final trimmedValue = valueText.trim();
    if (trimmedValue.isEmpty || unitLabel.trim().isEmpty) {
      return null;
    }
    return [
      row.target,
      unitLabel.trim(),
      trimmedValue,
      'human_entered',
    ].join('|');
  }

  String? _saveBlockReason({
    required _MeasureTargetRowData? row,
    required String valueText,
    required String unitLabel,
  }) {
    if (widget.selectedComponentId == null) {
      return 'Vali mõõtmise Koht plaadil.';
    }
    if (row == null) {
      return 'Vali Koht enne salvestamist.';
    }
    if (row.isExistingValue) {
      return 'Vali uus Koht või sisesta mõõtmata reale Väärtus.';
    }
    if (valueText.trim().isEmpty) {
      return 'Sisesta Väärtus enne salvestamist.';
    }
    if (unitLabel.trim().isEmpty) {
      return 'Vali Ühik enne salvestamist.';
    }
    if (_lastSuccessfulFormKey ==
        _formKeyFor(row: row, valueText: valueText, unitLabel: unitLabel)) {
      return 'Mõõtmine on salvestatud. Projektsioon vajab värskendamist.';
    }
    final projectDirectory = widget.projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return 'Mõõtmise salvestamiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  Future<void> _saveMeasurement({
    required _MeasureTargetRowData row,
    required String valueText,
    required String unitLabel,
  }) async {
    if (_saveInFlight) {
      return;
    }
    final blockReason = _saveBlockReason(
      row: row,
      valueText: valueText,
      unitLabel: unitLabel,
    );
    if (blockReason != null) {
      setState(() {
        _saveStatusMessage = null;
        _saveErrorMessage = blockReason;
      });
      return;
    }

    final formKey =
        _formKeyFor(row: row, valueText: valueText, unitLabel: unitLabel)!;
    final unitSelection = _unitSelection(unitLabel);
    final componentId = _componentIdForTarget(row.target);
    final pinId = _pinIdForTarget(row.target);
    final request = V2SaveMeasurementRequest(
      value: _readingValue(valueText.trim()),
      valueText: valueText.trim(),
      displayValue: '${valueText.trim()} ${unitSelection.label}',
      unitLabel: unitSelection.label,
      schemaUnit: unitSelection.schemaUnit,
      mode: unitSelection.mode,
      targetKey: row.target,
      displayLabel: row.displayLabel,
      componentId: componentId,
      pinId: pinId,
      valueProvenance: 'human_entered',
      clientOperationId: _measurementClientOperationIdFor(formKey),
    );

    setState(() {
      _saveInFlight = true;
      _saveStatusMessage = 'Salvestan mõõtmist...';
      _saveErrorMessage = null;
    });

    try {
      final projectState =
          ref.read(projectStateProvider) ?? widget.projectState;
      final projectSession = ref.read(projectStateProvider.notifier);
      final generation = projectSession.generation;
      final result =
          await ref.read(v2SaveMeasurementWriterProvider).saveMeasurement(
                projectState: projectState,
                request: request,
              );
      projectSession.applyCanonicalEvent(
        result.event,
        generation: generation,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _lastSuccessfulFormKey = formKey;
        _saveStatusMessage = result.appended
            ? 'Mõõtmine salvestatud. Projektsioon vajab värskendamist.'
            : 'Mõõtmine oli juba salvestatud. Projektsioon vajab värskendamist.';
        _saveErrorMessage = null;
      });
    } on V2SaveMeasurementException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _saveStatusMessage = null;
        _saveErrorMessage = _measurementFailureMessage(error);
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _saveStatusMessage = null;
        _saveErrorMessage = 'Mõõtmise salvestamine ebaõnnestus: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _saveInFlight = false;
        });
      }
    }
  }

  String _measurementClientOperationIdFor(String formKey) {
    final safeKey = formKey
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_measurement_${safeKey}_$timestamp';
  }

  String _measurementFailureMessage(V2SaveMeasurementException error) {
    switch (error.kind) {
      case V2SaveMeasurementFailureKind.noProjectDirectory:
        return 'Mõõtmise salvestamiseks ava projekt kohalikust kaustast.';
      case V2SaveMeasurementFailureKind.invalidProjectDirectory:
        return 'Projektikaust ei sobi mõõtmise salvestamiseks.';
      case V2SaveMeasurementFailureKind.pythonUnavailable:
        return 'Mõõtmise kirjutaja pole saadaval.';
      case V2SaveMeasurementFailureKind.lockConflict:
        return 'Mõõtmise kirjutaja on hetkel hõivatud.';
      case V2SaveMeasurementFailureKind.validation:
        return 'Mõõtmist ei salvestatud: sisestus ei läbinud valideerimist.';
      case V2SaveMeasurementFailureKind.append:
        return 'Mõõtmise salvestamine ebaõnnestus: ${error.message}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedName = widget.selectedComponentId == null
        ? null
        : _preferredComponentLabel(widget.selectedComponentId!);
    final selectedHeader = widget.selectedComponentId == null
        ? 'Select a component on Canvas.'
        : _componentSelectorLabel(widget.selectedComponentId!);
    final targetRows = _measureTargetRows();
    final contextRows = _measureContextRows();
    final selectedTargetRow = _effectiveSelectedTargetRow(targetRows);
    final selectedTarget = selectedTargetRow?.target;
    final selectedDraftValue = selectedTarget == null
        ? ''
        : _draftValuesByTarget[selectedTarget] ?? '';
    final selectedDraftUnit = selectedTarget == null
        ? _draftUnitOptions.first
        : _draftUnitsByTarget[selectedTarget] ??
            (selectedTargetRow == null
                ? _draftUnitOptions.first
                : _defaultDraftUnit(selectedTargetRow));
    final saveBlockReason = _saveBlockReason(
      row: selectedTargetRow,
      valueText: selectedDraftValue,
      unitLabel: selectedDraftUnit,
    );
    final canSaveMeasurement = !_saveInFlight && saveBlockReason == null;
    final measuredTargetCount =
        targetRows.where((row) => row.isExistingValue).length;

    return SingleChildScrollView(
      key: const Key('board_canvas_integrated_measure_panel'),
      child: DecoratedBox(
        key: const Key('board_canvas_measure_panel_surface'),
        decoration: BoxDecoration(
          color: _kMeasurePanelCoolSurface,
          border: Border.all(color: _kMeasurePanelRule),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              key: const Key('board_canvas_measure_panel_header'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mõõtmine',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: _kMeasurePanelNavy,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          selectedHeader,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: BoardCanvasPalette.muted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const _MeasurePanelPill(label: 'human · write'),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Padding(
              key: const Key('board_canvas_measure_visual_section'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Komponendi vaade',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: _kMeasurePanelNavy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _MeasureComponentPreview(
                    selectedComponentId: widget.selectedComponentId,
                    footprintPreviewBuilder: widget.footprintPreviewBuilder,
                    selectedName: selectedName,
                    selectedTarget: selectedTarget,
                    targetRows: targetRows,
                    measurementCount: measuredTargetCount,
                    onTargetSelected: (target) {
                      setState(() {
                        _selectedTarget = target;
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Visual only; no connectivity proof.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: BoardCanvasPalette.muted,
                    ),
                  ),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Padding(
              key: const Key('board_canvas_measure_values_section'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Mõõdetud väärtused',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: _kMeasurePanelNavy,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      _MeasurePanelPill(
                        key: const Key('board_canvas_measure_values_count'),
                        label:
                            '$measuredTargetCount / ${targetRows.length} mõõdetud',
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Koht -> Väärtus -> Ühik -> Salvesta',
                    key: const Key('board_canvas_measure_entry_flow_copy'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: BoardCanvasPalette.muted,
                    ),
                  ),
                  const SizedBox(height: 7),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: _kMeasurePanelBodyFill.withValues(alpha: 0.62),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _kMeasurePanelRule.withValues(alpha: 0.88),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          ...targetRows.map(
                            (row) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: _MeasureTargetRow(
                                row: row,
                                selected: row.target == selectedTarget,
                                draftValue:
                                    _draftValuesByTarget[row.target] ?? '',
                                draftUnit: _draftUnitsByTarget[row.target] ??
                                    _defaultDraftUnit(row),
                                unitOptions: _draftUnitOptions,
                                onSelected: () {
                                  setState(() {
                                    _selectedTarget = row.target;
                                  });
                                },
                                onDraftValueChanged: (value) {
                                  setState(() {
                                    _selectedTarget = row.target;
                                    _draftValuesByTarget[row.target] = value;
                                  });
                                },
                                onDraftUnitChanged: (value) {
                                  setState(() {
                                    _selectedTarget = row.target;
                                    _draftUnitsByTarget[row.target] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'AI/photo/trace context is not canonical. Salvesta records only the human-entered measurement.',
                    key: const Key(
                      'board_canvas_measure_canonical_boundary_copy',
                    ),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: BoardCanvasPalette.muted,
                    ),
                  ),
                  const SizedBox(height: 7),
                  DecoratedBox(
                    key: const Key('board_canvas_measure_save_bar'),
                    decoration: BoxDecoration(
                      color: _kMeasurePanelRowFill,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: _kMeasurePanelRule),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  saveBlockReason ??
                                      'Valmis mõõtmist salvestama.',
                                  key: const Key(
                                    'board_canvas_measure_save_guard',
                                  ),
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: canSaveMeasurement
                                        ? _kMeasurePanelSignal
                                        : BoardCanvasPalette.muted,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                key: const Key(
                                  'board_canvas_measure_save_button',
                                ),
                                onPressed: canSaveMeasurement &&
                                        selectedTargetRow != null
                                    ? () => _saveMeasurement(
                                          row: selectedTargetRow,
                                          valueText: selectedDraftValue,
                                          unitLabel: selectedDraftUnit,
                                        )
                                    : null,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _kMeasurePanelSignal,
                                  disabledForegroundColor:
                                      BoardCanvasPalette.dim,
                                  side: BorderSide(
                                    color: canSaveMeasurement
                                        ? _kMeasurePanelSignal
                                        : _kMeasurePanelRule,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                                icon: Icon(
                                  _saveInFlight
                                      ? Icons.hourglass_top_rounded
                                      : Icons.save_alt_rounded,
                                  size: 16,
                                ),
                                label: Text(
                                  _saveInFlight ? 'Salvestan...' : 'Salvesta',
                                ),
                              ),
                            ],
                          ),
                          if (_saveStatusMessage != null) ...[
                            const SizedBox(height: 5),
                            Text(
                              _saveStatusMessage!,
                              key: const Key(
                                'board_canvas_measure_save_status',
                              ),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: _kMeasurePanelSignal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                          if (_saveErrorMessage != null) ...[
                            const SizedBox(height: 5),
                            Text(
                              _saveErrorMessage!,
                              key: const Key(
                                'board_canvas_measure_save_error',
                              ),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: const Color(0xFFFCA5A5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      key: const Key(
                        'board_canvas_measure_continue_sheet_button',
                      ),
                      onPressed: widget.onContinueToMeasureSheet,
                      style: TextButton.styleFrom(
                        foregroundColor: BoardCanvasPalette.muted,
                        visualDensity: VisualDensity.compact,
                        minimumSize: const Size(0, 30),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        textStyle: theme.textTheme.labelMedium,
                      ),
                      icon: const Icon(Icons.open_in_new_rounded, size: 16),
                      label: const Text('Jätka mõõtelehel'),
                    ),
                  ),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Padding(
              key: const Key('board_canvas_measure_context_section'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From -> To context',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: _kMeasurePanelNavy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Display only; no confirmed connectivity.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: BoardCanvasPalette.muted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (contextRows.isEmpty)
                    Text(
                      'No From -> To context for selected component.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: BoardCanvasPalette.muted,
                      ),
                    )
                  else
                    ...contextRows.map(
                      (row) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: _MeasureContextRow(row: row),
                      ),
                    ),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Material(
              color: Colors.transparent,
              child: ExpansionTile(
                key: const Key('board_canvas_measure_advanced_section'),
                dense: true,
                visualDensity: VisualDensity.compact,
                minTileHeight: 40,
                tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                childrenPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                title: Text(
                  'Tehnilised detailid',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: _kMeasurePanelNavy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'kirjutuskaitstud päritolu',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.muted,
                  ),
                ),
                children: widget.advancedDetailsBuilder(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _MeasureTargetRowData? _effectiveSelectedTargetRow(
    List<_MeasureTargetRowData> targetRows,
  ) {
    if (targetRows.isEmpty) {
      return null;
    }
    for (final row in targetRows) {
      if (row.target == _selectedTarget) {
        return row;
      }
    }
    return targetRows.first;
  }

  List<_MeasureTargetRowData> _measureTargetRows() {
    final componentId = widget.selectedComponentId;
    final componentLabel = widget.selectedComponentId == null
        ? null
        : _preferredComponentLabel(widget.selectedComponentId!);
    final rowsByTarget = <String, _MeasureTargetRowData>{};

    for (final measurement in widget.relatedMeasurements) {
      final target = _measurementTargetLabel(measurement, componentId);
      final displayValue = _measurementDisplayValue(measurement);
      final displayUnit = _measurementDisplayUnit(measurement);
      rowsByTarget[target] = _MeasureTargetRowData(
        target: target,
        displayLabel: _technicianTargetLabel(
          target,
          componentId: componentId,
          componentLabel: componentLabel,
        ),
        visualLabel: _visualPointLabel(
          target,
          componentId: componentId,
        ),
        value: displayValue,
        unit: displayUnit,
        isExistingValue: true,
        showExistingUnit: _shouldShowMeasurementUnit(displayUnit),
        suggestedUnit: measurement.unit,
      );
    }

    if (componentId != null) {
      for (final trace in widget.relatedVisualTraces) {
        for (final target in _visualTraceTargets(trace, componentId)) {
          rowsByTarget.putIfAbsent(
            target,
            () => _MeasureTargetRowData(
              target: target,
              displayLabel: _technicianTargetLabel(
                target,
                componentId: componentId,
                componentLabel: componentLabel,
              ),
              visualLabel: _visualPointLabel(
                target,
                componentId: componentId,
              ),
              value: '',
              isExistingValue: false,
            ),
          );
        }
      }
    }

    if (rowsByTarget.isEmpty) {
      rowsByTarget[widget.selectedComponentId ?? 'No target'] =
          _MeasureTargetRowData(
        target: widget.selectedComponentId ?? 'Select component',
        displayLabel: _technicianTargetLabel(
          widget.selectedComponentId ?? 'Select component',
          componentId: componentId,
          componentLabel: componentLabel,
        ),
        visualLabel: _visualPointLabel(
          widget.selectedComponentId ?? 'Select component',
          componentId: componentId,
        ),
        value: '',
        isExistingValue: false,
      );
    }

    return rowsByTarget.values.toList(growable: false);
  }

  List<_MeasureContextRowData> _measureContextRows() {
    final rows = <_MeasureContextRowData>[];

    for (final measurement in widget.relatedMeasurements) {
      rows.add(
        _MeasureContextRowData(
          label: _measurementDirectionLabel(measurement),
          detail: 'measurement context · ${measurement.measurementId}',
        ),
      );
    }

    for (final trace in widget.relatedVisualTraces) {
      final label = _visualTraceDirectionLabel(trace, trace.traceId);
      rows.add(
        _MeasureContextRowData(
          label: label,
          detail: 'visual-only context · ${trace.traceId}',
        ),
      );
    }

    return rows;
  }

  String _measurementTargetLabel(
    MeasurementFact measurement,
    String? componentId,
  ) {
    if (componentId != null) {
      if (measurementEndpointMatchesComponent(measurement.from, componentId)) {
        return measurement.from;
      }
      if (measurementEndpointMatchesComponent(measurement.to, componentId)) {
        return measurement.to;
      }
    }
    return measurement.measurementId;
  }

  String _measurementDirectionLabel(MeasurementFact measurement) {
    return _displayDirectionLabel(measurement.from, measurement.to);
  }

  String _measurementDisplayValue(MeasurementFact measurement) {
    final rawValue = measurement.value == null
        ? measurement.reading
        : '${measurement.value}';
    final unit = measurement.unit?.trim().toLowerCase();
    final normalized = rawValue.trim().toLowerCase();
    if (unit == 'beep') {
      if (normalized == 'true' ||
          normalized == 'yes' ||
          normalized == '1' ||
          normalized == 'beep') {
        return 'Beep';
      }
      if (normalized == 'false' ||
          normalized == 'no' ||
          normalized == '0' ||
          normalized == 'silent') {
        return 'No beep';
      }
    }
    return rawValue;
  }

  String? _measurementDisplayUnit(MeasurementFact measurement) {
    final unit = measurement.unit?.trim();
    if (unit == null || unit.isEmpty) {
      return null;
    }
    return unit;
  }

  bool _shouldShowMeasurementUnit(String? unit) {
    final normalized = unit?.trim().toLowerCase();
    return normalized != null && normalized.isNotEmpty && normalized != 'beep';
  }

  String _technicianTargetLabel(
    String target, {
    String? componentId,
    String? componentLabel,
  }) {
    final trimmed = target.trim();
    final separatorIndex = trimmed.lastIndexOf('.');
    if (separatorIndex <= 0 || separatorIndex == trimmed.length - 1) {
      if (componentId != null &&
          componentLabel != null &&
          trimmed == componentId) {
        return componentLabel;
      }
      return trimmed;
    }
    final pinLabel = trimmed.substring(separatorIndex + 1);
    final targetComponentId = trimmed.substring(0, separatorIndex);
    final displayTarget = componentId != null &&
            componentLabel != null &&
            targetComponentId == componentId
        ? '$componentLabel.$pinLabel'
        : trimmed;
    return 'Pin $pinLabel · $displayTarget';
  }

  String _visualPointLabel(
    String target, {
    String? componentId,
  }) {
    final trimmed = target.trim();
    if (componentId != null && trimmed == componentId) {
      return 'Component';
    }
    final separatorIndex = trimmed.lastIndexOf('.');
    if (separatorIndex <= 0 || separatorIndex == trimmed.length - 1) {
      return trimmed;
    }
    return 'Pin ${trimmed.substring(separatorIndex + 1)}';
  }

  String _visualTraceDirectionLabel(
    VisualTraceFact trace,
    String fallbackTarget,
  ) {
    final from = _firstPresentText([trace.fromPin, trace.fromComponent]);
    final to = _firstPresentText([trace.toPin, trace.toComponent]);
    if (from != null) {
      return _displayDirectionLabel(from, to);
    }
    return to ?? fallbackTarget;
  }

  List<String> _visualTraceTargets(
    VisualTraceFact trace,
    String componentId,
  ) {
    final targets = <String>[];
    if (_tracePinMatchesComponent(trace.fromPin, componentId)) {
      targets.add(trace.fromPin!);
    }
    if (_tracePinMatchesComponent(trace.toPin, componentId)) {
      targets.add(trace.toPin!);
    }
    if (targets.isEmpty && trace.fromComponent == componentId) {
      targets.add(trace.fromComponent!);
    }
    if (targets.isEmpty && trace.toComponent == componentId) {
      targets.add(trace.toComponent!);
    }
    return targets;
  }

  bool _tracePinMatchesComponent(String? pinId, String componentId) {
    return pinId != null && pinId.startsWith('$componentId.');
  }

  String _defaultDraftUnit(_MeasureTargetRowData row) {
    return row.suggestedUnit ?? row.unit ?? _draftUnitOptions.first;
  }

  String _componentSelectorLabel(String componentId) {
    final designator = widget.selectedComponent?.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return '$designator ($componentId)';
    }
    return componentId;
  }

  String _preferredComponentLabel(String componentId) {
    final designator = widget.selectedComponent?.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return designator;
    }
    return componentId;
  }
}

class _MeasureTargetRowData {
  const _MeasureTargetRowData({
    required this.target,
    required this.displayLabel,
    required this.visualLabel,
    required this.value,
    required this.isExistingValue,
    this.unit,
    this.showExistingUnit = true,
    this.suggestedUnit,
  });

  final String target;
  final String displayLabel;
  final String visualLabel;
  final String value;
  final bool isExistingValue;
  final String? unit;
  final bool showExistingUnit;
  final String? suggestedUnit;
}

class _MeasureUnitSelection {
  const _MeasureUnitSelection({
    required this.label,
    required this.mode,
    required this.schemaUnit,
  });

  final String label;
  final String mode;
  final String schemaUnit;
}

class _MeasureContextRowData {
  const _MeasureContextRowData({
    required this.label,
    required this.detail,
  });

  final String label;
  final String detail;
}

class _MeasurePanelDivider extends StatelessWidget {
  const _MeasurePanelDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: _kMeasurePanelRule,
    );
  }
}

class _MeasurePanelPill extends StatelessWidget {
  const _MeasurePanelPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _kMeasurePanelSignalTint.withValues(alpha: 0.88),
        border: Border.all(color: _kMeasurePanelSignal.withValues(alpha: 0.72)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: _kMeasurePanelNavy,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _MeasureComponentPreview extends StatelessWidget {
  const _MeasureComponentPreview({
    required this.selectedComponentId,
    required this.selectedName,
    required this.selectedTarget,
    required this.targetRows,
    required this.measurementCount,
    required this.onTargetSelected,
    required this.footprintPreviewBuilder,
  });

  final String? selectedComponentId;
  final String? selectedName;
  final String? selectedTarget;
  final List<_MeasureTargetRowData> targetRows;
  final int measurementCount;
  final ValueChanged<String> onTargetSelected;
  final Widget Function(
    String? selectedTarget,
    String? selectedTargetLabel,
    int measurementCount,
  ) footprintPreviewBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedRow = _selectedRow;
    final leftPads = <_MeasureTargetRowData>[];
    final rightPads = <_MeasureTargetRowData>[];
    for (var index = 0; index < targetRows.length; index++) {
      if (index.isEven) {
        leftPads.add(targetRows[index]);
      } else {
        rightPads.add(targetRows[index]);
      }
    }

    return DecoratedBox(
      key: const Key('board_canvas_measure_component_preview'),
      decoration: BoxDecoration(
        border: Border.all(color: _kMeasurePanelRule),
        borderRadius: BorderRadius.circular(8),
        color: BoardCanvasPalette.tile,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Component visual editing entry is deferred to a later explicit scope.
            Row(
              children: [
                const Icon(Icons.memory_outlined, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    selectedName == null
                        ? 'No component selected.'
                        : '$selectedName footprint preview',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _kMeasurePanelNavy,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            DecoratedBox(
              key: const Key('board_canvas_measure_component_visual_stage'),
              decoration: BoxDecoration(
                color: _kMeasurePanelNavy.withValues(alpha: 0.08),
                border: Border.all(color: _kMeasurePanelRule),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      key: const Key(
                        'board_canvas_measure_component_left_gutter',
                      ),
                      width: _reservedPinControlGutterWidth,
                      child: Align(
                        alignment: Alignment.center,
                        child: _MeasureVisualPadColumn(
                          rows: leftPads,
                          selectedTarget: selectedTarget,
                          onTargetSelected: onTargetSelected,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        key: const Key(
                          'board_canvas_measure_component_center_slot',
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 82,
                              child: footprintPreviewBuilder(
                                selectedTarget,
                                selectedRow?.visualLabel == null
                                    ? null
                                    : 'selected ${selectedRow!.visualLabel}',
                                measurementCount,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              selectedTarget == null
                                  ? 'select a local point'
                                  : 'selected ${selectedRow?.visualLabel ?? _targetVisualLabel(selectedTarget!)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: _kMeasurePanelNavy,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      key: const Key(
                        'board_canvas_measure_component_right_gutter',
                      ),
                      width: _reservedPinControlGutterWidth,
                      child: Align(
                        alignment: Alignment.center,
                        child: _MeasureVisualPadColumn(
                          rows: rightPads,
                          selectedTarget: selectedTarget,
                          onTargetSelected: onTargetSelected,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (selectedComponentId != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Visual only; contacts not added.',
                  key: const Key(
                    'board_canvas_measure_component_contacts_not_added',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (selectedComponentId != null)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  'Visual only; no connectivity proof.',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _MeasureTargetRowData? get _selectedRow {
    for (final row in targetRows) {
      if (row.target == selectedTarget) {
        return row;
      }
    }
    return null;
  }

  static String _targetVisualLabel(String target) {
    final dotIndex = target.lastIndexOf('.');
    if (dotIndex <= 0 || dotIndex == target.length - 1) {
      return target;
    }
    return target.substring(dotIndex + 1);
  }
}

class _MeasureVisualPadColumn extends StatelessWidget {
  const _MeasureVisualPadColumn({
    required this.rows,
    required this.selectedTarget,
    required this.onTargetSelected,
  });

  final List<_MeasureTargetRowData> rows;
  final String? selectedTarget;
  final ValueChanged<String> onTargetSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: _MeasureVisualPad(
              row: row,
              selected: row.target == selectedTarget,
              onSelected: () => onTargetSelected(row.target),
            ),
          ),
      ],
    );
  }
}

class _MeasureVisualPad extends StatelessWidget {
  const _MeasureVisualPad({
    required this.row,
    required this.selected,
    required this.onSelected,
  });

  final _MeasureTargetRowData row;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pad = DecoratedBox(
      key: Key('board_canvas_measure_visual_pad_${row.target}'),
      decoration: BoxDecoration(
        color: selected
            ? _kMeasurePanelSignal
            : row.isExistingValue
                ? _kMeasurePanelSignal.withValues(alpha: 0.22)
                : BoardCanvasPalette.tile,
        border: Border.all(
          color: selected ? _kMeasurePanelNavy : _kMeasurePanelRule,
          width: selected ? 2.4 : 1,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: _kMeasurePanelSignal.withValues(alpha: 0.34),
                  blurRadius: 11,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: SizedBox(
        width: 34,
        height: 24,
        child: Center(
          child: Text(
            _MeasureComponentPreview._targetVisualLabel(row.target),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: selected
                  ? BoardCanvasPalette.navyDeep
                  : BoardCanvasPalette.muted,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );

    Widget keyedPad = InkWell(
      key: Key('board_canvas_measure_visual_target_${row.target}'),
      borderRadius: BorderRadius.circular(6),
      onTap: onSelected,
      child: pad,
    );
    if (selected) {
      keyedPad = KeyedSubtree(
        key: Key('board_canvas_measure_visual_pad_selected_${row.target}'),
        child: KeyedSubtree(
          key: Key('board_canvas_measure_visual_target_selected_${row.target}'),
          child: keyedPad,
        ),
      );
    }
    return keyedPad;
  }
}

class _MeasureTargetRow extends StatelessWidget {
  const _MeasureTargetRow({
    required this.row,
    required this.selected,
    required this.draftValue,
    required this.draftUnit,
    required this.unitOptions,
    required this.onSelected,
    required this.onDraftValueChanged,
    required this.onDraftUnitChanged,
  });

  final _MeasureTargetRowData row;
  final bool selected;
  final String draftValue;
  final String draftUnit;
  final List<String> unitOptions;
  final VoidCallback onSelected;
  final ValueChanged<String> onDraftValueChanged;
  final ValueChanged<String> onDraftUnitChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trimmedDraft = draftValue.trim();
    final unitValue =
        unitOptions.contains(draftUnit) ? draftUnit : unitOptions.first;
    Widget targetDot() {
      return Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: selected || row.isExistingValue
              ? _kMeasurePanelSignal
              : Colors.transparent,
          border: Border.all(
            color: selected ? _kMeasurePanelSignal : _kMeasurePanelRule,
          ),
          shape: BoxShape.circle,
        ),
      );
    }

    Widget targetLabel() {
      return Text(
        row.displayLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          color: selected ? _kMeasurePanelNavy : BoardCanvasPalette.navy,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
        ),
      );
    }

    Widget existingValueControls() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MeasureInlineReadonlyBox(
            key: Key(
              'board_canvas_measure_row_existing_value_${row.target}',
            ),
            value: row.value,
            compact: !row.showExistingUnit,
          ),
          if (row.showExistingUnit && row.unit != null) ...[
            const SizedBox(width: 6),
            _MeasureInlineReadonlyBox(
              key: Key(
                'board_canvas_measure_row_existing_unit_${row.target}',
              ),
              value: row.unit!,
              compact: true,
            ),
          ],
        ],
      );
    }

    Widget draftControls() {
      return SizedBox(
        width: 152,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _kMeasurePanelCoolSurface,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: selected
                  ? _kMeasurePanelSignal.withValues(alpha: 0.7)
                  : _kMeasurePanelRule,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      key: Key(
                        'board_canvas_measure_row_value_input_${row.target}',
                      ),
                      initialValue: draftValue,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: _kMeasurePanelNavy,
                      ),
                      cursorColor: _kMeasurePanelSignal,
                      decoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        filled: true,
                        fillColor: _kMeasurePanelRowFill,
                        hintText: 'lisa väärtus',
                        hintStyle: theme.textTheme.labelMedium?.copyWith(
                          color: BoardCanvasPalette.dim,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: _kMeasurePanelRule,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: _kMeasurePanelSignal,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 7,
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      onTap: onSelected,
                      onChanged: onDraftValueChanged,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: _kMeasurePanelRowFill,
                    border: Border.all(
                      color: _kMeasurePanelRule,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: 54,
                    height: 30,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        key: Key(
                          'board_canvas_measure_row_unit_select_${row.target}',
                        ),
                        value: unitValue,
                        isDense: true,
                        isExpanded: true,
                        iconSize: 16,
                        dropdownColor: _kMeasurePanelRowRaised,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: _kMeasurePanelNavy,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        items: unitOptions
                            .map(
                              (unit) => DropdownMenuItem<String>(
                                value: unit,
                                child: Text(
                                  unit,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: _kMeasurePanelNavy,
                                  ),
                                ),
                              ),
                            )
                            .toList(growable: false),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          onSelected();
                          onDraftUnitChanged(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget targetRowContent(BoxConstraints constraints) {
      final controls =
          row.isExistingValue ? existingValueControls() : draftControls();
      final isCompact = constraints.maxWidth < 320;
      if (isCompact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                targetDot(),
                const SizedBox(width: 8),
                Expanded(child: targetLabel()),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: controls,
            ),
          ],
        );
      }
      return Row(
        children: [
          targetDot(),
          const SizedBox(width: 8),
          Expanded(child: targetLabel()),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Align(
              alignment: Alignment.centerRight,
              child: controls,
            ),
          ),
        ],
      );
    }

    return InkWell(
      key: Key('board_canvas_measure_target_row_${row.target}'),
      borderRadius: BorderRadius.circular(8),
      onTap: onSelected,
      child: DecoratedBox(
        key: selected
            ? Key('board_canvas_measure_target_row_selected_${row.target}')
            : null,
        decoration: BoxDecoration(
          color: selected
              ? _kMeasurePanelSignalTint
              : row.isExistingValue
                  ? _kMeasurePanelRowRaised
                  : _kMeasurePanelRowFill,
          border: Border.all(
            color: selected
                ? _kMeasurePanelSignal
                : row.isExistingValue
                    ? _kMeasurePanelRule.withValues(alpha: 0.95)
                    : _kMeasurePanelRule.withValues(alpha: 0.72),
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _kMeasurePanelSignal.withValues(alpha: 0.24),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) =>
                    targetRowContent(constraints),
              ),
              if (!row.isExistingValue && trimmedDraft.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(
                  'Draft: ${row.displayLabel} = $trimmedDraft $unitValue',
                  key: Key(
                    'board_canvas_measure_local_draft_summary_${row.target}',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.muted,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MeasureContextRow extends StatelessWidget {
  const _MeasureContextRow({required this.row});

  final _MeasureContextRowData row;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _kMeasurePanelRowFill,
        border: Border.all(
          color: _kMeasurePanelRule.withValues(alpha: 0.82),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Row(
          children: [
            const Icon(
              Icons.alt_route_rounded,
              size: 15,
              color: BoardCanvasPalette.muted,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                row.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: BoardCanvasPalette.navy,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                row.detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: BoardCanvasPalette.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeasureInlineReadonlyBox extends StatelessWidget {
  const _MeasureInlineReadonlyBox({
    super.key,
    required this.value,
    this.compact = false,
  });

  final String value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _kMeasurePanelRowRaised,
        border: Border.all(color: _kMeasurePanelRule),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: compact ? 46 : 58,
          maxWidth: compact ? 64 : 74,
          minHeight: 32,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
              color: _kMeasurePanelNavy,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
