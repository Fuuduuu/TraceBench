import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/services/v2_placement_writer.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/session/project_session.dart';
import '../theme/board_canvas_palette.dart';
import 'board_canvas_inspector_panel.dart';

@immutable
class PlacementTemplate {
  const PlacementTemplate(
      {required this.id,
      required this.displayName,
      required this.topContactMarkers,
      required this.rightContactMarkers,
      required this.bottomContactMarkers,
      required this.leftContactMarkers});
  final String id;
  final String displayName;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
}

@immutable
class PlacementSeed {
  const PlacementSeed(
      {required this.key,
      required this.componentLabel,
      required this.templateLabel,
      required this.boardSide,
      required this.rotationDeg,
      required this.width,
      required this.height,
      required this.template});
  final String key;
  final String componentLabel;
  final String templateLabel;
  final String boardSide;
  final num rotationDeg;
  final num? width;
  final num? height;
  final PlacementTemplate? template;
}

/// Host-resolved eligibility and center; both guard and request use this value.
@immutable
class PlacementSaveValues {
  const PlacementSaveValues(
      {required this.componentId,
      required this.coordinateSpace,
      required this.boardSide,
      required this.centerX,
      required this.centerY,
      required this.sourcePhotoId,
      required this.requiresExplicitAnchor});
  final String componentId;
  final String coordinateSpace;
  final String boardSide;
  final double? centerX;
  final double? centerY;
  final String? sourcePhotoId;
  final bool requiresExplicitAnchor;
}

/// Immutable read-only bridge to host catalogue previews and Canvas rendering.
@immutable
class PlacementDraftSnapshot {
  const PlacementDraftSnapshot(
      {required this.templateId,
      required this.label,
      required this.topContactMarkers,
      required this.rightContactMarkers,
      required this.bottomContactMarkers,
      required this.leftContactMarkers,
      required this.width,
      required this.height,
      required this.rotationDeg,
      required this.anchor,
      required this.canvasSize});
  final String? templateId;
  final String label;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final double width;
  final double height;
  final int rotationDeg;
  final Offset? anchor;
  final Size? canvasSize;
}

class BoardCanvasPlacementHolder extends ChangeNotifier {
  bool _disposed = false;
  String? _selectedAddComponentTemplateId;
  int _addComponentTemplateTopContactMarkers = 0;
  int _addComponentTemplateRightContactMarkers = 0;
  int _addComponentTemplateBottomContactMarkers = 0;
  int _addComponentTemplateLeftContactMarkers = 0;
  String _addComponentTemplateDraftLabel = '';
  double _addComponentTemplateDraftWidth = 1.0;
  double _addComponentTemplateDraftHeight = 0.6;
  int _addComponentTemplateDraftRotationDeg = 0;
  Offset? _addComponentTemplateGhostDraftAnchor;
  Size? _addComponentTemplateGhostDraftCanvasSize;
  String? _placementEditorDraftKey;
  PlacementEditorDraft? _placementEditorDraft;
  bool _addComponentPlacementSaveInFlight = false;
  String? _addComponentTemplateSaveStatusMessage;

  PlacementEditorDraft? get inspectorDraft => _placementEditorDraft;

  PlacementDraftSnapshot get ghostDraft => addDraft;

  PlacementDraftSnapshot get addDraft => PlacementDraftSnapshot(
        templateId: _selectedAddComponentTemplateId,
        label: _addComponentTemplateDraftLabel,
        topContactMarkers: _addComponentTemplateTopContactMarkers,
        rightContactMarkers: _addComponentTemplateRightContactMarkers,
        bottomContactMarkers: _addComponentTemplateBottomContactMarkers,
        leftContactMarkers: _addComponentTemplateLeftContactMarkers,
        width: _addComponentTemplateDraftWidth,
        height: _addComponentTemplateDraftHeight,
        rotationDeg: _addComponentTemplateDraftRotationDeg,
        anchor: _addComponentTemplateGhostDraftAnchor,
        canvasSize: _addComponentTemplateGhostDraftCanvasSize,
      );

