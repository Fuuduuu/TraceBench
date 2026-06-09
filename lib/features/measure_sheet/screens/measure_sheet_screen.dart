import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/models/trace_bench_event.dart';
import '../services/v2_save_measurement_writer.dart';

class MeasureSheetScreen extends ConsumerStatefulWidget {
  const MeasureSheetScreen({super.key});

  static const _forbiddenSurfaceCopy = 'renderer writes: none';

  @override
  ConsumerState<MeasureSheetScreen> createState() => _MeasureSheetScreenState();
}

class _MeasureSheetScreenState extends ConsumerState<MeasureSheetScreen> {
  final TextEditingController _valueController = TextEditingController();
  _UnitOption? _selectedUnit;
  bool _isSaving = false;
  String? _lastSuccessfulFormKey;
  String? _successMessage;
  String? _errorMessage;

  String get _valueText => _valueController.text.trim();

  String? _formKey(_MeasureSheetSelection selection) {
    final option = _selectedUnit;
    if (_valueText.isEmpty || option == null || !selection.hasSaveTarget) {
      return null;
    }
    return [
      selection.targetKey,
      option.mode,
      option.schemaUnit,
      _valueText,
      'human_entered',
    ].join('|');
  }

  bool _canSave(_MeasureSheetSelection selection) {
    final formKey = _formKey(selection);
    return !_isSaving && formKey != null && formKey != _lastSuccessfulFormKey;
  }

  Future<void> _saveMeasurement(_MeasureSheetSelection selection) async {
    if (_isSaving) {
      return;
    }
    final formKey = _formKey(selection);
    final option = _selectedUnit;
    if (formKey == null ||
        option == null ||
        formKey == _lastSuccessfulFormKey) {
      return;
    }

    final projectState = ref.read(projectStateProvider);
    if (projectState == null) {
      setState(() {
        _successMessage = null;
        _errorMessage = 'Not saved: no project loaded.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _successMessage = null;
      _errorMessage = null;
    });

    try {
      final result =
          await ref.read(v2SaveMeasurementWriterProvider).saveMeasurement(
                projectState: projectState,
                request: V2SaveMeasurementRequest(
                  value: _readingValue(_valueText),
                  valueText: _valueText,
                  displayValue: '$_valueText ${option.label}',
                  unitLabel: option.label,
                  schemaUnit: option.schemaUnit,
                  mode: option.mode,
                  targetKey: selection.targetKey,
                  displayLabel: selection.kohtLabel,
                  componentId: selection.componentId,
                  pinId: selection.pinId,
                  valueProvenance: 'human_entered',
                  clientOperationId: _clientOperationId(formKey),
                ),
              );

      final eventAlreadyPresent =
          _hasLocalEvent(projectState.events, result.event);
      final updatedEvents = List<TraceBenchEvent>.from(projectState.events);
      if (!eventAlreadyPresent) {
        updatedEvents.add(TraceBenchEvent.fromJson(result.event));
      }
      ref.read(projectStateProvider.notifier).state = projectState.copyWith(
        events: updatedEvents,
        isProjectionStale: true,
      );

      setState(() {
        _lastSuccessfulFormKey = formKey;
        _successMessage = result.status == V2SaveMeasurementWriteStatus.existing
            ? 'Saved to events.jsonl (existing idempotent retry).'
            : 'Saved to events.jsonl';
      });
    } on V2SaveMeasurementException catch (error) {
      setState(() {
        _errorMessage = _messageForFailure(error);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Object _readingValue(String raw) {
    return num.tryParse(raw) ?? raw;
  }

  bool _hasLocalEvent(
    List<TraceBenchEvent> localEvents,
    Map<String, dynamic> candidate,
  ) {
    final eventId = candidate['event_id']?.toString();
    final clientOperationId = candidate['client_operation_id']?.toString();
    return localEvents.any((event) {
      if (eventId != null && eventId.isNotEmpty && event.eventId == eventId) {
        return true;
      }
      if (clientOperationId == null || clientOperationId.isEmpty) {
        return false;
      }
      return _clientOperationIdForEvent(event) == clientOperationId;
    });
  }

  String? _clientOperationIdForEvent(TraceBenchEvent event) {
    final serializedValue = event.toJson()['client_operation_id'];
    if (serializedValue != null && serializedValue.toString().isNotEmpty) {
      return serializedValue.toString();
    }

    final payloadValue = event.payload['client_operation_id'];
    if (payloadValue != null && payloadValue.toString().isNotEmpty) {
      return payloadValue.toString();
    }
    return null;
  }

  String _clientOperationId(String formKey) {
    final normalized = formKey
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return 'measure_sheet_$normalized';
  }

  String _messageForFailure(V2SaveMeasurementException error) {
    switch (error.kind) {
      case V2SaveMeasurementFailureKind.validation:
        return 'Not saved: validation failed.';
      case V2SaveMeasurementFailureKind.append:
        return 'Not saved: writer append failed.';
      case V2SaveMeasurementFailureKind.lockConflict:
        return 'Not saved: writer is busy, retry.';
      case V2SaveMeasurementFailureKind.pythonUnavailable:
        return 'Not saved: writer service is unavailable.';
      case V2SaveMeasurementFailureKind.noProjectDirectory:
        return 'Not saved: project must be opened from a local folder.';
      case V2SaveMeasurementFailureKind.invalidProjectDirectory:
        return 'Not saved: project path is invalid.';
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(
        body: Center(child: Text('No project loaded')),
      );
    }

    final selection = _MeasureSheetSelection.fromProject(projectState);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Measure Sheet'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 760;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SafetyBanner(selection: selection),
                  const SizedBox(height: 16),
                  if (isNarrow) ...[
                    _NarrowBoardContext(selection: selection),
                    const SizedBox(height: 16),
                    _MeasureSheetPanel(
                      selection: selection,
                      valueController: _valueController,
                      selectedUnit: _selectedUnit,
                      isSaving: _isSaving,
                      successMessage: _successMessage,
                      errorMessage: _errorMessage,
                      canSave: _canSave(selection),
                      onValueChanged: () => setState(() {
                        _successMessage = null;
                        _errorMessage = null;
                      }),
                      onUnitChanged: (unit) => setState(() {
                        _selectedUnit = unit;
                        _successMessage = null;
                        _errorMessage = null;
                      }),
                      onSave: () => _saveMeasurement(selection),
                    ),
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _BoardContextPanel(selection: selection)),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 430,
                          child: _MeasureSheetPanel(
                            selection: selection,
                            valueController: _valueController,
                            selectedUnit: _selectedUnit,
                            isSaving: _isSaving,
                            successMessage: _successMessage,
                            errorMessage: _errorMessage,
                            canSave: _canSave(selection),
                            onValueChanged: () => setState(() {
                              _successMessage = null;
                              _errorMessage = null;
                            }),
                            onUnitChanged: (unit) => setState(() {
                              _selectedUnit = unit;
                              _successMessage = null;
                              _errorMessage = null;
                            }),
                            onSave: () => _saveMeasurement(selection),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  _ReferenceValuesPanel(selection: selection),
                  const SizedBox(height: 16),
                  _GuidedMeasurementPanel(selection: selection),
                  const SizedBox(height: 16),
                  const Text(
                    MeasureSheetScreen._forbiddenSurfaceCopy,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MeasureSheetSelection {
  const _MeasureSheetSelection({
    required this.componentId,
    required this.pinId,
    required this.componentLabel,
    required this.pinLabel,
    required this.measurementLabel,
    required this.measurementKind,
    required this.hasRecordedReading,
    required this.projectLabel,
  });

  final String? componentId;
  final String? pinId;
  final String componentLabel;
  final String pinLabel;
  final String measurementLabel;
  final String measurementKind;
  final bool hasRecordedReading;
  final String projectLabel;

  String get kohtLabel => '$componentLabel · $pinLabel';
  String get targetKey => pinId ?? componentId ?? 'unknown_target';
  bool get hasSaveTarget => componentId != null || pinId != null;

  factory _MeasureSheetSelection.fromProject(ProjectState projectState) {
    final components = projectState.knownFacts.components;
    final component = components.isEmpty ? null : components.first;
    final componentLabel = component == null
        ? 'Koht puudub'
        : (component.designator?.isNotEmpty == true
            ? component.designator!
            : component.componentId);
    final pinLabel = _firstPinLabel(projectState.knownFacts, component);
    final measurement = _firstRelatedMeasurement(
      projectState.knownFacts,
      component,
      pinLabel,
    );

    return _MeasureSheetSelection(
      componentId: component?.componentId,
      pinId: pinLabel == 'jalg valimata' ? null : pinLabel,
      componentLabel: componentLabel,
      pinLabel: pinLabel,
      measurementLabel: _measurementLabel(measurement),
      measurementKind: _measurementKind(measurement),
      hasRecordedReading: measurement != null,
      projectLabel:
          '${projectState.manifest.deviceType} · ${projectState.manifest.model}',
    );
  }

  static String _firstPinLabel(
      KnownFacts knownFacts, ComponentFact? component) {
    if (component == null) {
      return 'jalg valimata';
    }
    final indexedPins = knownFacts.componentPinIndex[component.componentId];
    if (indexedPins != null && indexedPins.isNotEmpty) {
      return indexedPins.first;
    }
    for (final pin in knownFacts.pins) {
      if (pin.componentId == component.componentId) {
        return pin.pinId;
      }
    }
    return 'jalg valimata';
  }

  static MeasurementFact? _firstRelatedMeasurement(
    KnownFacts knownFacts,
    ComponentFact? component,
    String pinLabel,
  ) {
    if (component == null) {
      return null;
    }
    for (final measurement in knownFacts.measurements) {
      if (_targetMatches(measurement.from, component.componentId, pinLabel) ||
          _targetMatches(measurement.to, component.componentId, pinLabel)) {
        return measurement;
      }
    }
    return null;
  }

  static bool _targetMatches(
      String target, String componentId, String pinLabel) {
    return target == componentId ||
        target == pinLabel ||
        target.startsWith('$componentId.');
  }

  static String _measurementLabel(MeasurementFact? measurement) {
    if (measurement == null) {
      return 'sisesta mõõdetud väärtus';
    }
    if (measurement.value != null && measurement.unit != null) {
      return '${measurement.value} ${measurement.unit}';
    }
    return measurement.reading;
  }

  static String _measurementKind(MeasurementFact? measurement) {
    if (measurement == null) {
      return 'mõõtmine käsil';
    }
    return 'salvestatud lugem';
  }
}

class _SafetyBanner extends StatelessWidget {
  const _SafetyBanner({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Technician-first Measure Sheet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Project: ${selection.projectLabel}'),
            const SizedBox(height: 8),
            const Text('Human is the sensor. AI is the graph engine.'),
            const Text(
              'Save Measurement writes only after explicit human action.',
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitOption {
  const _UnitOption({
    required this.label,
    required this.mode,
    required this.schemaUnit,
  });

  final String label;
  final String mode;
  final String schemaUnit;
}

class _BoardContextPanel extends StatelessWidget {
  const _BoardContextPanel({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Board context',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('valitud Koht: ${selection.kohtLabel}'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ContextChip(label: selection.componentLabel),
                        _ContextChip(label: selection.pinLabel),
                        const _ContextChip(label: 'kasutaja valik'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Board context is display-only. It keeps selected Koht visible while measurement entry remains the primary flow.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NarrowBoardContext extends StatelessWidget {
  const _NarrowBoardContext({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Board context hidden on narrow width'),
            const SizedBox(height: 8),
            Text('Selected Koht: ${selection.kohtLabel}'),
          ],
        ),
      ),
    );
  }
}

class _MeasureSheetPanel extends StatelessWidget {
  const _MeasureSheetPanel({
    required this.selection,
    required this.valueController,
    required this.selectedUnit,
    required this.isSaving,
    required this.successMessage,
    required this.errorMessage,
    required this.canSave,
    required this.onValueChanged,
    required this.onUnitChanged,
    required this.onSave,
  });

  static const List<_UnitOption> _unitOptions = <_UnitOption>[
    _UnitOption(label: 'V', mode: 'voltage', schemaUnit: 'V'),
    _UnitOption(label: 'Ω', mode: 'resistance', schemaUnit: 'Ω'),
    _UnitOption(label: 'Diode', mode: 'diode', schemaUnit: 'diode'),
    _UnitOption(label: 'Beep', mode: 'continuity', schemaUnit: 'beep'),
  ];

  final _MeasureSheetSelection selection;
  final TextEditingController valueController;
  final _UnitOption? selectedUnit;
  final bool isSaving;
  final String? successMessage;
  final String? errorMessage;
  final bool canSave;
  final VoidCallback onValueChanged;
  final ValueChanged<_UnitOption?> onUnitChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Koht -> Väärtus -> Ühik -> Salvesta',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _FlowField(
              label: 'Koht',
              helper: 'kasutaja valik',
              value: selection.kohtLabel,
            ),
            _FlowField(
              label: 'Väärtus',
              helper: selection.measurementKind,
              value: selection.measurementLabel,
              leading: _RecordedReadingDot(
                hasRecordedReading: selection.hasRecordedReading,
              ),
            ),
            TextField(
              key: const ValueKey('measure-sheet-value-field'),
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'Mõõdetud väärtus',
                helperText: 'Sisesta oma mõõteriista lugem.',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              onChanged: (_) => onValueChanged(),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<_UnitOption>(
              key: const ValueKey('measure-sheet-unit-dropdown'),
              initialValue: selectedUnit,
              decoration: const InputDecoration(labelText: 'Ühik'),
              items: _unitOptions
                  .map(
                    (option) => DropdownMenuItem<_UnitOption>(
                      value: option,
                      child: Text(option.label),
                    ),
                  )
                  .toList(growable: false),
              onChanged: isSaving ? null : onUnitChanged,
            ),
            const SizedBox(height: 12),
            const _UnitDisplay(),
            const SizedBox(height: 12),
            ElevatedButton(
              key: const ValueKey('measure-sheet-save-button'),
              onPressed: canSave ? onSave : null,
              child: Text(isSaving ? 'Salvestan...' : 'Salvesta mõõtmine'),
            ),
            if (successMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                successMessage!,
                key: const ValueKey('measure-sheet-success-message'),
              ),
            ],
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                key: const ValueKey('measure-sheet-error-message'),
              ),
            ],
            const SizedBox(height: 8),
            const Text('Save uses the accepted V2 writer service.'),
            const Text(
                'recorded reading marker means only that a reading exists.'),
          ],
        ),
      ),
    );
  }
}

class _FlowField extends StatelessWidget {
  const _FlowField({
    required this.label,
    required this.helper,
    required this.value,
    this.leading,
  });

  final String label;
  final String helper;
  final String value;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        label: '$label, $helper, $value',
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 4),
                      Text(helper),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecordedReadingDot extends StatelessWidget {
  const _RecordedReadingDot({required this.hasRecordedReading});

  final bool hasRecordedReading;

  @override
  Widget build(BuildContext context) {
    final color = hasRecordedReading ? Colors.amber.shade700 : Colors.grey;
    final label = hasRecordedReading ? 'lugem olemas' : 'mõõtmine käsil';
    return Semantics(
      label: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: const SizedBox(width: 10, height: 10),
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _UnitDisplay extends StatelessWidget {
  const _UnitDisplay();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ühik', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ContextChip(label: 'V'),
                  _ContextChip(label: 'Ω'),
                  _ContextChip(label: 'Diode'),
                  _ContextChip(label: 'Beep'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferenceValuesPanel extends StatelessWidget {
  const _ReferenceValuesPanel({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reference Values Panel',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            const Text(
              'Display only: reads the current projection and writes nothing.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _HierarchyTile(
                  label: 'Mõõdetud',
                  value: selection.hasRecordedReading
                      ? selection.measurementLabel
                      : 'mõõdetud väärtus puudub',
                  body: 'human reading, visually dominant',
                  emphasis: true,
                ),
                const _HierarchyTile(
                  label: 'Viide / Allikas',
                  value: 'viiteväärtus puudub',
                  body: 'secondary context; not a measurement; non-canonical',
                ),
                const _HierarchyTile(
                  label: 'Kandidaat',
                  value: 'kandidaati pole',
                  body: 'tentative context only; not proof',
                ),
                const _HierarchyTile(
                  label: 'Märkus',
                  value: 'märkus puudub',
                  body: 'context only; does not create facts',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Reference/source, candidate, and note rows are context only and are not promoted to measured values.',
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidedMeasurementPanel extends StatelessWidget {
  const _GuidedMeasurementPanel({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guided Measurement Helper',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            const Text(
              'Read-only helper: suggests neutral next checks and writes nothing.',
            ),
            const SizedBox(height: 4),
            const Text('Human technician measures and decides.'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _GuidedPromptTile(
                  label: 'Next measurement',
                  value:
                      'Mõõda järgmisena ${selection.kohtLabel} seotud ots või testpunkt.',
                  body: 'suggestion only; technician must measure',
                ),
                const _GuidedPromptTile(
                  label: 'Missing reading',
                  value: 'Lugem puudub? Mõõda enne järeldust.',
                  body: 'prompt only; no conclusion',
                ),
                const _GuidedPromptTile(
                  label: 'Gap / conflict',
                  value:
                      'Kaks lugemit erinevad? Kontrolli uuesti enne järeldust.',
                  body: 'surface the gap; technician decides',
                ),
                const _GuidedPromptTile(
                  label: 'Source context',
                  value: 'Viide / Allikas on kontekst, mitte mõõtmine.',
                  body: 'context may guide a check but is not measured',
                ),
                const _GuidedPromptTile(
                  label: 'Candidate context',
                  value: 'Kandidaat on oletuslik kontekst, mitte tõend.',
                  body: 'context only; not a project fact',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Helper does not create canonical facts or change project data.',
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidedPromptTile extends StatelessWidget {
  const _GuidedPromptTile({
    required this.label,
    required this.value,
    required this.body,
  });

  final String label;
  final String value;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 6),
              Text(value),
              const SizedBox(height: 6),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}

class _HierarchyTile extends StatelessWidget {
  const _HierarchyTile({
    required this.label,
    required this.value,
    required this.body,
    this.emphasis = false,
  });

  final String label;
  final String value;
  final String body;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: emphasis
                ? Colors.amber.shade700
                : Theme.of(context).dividerColor,
            width: emphasis ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 6),
              Text(
                value,
                style: emphasis
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 6),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContextChip extends StatelessWidget {
  const _ContextChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