  void _update(VoidCallback action) {
    if (_disposed) return;
    action();
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void beginUnplaced(String label) => _update(() {
        _selectedAddComponentTemplateId = null;
        _addComponentTemplateTopContactMarkers = 0;
        _addComponentTemplateRightContactMarkers = 0;
        _addComponentTemplateBottomContactMarkers = 0;
        _addComponentTemplateLeftContactMarkers = 0;
        _addComponentTemplateDraftLabel = label;
        _resetAddComponentTemplateLocalDraftScalars();
        _clearGhost();
        _addComponentTemplateSaveStatusMessage = null;
      });

  void _clearGhost() {
    _addComponentTemplateGhostDraftAnchor = null;
    _addComponentTemplateGhostDraftCanvasSize = null;
  }

  void _seedCounts(PlacementTemplate template) {
    _addComponentTemplateTopContactMarkers = template.topContactMarkers;
    _addComponentTemplateRightContactMarkers = template.rightContactMarkers;
    _addComponentTemplateBottomContactMarkers = template.bottomContactMarkers;
    _addComponentTemplateLeftContactMarkers = template.leftContactMarkers;
  }

  void _resetAddComponentTemplateLocalDraftScalars() {
    _addComponentTemplateDraftWidth = 1.0;
    _addComponentTemplateDraftHeight = 0.6;
    _addComponentTemplateDraftRotationDeg = 0;
  }

  void _seedAdd(PlacementSeed seed, {bool seedTemplate = true}) {
    final width = seed.width?.toDouble();
    final height = seed.height?.toDouble();
    _addComponentTemplateDraftWidth =
        width == null || !width.isFinite || width <= 0
            ? 1.0
            : _clampDimension(width);
    _addComponentTemplateDraftHeight =
        height == null || !height.isFinite || height <= 0
            ? 0.6
            : _clampDimension(height);
    _addComponentTemplateDraftRotationDeg =
        _normalizeRotation(seed.rotationDeg.round());
    _clearGhost();
    if (!seedTemplate) return;
    final template = seed.template;
    _selectedAddComponentTemplateId = template?.id;
    if (template != null) _seedCounts(template);
  }

  void seedAddFromPlacement(PlacementSeed seed) =>
      _update(() => _seedAdd(seed));

  void selectTemplate(PlacementTemplate template, PlacementSeed? seed) =>
      _update(() {
        _selectedAddComponentTemplateId = template.id;
        _seedCounts(template);
        if (seed == null) {
          _resetAddComponentTemplateLocalDraftScalars();
          _clearGhost();
        } else {
          _seedAdd(seed, seedTemplate: false);
        }
      });

  void changeTemplateSelection() => _update(() {
        _selectedAddComponentTemplateId = null;
        _clearGhost();
        _resetAddComponentTemplateLocalDraftScalars();
      });

  void resetToDefaults(PlacementTemplate template) => _update(() {
        _seedCounts(template);
        _resetAddComponentTemplateLocalDraftScalars();
        _clearGhost();
      });

  void setLabel(String value) =>
      _update(() => _addComponentTemplateDraftLabel = value);
  void setTopCount(int value) =>
      _update(() => _addComponentTemplateTopContactMarkers = value);
  void setRightCount(int value) =>
      _update(() => _addComponentTemplateRightContactMarkers = value);
  void setBottomCount(int value) =>
      _update(() => _addComponentTemplateBottomContactMarkers = value);
  void setLeftCount(int value) =>
      _update(() => _addComponentTemplateLeftContactMarkers = value);
  void setWidth(double value) =>
      _update(() => _addComponentTemplateDraftWidth = _clampDimension(value));
  void setHeight(double value) =>
      _update(() => _addComponentTemplateDraftHeight = _clampDimension(value));
  void setRotation(int value) => _update(
      () => _addComponentTemplateDraftRotationDeg = _normalizeRotation(value));
  void setGhostAnchor(Offset anchor, Size canvasSize) => _update(() {
        _addComponentTemplateGhostDraftAnchor = anchor;
        _addComponentTemplateGhostDraftCanvasSize = canvasSize;
      });

  double _clampDimension(double value) => value.clamp(0.2, 9.9).toDouble();
  int _normalizeRotation(int value) => ((value % 360) + 360) % 360;

  /// Eager build-time reseeding is silent, including while Inspector is hidden.
  void reseedInspector(PlacementSeed seed) {
    _placementEditorDraftFor(seed);
  }

  PlacementEditorDraft _placementEditorDraftFor(PlacementSeed seed) {
    if (_placementEditorDraftKey != seed.key || _placementEditorDraft == null) {
      _placementEditorDraftKey = seed.key;
      _placementEditorDraft = PlacementEditorDraft.fromSeed(seed);
    }
    return _placementEditorDraft!;
  }

  void _updateInspector(PlacementSeed seed,
          PlacementEditorDraft Function(PlacementEditorDraft) update) =>
      _update(() {
        final current = _placementEditorDraftFor(seed);
        _placementEditorDraft = update(current);
      });

  void _resetInspector(PlacementSeed seed) => _update(() {
        _placementEditorDraftKey = seed.key;
        _placementEditorDraft = PlacementEditorDraft.fromSeed(seed);
      });

  bool get _hasExcessiveCounts =>
      _addComponentTemplateTopContactMarkers > 8 ||
      _addComponentTemplateRightContactMarkers > 8 ||
      _addComponentTemplateBottomContactMarkers > 8 ||
      _addComponentTemplateLeftContactMarkers > 8;
  bool get _hasZeroMarkers =>
      _addComponentTemplateTopContactMarkers +
          _addComponentTemplateRightContactMarkers +
          _addComponentTemplateBottomContactMarkers +
          _addComponentTemplateLeftContactMarkers ==
      0;

  String? _addComponentTemplateCanonicalBoundsBlockReason(
      PlacementSaveValues target) {
    if (target.coordinateSpace.trim() != 'board_normalized') return null;
    final centerX = target.centerX;
    final centerY = target.centerY;
    if (centerX == null ||
        centerY == null ||
        !centerX.isFinite ||
        centerX < 0 ||
        centerX > 1 ||
        !centerY.isFinite ||
        centerY < 0 ||
        centerY > 1 ||
        !_addComponentTemplateDraftWidth.isFinite ||
        _addComponentTemplateDraftWidth <= 0 ||
        _addComponentTemplateDraftWidth > 1 ||
        !_addComponentTemplateDraftHeight.isFinite ||
        _addComponentTemplateDraftHeight <= 0 ||
        _addComponentTemplateDraftHeight > 1) {
      return 'Suurus või asukoht ei mahu plaadi piiridesse.';
    }
    return null;
  }

  String? _saveBlockReason(
      ProjectState projectState, PlacementSaveValues? target) {
    if (target == null) return 'Vali olemasolev komponent enne salvestamist.';
    if (_addComponentTemplateDraftLabel.trim().isEmpty) {
      return 'Lisa nimi enne salvestamist.';
    }
    if (target.requiresExplicitAnchor &&
        _addComponentTemplateGhostDraftAnchor == null) {
      return 'Vali canvasele paigutuse asukoht.';
    }
    final bounds = _addComponentTemplateCanonicalBoundsBlockReason(target);
    if (bounds != null) return bounds;
    final directory = projectState.projectDirectory;
    if (directory == null || directory.trim().isEmpty) {
      return 'Salvestamiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  void _showStatus(String message) =>
      _update(() => _addComponentTemplateSaveStatusMessage = message);

  Future<void> _confirmAddComponentTemplatePlacement({
    required ProjectState projectState,
    required PlacementSaveValues target,
    required PlacementTemplate template,
    required WidgetRef ref,
  }) async {
    if (_addComponentPlacementSaveInFlight) return;
    final bounds = _addComponentTemplateCanonicalBoundsBlockReason(target);
    if (bounds != null) {
      _showStatus(bounds);
      return;
    }
    if (target.centerX == null || target.centerY == null) {
      _showStatus('Vali canvasele paigutuse asukoht.');
      return;
    }
    final request = V2PlacementWriterRequest(
      componentId: target.componentId,
      coordinateSpace: target.coordinateSpace,
      boardSide: target.boardSide,
      centerX: target.centerX!,
      centerY: target.centerY!,
      rotationDeg: _addComponentTemplateDraftRotationDeg,
      width: _addComponentTemplateDraftWidth,
      height: _addComponentTemplateDraftHeight,
      templateId: template.id,
      sourcePhotoId: target.sourcePhotoId,
      clientOperationId: _placementClientOperationIdFor(target.componentId),
    );
    _update(() {
      _addComponentPlacementSaveInFlight = true;
      _addComponentTemplateSaveStatusMessage =
          'Salvestan valitud komponendi visuaalset paigutust...';
    });
    try {
      final projectSession = ref.read(projectStateProvider.notifier);
      final generation = projectSession.generation;
      final writer = ref.read(v2PlacementWriterProvider);
      final result = await writer.confirmPlacement(
          projectState: projectState, request: request);
      projectSession.applyCanonicalEvent(result.event, generation: generation);
      if (_disposed) return;
      _showStatus(result.appended
          ? 'Visuaalne paigutus salvestatud. Projektsioon vajab värskendamist.'
          : 'See visuaalne paigutus oli juba salvestatud. Projektsioon vajab värskendamist.');
    } on V2PlacementWriterException catch (error) {
      if (_disposed) return;
      _showStatus('Salvestamine ebaõnnestus: ${error.message}');
    } catch (error) {
      if (_disposed) return;
      _showStatus('Salvestamine ebaõnnestus: $error');
    } finally {
      if (!_disposed) _update(() => _addComponentPlacementSaveInFlight = false);
    }
  }

  String _placementClientOperationIdFor(String componentId) {
    final safeComponentId = componentId
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_visual_placement_${safeComponentId}_$timestamp';
  }
}

Widget buildBoardCanvasPlacementEditor(
    {required BoardCanvasPlacementHolder holder, required PlacementSeed seed}) {
  final draft = holder._placementEditorDraftFor(seed);
  return _PlacementEditorShellCard(
    draft: draft,
    onToggleSide: () => holder._updateInspector(
        seed,
        (draft) => draft.copyWith(
            boardSide: draft.boardSide.trim().toLowerCase() == 'top'
                ? 'bottom'
                : 'top')),
    onIncrementRotation: () => holder._updateInspector(
        seed, (draft) => draft.copyWith(rotationDeg: draft.rotationDeg + 15)),
    onIncrementWidth: () => holder._updateInspector(
        seed, (draft) => draft.copyWith(width: draft.width + 0.1)),
    onIncrementHeight: () => holder._updateInspector(
        seed, (draft) => draft.copyWith(height: draft.height + 0.1)),
    onReset: () => holder._resetInspector(seed),
    onDiscard: () => holder._resetInspector(seed),
  );
}

/// Resolve host-owned geometry again at confirmation, before any await.
List<Widget> buildBoardCanvasPlacementChildren(
  BuildContext context, {
  required BoardCanvasPlacementHolder holder,
  required ProjectState projectState,
  required PlacementSaveValues? Function(PlacementDraftSnapshot)
      resolveSaveValues,
  required PlacementSeed? placementSeed,
  required List<PlacementTemplate> templates,
  required Widget Function(BuildContext, String?, ValueChanged<String>)
      chooserBuilder,
  required Widget Function(BuildContext, String, VoidCallback)
      selectedSummaryBuilder,
  required Widget Function(BuildContext, PlacementDraftSnapshot)
      templatePreviewBuilder,
  required Widget Function(BuildContext, PlacementDraftSnapshot)
      draftPreviewBuilder,
  required String? saveContextLabel,
}) {
  final theme = Theme.of(context);
  final draft = holder.addDraft;
  final target = resolveSaveValues(draft);
  PlacementTemplate? selectedTemplate;
  for (final template in templates) {
    if (template.id == draft.templateId) {
      selectedTemplate = template;
      break;
    }
  }
  final saveBlockReason = selectedTemplate == null
      ? null
      : holder._saveBlockReason(projectState, target);
  final canConfirm = selectedTemplate != null &&
      saveBlockReason == null &&
      !holder._addComponentPlacementSaveInFlight;
  final saveBoundaryCopy = holder._addComponentPlacementSaveInFlight
      ? 'Salvestamine on pooleli...'
      : saveBlockReason ??
          'Salvesta kinnitab ainult valitud olemasoleva komponendi visuaalse paigutuse. Renderer/painter ei kirjuta.';
  final template = selectedTemplate;
  final onReset =
      template == null ? null : () => holder.resetToDefaults(template);
  void onTemplateSelected(String id) {
    for (final template in templates) {
      if (template.id == id) {
        holder.selectTemplate(template, placementSeed);
        return;
      }
    }
  }

  return <Widget>[
    const SizedBox(height: 10),
    const Divider(color: BoardCanvasPalette.rule, height: 1),
    const SizedBox(height: 8),
    if (selectedTemplate == null)
      chooserBuilder(context, draft.templateId, onTemplateSelected)
    else ...[
      selectedSummaryBuilder(
          context, selectedTemplate.id, holder.changeTemplateSelection),
      const SizedBox(height: 6),
      TextFormField(
        key: const Key(
          'board_canvas_add_component_template_draft_label_input',
        ),
        initialValue: draft.label,
        decoration: InputDecoration(
          isDense: true,
          labelText: 'Draft label',
          hintText: 'e.g. AGH789',
          labelStyle: theme.textTheme.labelSmall?.copyWith(
            color: BoardCanvasPalette.muted,
          ),
          hintStyle: theme.textTheme.bodySmall?.copyWith(
            color: BoardCanvasPalette.dim,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: BoardCanvasPalette.rule),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: BoardCanvasPalette.signal),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
        ),
        maxLength: 16,
        onChanged: holder.setLabel,
        textAlign: TextAlign.left,
        style: theme.textTheme.bodySmall?.copyWith(
          color: BoardCanvasPalette.navy,
        ),
      ),
      Consumer(
          builder: (context, ref, _) => _AddComponentTemplateBuilderPanel(
                key: const Key('board_canvas_add_component_template_builder'),
                templatePreview: templatePreviewBuilder(context, draft),
                draftPreview: draftPreviewBuilder(context, draft),
                topContactMarkers: draft.topContactMarkers,
                rightContactMarkers: draft.rightContactMarkers,
                bottomContactMarkers: draft.bottomContactMarkers,
                leftContactMarkers: draft.leftContactMarkers,
                draftWidth: draft.width,
                draftHeight: draft.height,
                draftRotationDeg: draft.rotationDeg,
                hasZeroContactMarkers: holder._hasZeroMarkers,
                hasExcessiveContactMarkers: holder._hasExcessiveCounts,
                onTopChanged: holder.setTopCount,
                onRightChanged: holder.setRightCount,
                onBottomChanged: holder.setBottomCount,
                onLeftChanged: holder.setLeftCount,
                onDraftWidthChanged: holder.setWidth,
                onDraftHeightChanged: holder.setHeight,
                onDraftRotationChanged: holder.setRotation,
                onResetToDefaults: onReset,
                onConfirmPlacement: canConfirm
                    ? () => holder._confirmAddComponentTemplatePlacement(
                          projectState: projectState,
                          target: resolveSaveValues(holder.ghostDraft)!,
                          template: template!,
                          ref: ref,
                        )
                    : null,
                saveBoundaryCopy: saveBoundaryCopy,
                saveContextLabel: saveContextLabel,
                saveStatusMessage:
                    holder._addComponentTemplateSaveStatusMessage,
              )),
    ],
    const SizedBox(height: 10),
    const Divider(color: BoardCanvasPalette.rule, height: 1),
    const SizedBox(height: 8),
  ];
}

class _AddComponentTemplateBuilderPanel extends StatelessWidget {
  const _AddComponentTemplateBuilderPanel({
    super.key,
    required this.templatePreview,
    required this.draftPreview,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    required this.draftWidth,
    required this.draftHeight,
    required this.draftRotationDeg,
    required this.hasZeroContactMarkers,
    required this.hasExcessiveContactMarkers,
    required this.onTopChanged,
    required this.onRightChanged,
    required this.onBottomChanged,
    required this.onLeftChanged,
    required this.onDraftWidthChanged,
    required this.onDraftHeightChanged,
    required this.onDraftRotationChanged,
    required this.onConfirmPlacement,
    required this.saveBoundaryCopy,
    this.saveContextLabel,
    this.saveStatusMessage,
    this.onResetToDefaults,
  });

  final Widget templatePreview;
  final Widget draftPreview;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final double draftWidth;
  final double draftHeight;
  final int draftRotationDeg;
  final bool hasZeroContactMarkers;
  final bool hasExcessiveContactMarkers;
  final ValueChanged<int> onTopChanged;
  final ValueChanged<int> onRightChanged;
  final ValueChanged<int> onBottomChanged;
  final ValueChanged<int> onLeftChanged;
  final ValueChanged<double> onDraftWidthChanged;
  final ValueChanged<double> onDraftHeightChanged;
  final ValueChanged<int> onDraftRotationChanged;
  final VoidCallback? onConfirmPlacement;
  final String saveBoundaryCopy;
  final String? saveContextLabel;
  final String? saveStatusMessage;
  final VoidCallback? onResetToDefaults;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: const Key('board_canvas_add_component_builder_card'),
      margin: EdgeInsets.zero,
      color: BoardCanvasPalette.tile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: BoardCanvasPalette.rule),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pin-asetus',
              key: const Key(
                'board_canvas_add_component_builder_pin_layout_heading',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.signal,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'UI-local marker draft',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: BoardCanvasPalette.navy,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'UI-local markers',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Kontaktid on lokaalne mustand; neid ei kinnitata elektriliste kontaktidena.',
              key: const Key(
                'board_canvas_add_component_builder_local_contact_boundary',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.navy,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Per-side markers are UI-local; not confirmed contacts.',
              key: const Key(
                'board_canvas_add_component_builder_local_marker_boundary',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.muted,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              key: const Key('board_canvas_add_component_builder_visual_body'),
              height: 148,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: _ContactMarkerCountRow(
                        controlKey: const Key(
                          'board_canvas_add_component_builder_top_control',
                        ),
                        side: 'Top',
                        sideKey: 'top',
                        value: topContactMarkers,
                        onChanged: (value) {
                          if (value < 0) {
                            return;
                          }
                          onTopChanged(value);
                        },
                        axis: Axis.horizontal,
                        showLabel: false,
                        compact: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 58,
                          child: Center(
                            child: _ContactMarkerCountRow(
                              controlKey: const Key(
                                'board_canvas_add_component_builder_left_control',
                              ),
                              side: 'Left',
                              sideKey: 'left',
                              value: leftContactMarkers,
                              onChanged: (value) {
                                if (value < 0) {
                                  return;
                                }
                                onLeftChanged(value);
                              },
                              axis: Axis.vertical,
                              showLabel: false,
                              compact: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 140,
                                maxHeight: 82,
                              ),
                              child: templatePreview,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 58,
                          child: Center(
                            child: _ContactMarkerCountRow(
                              controlKey: const Key(
                                'board_canvas_add_component_builder_right_control',
                              ),
                              side: 'Right',
                              sideKey: 'right',
                              value: rightContactMarkers,
                              onChanged: (value) {
                                if (value < 0) {
                                  return;
                                }
                                onRightChanged(value);
                              },
                              axis: Axis.vertical,
                              showLabel: false,
                              compact: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: _ContactMarkerCountRow(
                        controlKey: const Key(
                          'board_canvas_add_component_builder_bottom_control',
                        ),
                        side: 'Bottom',
                        sideKey: 'bottom',
                        value: bottomContactMarkers,
                        onChanged: (value) =>
                            onBottomChanged(value < 0 ? 0 : value),
                        axis: Axis.horizontal,
                        showLabel: false,
                        compact: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (onResetToDefaults != null)
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 24,
                  child: TextButton(
                    key: const Key(
                      'board_canvas_add_component_builder_reset_to_defaults',
                    ),
                    onPressed: onResetToDefaults,
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                      minimumSize: const Size(0, 24),
                      textStyle: theme.textTheme.labelSmall,
                      foregroundColor: BoardCanvasPalette.muted,
                    ),
                    child: const Text('Reset to template defaults'),
                  ),
                ),
              ),
            if (hasZeroContactMarkers)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'No visual contact markers configured.',
                  key: const Key(
                    'board_canvas_add_component_builder_zero_markers_hint',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            if (hasExcessiveContactMarkers)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Excessive contact marker counts may be invalid.',
                  key: const Key(
                    'board_canvas_add_component_builder_excessive_markers_hint',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.tertiary,
                  ),
                  maxLines: 2,
                ),
              ),
            const SizedBox(height: 6),
            _AddComponentDraftSizeControls(
              draftWidth: draftWidth,
              draftHeight: draftHeight,
              onWidthChanged: onDraftWidthChanged,
              onHeightChanged: onDraftHeightChanged,
            ),
            const SizedBox(height: 6),
            _AddComponentDraftRotationControls(
              rotationDeg: draftRotationDeg,
              onRotationChanged: onDraftRotationChanged,
            ),
            const SizedBox(height: 6),
            draftPreview,
            const SizedBox(height: 6),
            Text(
              'Mustand on lokaalne kuni salvestamiseni.',
              key: const Key(
                'board_canvas_add_component_builder_local_draft_copy',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.navy,
              ),
            ),
            Text(
              'Kontaktid ei kinnita elektrilist ühendust.',
              key: const Key(
                'board_canvas_add_component_builder_no_connectivity_copy',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.navy,
              ),
            ),
            DecoratedBox(
              key: const Key(
                'board_canvas_add_component_builder_save_boundary_notice',
              ),
              decoration: BoxDecoration(
                color: BoardCanvasPalette.tile,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: BoardCanvasPalette.rule),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 7,
                ),
                child: Text(
                  saveBoundaryCopy,
                  key: const Key(
                    'board_canvas_add_component_builder_save_boundary_copy',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Text(
              saveContextLabel == null
                  ? 'Valitud komponent: puudub'
                  : 'Valitud komponent: $saveContextLabel',
              key: const Key(
                'board_canvas_add_component_builder_save_context',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.muted,
              ),
            ),
            if (saveStatusMessage != null)
              Text(
                saveStatusMessage!,
                key: const Key(
                  'board_canvas_add_component_builder_save_status',
                ),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: BoardCanvasPalette.signal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            const SizedBox(height: 6),
            _AddComponentDraftActionBar(
              onResetToDefaults: onResetToDefaults,
              onConfirmPlacement: onConfirmPlacement,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddComponentDraftSizeControls extends StatelessWidget {
  const _AddComponentDraftSizeControls({
    required this.draftWidth,
    required this.draftHeight,
    required this.onWidthChanged,
    required this.onHeightChanged,
  });

  final double draftWidth;
  final double draftHeight;
  final ValueChanged<double> onWidthChanged;
  final ValueChanged<double> onHeightChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const Key('board_canvas_add_component_builder_size_section'),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BoardCanvasPalette.paper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suurus',
            style: theme.textTheme.titleSmall?.copyWith(
              color: BoardCanvasPalette.navy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          _AddComponentDraftScalarControl(
            label: 'Laius',
            valueText: draftWidth.toStringAsFixed(2),
            decrementKey: const Key(
              'board_canvas_add_component_builder_width_decrement',
            ),
            valueKey:
                const Key('board_canvas_add_component_builder_width_value'),
            incrementKey: const Key(
              'board_canvas_add_component_builder_width_increment',
            ),
            onDecrement: () => onWidthChanged(draftWidth - 0.1),
            onIncrement: () => onWidthChanged(draftWidth + 0.1),
          ),
          const SizedBox(height: 4),
          _AddComponentDraftScalarControl(
            label: 'Kõrgus',
            valueText: draftHeight.toStringAsFixed(2),
            decrementKey: const Key(
              'board_canvas_add_component_builder_height_decrement',
            ),
            valueKey:
                const Key('board_canvas_add_component_builder_height_value'),
            incrementKey: const Key(
              'board_canvas_add_component_builder_height_increment',
            ),
            onDecrement: () => onHeightChanged(draftHeight - 0.1),
            onIncrement: () => onHeightChanged(draftHeight + 0.1),
          ),
          const SizedBox(height: 4),
          Text(
            'Lohista nurgast suuruse muutmiseks',
            key: const Key(
              'board_canvas_add_component_builder_resize_hint',
            ),
            style: theme.textTheme.labelSmall?.copyWith(
              color: BoardCanvasPalette.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddComponentDraftRotationControls extends StatelessWidget {
  const _AddComponentDraftRotationControls({
    required this.rotationDeg,
    required this.onRotationChanged,
  });

  final int rotationDeg;
  final ValueChanged<int> onRotationChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const Key('board_canvas_add_component_builder_rotation_section'),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BoardCanvasPalette.paper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pööramine',
            style: theme.textTheme.titleSmall?.copyWith(
              color: BoardCanvasPalette.navy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Pööre: $rotationDeg°',
            key: const Key(
              'board_canvas_add_component_builder_rotation_value',
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: BoardCanvasPalette.navy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final snap in const [0, 90, 180, 270])
                _AddComponentDraftChipButton(
                  key: Key(
                    'board_canvas_add_component_builder_rotation_snap_$snap',
                  ),
                  label: '$snap°',
                  onPressed: () => onRotationChanged(snap),
                  minWidth: 52,
                  minHeight: 32,
                  foregroundColor: BoardCanvasPalette.navy,
                  backgroundColor: BoardCanvasPalette.signalTint,
                  borderColor: BoardCanvasPalette.ruleStrong,
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Peenhäälestus',
            style: theme.textTheme.labelSmall?.copyWith(
              color: BoardCanvasPalette.muted,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: [
              _AddComponentDraftChipButton(
                key: const Key(
                  'board_canvas_add_component_builder_rotation_decrement',
                ),
                label: '−10°',
                onPressed: () => onRotationChanged(rotationDeg - 10),
                minHeight: 26,
                foregroundColor: BoardCanvasPalette.muted,
                borderColor: BoardCanvasPalette.rule,
              ),
              _AddComponentDraftChipButton(
                key: const Key(
                  'board_canvas_add_component_builder_rotation_increment',
                ),
                label: '+10°',
                onPressed: () => onRotationChanged(rotationDeg + 10),
                minHeight: 26,
                foregroundColor: BoardCanvasPalette.muted,
                borderColor: BoardCanvasPalette.rule,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddComponentDraftActionBar extends StatelessWidget {
  const _AddComponentDraftActionBar({
    required this.onResetToDefaults,
    required this.onConfirmPlacement,
  });

  final VoidCallback? onResetToDefaults;
  final VoidCallback? onConfirmPlacement;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      key: const Key('board_canvas_add_component_builder_action_bar'),
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        _AddComponentDraftChipButton(
          key: const Key('board_canvas_add_component_builder_save'),
          label: 'Salvesta',
          onPressed: onConfirmPlacement,
          minWidth: 74,
          minHeight: 38,
          foregroundColor: BoardCanvasPalette.signal,
          backgroundColor: BoardCanvasPalette.signalTint,
          borderColor: BoardCanvasPalette.signal.withValues(alpha: 0.7),
          disabledForegroundColor: BoardCanvasPalette.muted,
          disabledBackgroundColor: BoardCanvasPalette.tile,
          disabledBorderColor: BoardCanvasPalette.ruleStrong,
        ),
        const _AddComponentDraftChipButton(
          key: Key('board_canvas_add_component_builder_local_edit'),
          label: 'Muuda (tulekul)',
          onPressed: null,
          minWidth: 68,
          minHeight: 38,
          foregroundColor: Color(0xFFF6C453),
          backgroundColor: Color(0xFF231B0A),
          borderColor: Color(0xFF66501D),
        ),
        _AddComponentDraftChipButton(
          key: const Key('board_canvas_add_component_builder_delete'),
          label: 'Kustuta mustand',
          onPressed: onResetToDefaults,
          minWidth: 74,
          minHeight: 38,
          foregroundColor: const Color(0xFFEAA6A6),
          backgroundColor: const Color(0xFF211417),
          borderColor: const Color(0xFF493039),
        ),
        const _AddComponentDraftChipButton(
          key: Key('board_canvas_add_component_builder_cancel'),
          label: 'Tühista (pole aktiivne)',
          onPressed: null,
          minWidth: 74,
          minHeight: 38,
          foregroundColor: BoardCanvasPalette.navy,
          backgroundColor: BoardCanvasPalette.paper,
          borderColor: BoardCanvasPalette.ruleStrong,
        ),
      ],
    );
  }
}

class _AddComponentDraftScalarControl extends StatelessWidget {
  const _AddComponentDraftScalarControl({
    required this.label,
    required this.valueText,
    required this.decrementKey,
    required this.valueKey,
    required this.incrementKey,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final String valueText;
  final Key decrementKey;
  final Key valueKey;
  final Key incrementKey;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: BoardCanvasPalette.tile,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: BoardCanvasPalette.navy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            key: decrementKey,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 30, height: 30),
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(30, 30),
              maximumSize: const Size(30, 30),
              foregroundColor: const Color(0xFFEAA6A6),
              backgroundColor: const Color(0xFF211417),
            ),
            tooltip: 'Vähenda $label',
            onPressed: onDecrement,
            icon: const Icon(Icons.remove_circle_outline),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: BoardCanvasPalette.shell,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: BoardCanvasPalette.ruleStrong),
              ),
              child: Text(
                valueText,
                key: valueKey,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: BoardCanvasPalette.navy,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            key: incrementKey,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 30, height: 30),
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(30, 30),
              maximumSize: const Size(30, 30),
              foregroundColor: BoardCanvasPalette.signal,
              backgroundColor: BoardCanvasPalette.signalTint,
            ),
            tooltip: 'Suurenda $label',
            onPressed: onIncrement,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}

class _AddComponentDraftChipButton extends StatelessWidget {
  const _AddComponentDraftChipButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.disabledBorderColor,
    this.minWidth = 0,
    this.minHeight = 28,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledBorderColor;
  final double minWidth;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        minimumSize: Size(minWidth, minHeight),
        maximumSize: Size(math.max(minWidth, 120), minHeight),
        foregroundColor: foregroundColor ?? BoardCanvasPalette.navy,
        backgroundColor: backgroundColor ?? Colors.transparent,
        disabledForegroundColor:
            disabledForegroundColor ?? BoardCanvasPalette.dim,
        disabledBackgroundColor: disabledBackgroundColor ?? Colors.transparent,
        side: BorderSide(
          color: onPressed == null
              ? disabledBorderColor ?? BoardCanvasPalette.rule
              : borderColor ?? BoardCanvasPalette.ruleStrong,
        ),
        textStyle: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Text(label),
    );
  }
}

class _ContactMarkerCountRow extends StatelessWidget {
  const _ContactMarkerCountRow({
    this.controlKey,
    required this.side,
    required this.sideKey,
    required this.value,
    required this.onChanged,
    this.axis = Axis.horizontal,
    this.showLabel = true,
    this.compact = false,
  });

  final Key? controlKey;
  final String side;
  final String sideKey;
  final int value;
  final ValueChanged<int> onChanged;
  final Axis axis;
  final bool showLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = Text(
      side,
      style: theme.textTheme.labelSmall?.copyWith(
        color: BoardCanvasPalette.muted,
        fontSize: 10,
      ),
    );

    final controls = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 16,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 16, height: 16),
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(16, 16),
            foregroundColor: BoardCanvasPalette.muted,
            disabledForegroundColor: BoardCanvasPalette.dim,
          ),
          onPressed: value <= 0 ? null : () => onChanged(value - 1),
          icon: const Icon(Icons.remove_circle_outline),
          tooltip: 'Decrease $side contact markers',
          key: Key(
            'board_canvas_add_component_template_builder_${sideKey}_decrement',
          ),
        ),
        Container(
          width: 20,
          alignment: Alignment.center,
          child: Text(
            value.toString(),
            key: Key(
              'board_canvas_add_component_template_builder_${sideKey}_value',
            ),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: BoardCanvasPalette.navy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          iconSize: 16,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 16, height: 16),
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(16, 16),
            foregroundColor: BoardCanvasPalette.muted,
          ),
          onPressed: () => onChanged(value + 1),
          icon: const Icon(Icons.add_circle_outline),
          tooltip: 'Increase $side contact markers',
          key: Key(
            'board_canvas_add_component_template_builder_${sideKey}_increment',
          ),
        ),
      ],
    );

    if (!showLabel) {
      return Container(
        key: controlKey,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: controls,
      );
    }

    if (axis == Axis.horizontal) {
      return Row(
        key: controlKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!compact)
            SizedBox(
              width: 34,
              child: label,
            ),
          if (!compact) const SizedBox(width: 2),
          controls,
        ],
      );
    }

    return Column(
      key: controlKey,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!compact) label,
        if (!compact) const SizedBox(height: 2),
        controls,
      ],
    );
  }
}

class PlacementEditorDraft {
  const PlacementEditorDraft({
    required this.componentLabel,
    required this.boardSide,
    required this.templateLabel,
    required this.rotationDeg,
    required this.width,
    required this.height,
  });

  factory PlacementEditorDraft.fromSeed(PlacementSeed seed) {
    final width = seed.width?.toDouble();
    final height = seed.height?.toDouble();
    return PlacementEditorDraft(
      componentLabel: seed.componentLabel,
      boardSide: seed.boardSide.trim().isEmpty ? 'top' : seed.boardSide.trim(),
      templateLabel: seed.templateLabel,
      rotationDeg: seed.rotationDeg.toDouble(),
      width: width == null || !width.isFinite || width <= 0 ? 1.0 : width,
      height: height == null || !height.isFinite || height <= 0 ? 0.6 : height,
    );
  }

  final String componentLabel;
  final String boardSide;
  final String templateLabel;
  final double rotationDeg;
  final double width;
  final double height;

  PlacementEditorDraft copyWith({
    String? boardSide,
    double? rotationDeg,
    double? width,
    double? height,
  }) {
    return PlacementEditorDraft(
      componentLabel: componentLabel,
      boardSide: boardSide ?? this.boardSide,
      templateLabel: templateLabel,
      rotationDeg: rotationDeg ?? this.rotationDeg,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

class _PlacementEditorShellCard extends StatelessWidget {
  const _PlacementEditorShellCard({
    required this.draft,
    required this.onToggleSide,
    required this.onIncrementRotation,
    required this.onIncrementWidth,
    required this.onIncrementHeight,
    required this.onReset,
    required this.onDiscard,
  });

  final PlacementEditorDraft draft;
  final VoidCallback? onToggleSide;
  final VoidCallback? onIncrementRotation;
  final VoidCallback? onIncrementWidth;
  final VoidCallback? onIncrementHeight;
  final VoidCallback? onReset;
  final VoidCallback? onDiscard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final boundaryTextStyle = theme.textTheme.bodySmall?.copyWith(
      color: BoardCanvasPalette.navy,
      fontWeight: FontWeight.w600,
      height: 1.25,
    );
    return Card(
      key: const Key('board_canvas_placement_editor_shell'),
      color: BoardCanvasPalette.tile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: BoardCanvasPalette.rule),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InspectorSectionHeader(
              title: 'Placement draft',
              tag: 'LOCAL',
            ),
            const SizedBox(height: 6),
            Text(
              'unsaved/session-only',
              key: const Key('board_canvas_placement_draft_session_only'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: BoardCanvasPalette.signal,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Draft changes stay in memory only.',
              style: boundaryTextStyle,
            ),
            Text(
              'Canonical projection remains unchanged.',
              style: boundaryTextStyle,
            ),
            Text(
              'Canonical write unavailable in this pass.',
              style: boundaryTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              'Selected component: ${draft.componentLabel}',
              key: const Key('board_canvas_placement_draft_component'),
            ),
            Text(
              'Board side draft: ${draft.boardSide}',
              key: const Key('board_canvas_placement_draft_side'),
            ),
            Text(
              'Shape/template draft: ${draft.templateLabel}',
              key: const Key('board_canvas_placement_draft_template'),
            ),
            Text(
              'Rotation draft: ${_formatPlacementDraftRotation(draft.rotationDeg)} deg',
              key: const Key('board_canvas_placement_draft_rotation'),
            ),
            Text(
              'Width draft: ${_formatPlacementDraftSize(draft.width)}',
              key: const Key('board_canvas_placement_draft_width'),
            ),
            Text(
              'Height draft: ${_formatPlacementDraftSize(draft.height)}',
              key: const Key('board_canvas_placement_draft_height'),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _PlacementDraftButton(
                  buttonKey:
                      const Key('board_canvas_placement_draft_side_toggle'),
                  label: 'Toggle side',
                  onPressed: onToggleSide,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key(
                    'board_canvas_placement_draft_rotation_increment',
                  ),
                  label: 'Rotate +15',
                  onPressed: onIncrementRotation,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key(
                    'board_canvas_placement_draft_width_increment',
                  ),
                  label: 'Width +0.10',
                  onPressed: onIncrementWidth,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key(
                    'board_canvas_placement_draft_height_increment',
                  ),
                  label: 'Height +0.10',
                  onPressed: onIncrementHeight,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key('board_canvas_placement_draft_cancel'),
                  label: 'Cancel local draft',
                  onPressed: onReset,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key('board_canvas_placement_draft_reset'),
                  label: 'Reset local draft',
                  onPressed: onReset,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key('board_canvas_placement_draft_discard'),
                  label: 'Discard local draft',
                  onPressed: onDiscard,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacementDraftButton extends StatelessWidget {
  const _PlacementDraftButton({
    required this.buttonKey,
    required this.label,
    required this.onPressed,
  });

  final Key buttonKey;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: buttonKey,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(0, 28),
        textStyle: theme.textTheme.labelSmall,
        foregroundColor: BoardCanvasPalette.signal,
        disabledForegroundColor: BoardCanvasPalette.dim,
      ),
      child: Text(label),
    );
  }
}

String _formatPlacementDraftRotation(double value) {
  if (!value.isFinite) {
    return '0';
  }
  final rounded = value.roundToDouble();
  if ((value - rounded).abs() < 0.001) {
    return rounded.toInt().toString();
  }
  return value.toStringAsFixed(1);
}

String _formatPlacementDraftSize(double value) {
  if (!value.isFinite) {
    return '0.00';
  }
  return value.toStringAsFixed(2);
}
