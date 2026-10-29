import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../shared/geometry/wizard_candidate_geometry.dart';
import '../../../shared/models/wizard_intake.dart';
import '../../../shared/theme/app_theme.dart';
import '../../project/widgets/wizard_compact_widgets.dart';
import '../models/component_candidate_draft.dart';

/// UI-local authoring only. Callers own creation, project loading and storage.
class ComponentCandidateEditorController extends ChangeNotifier {
  ComponentCandidateEditorController(this._document);

  ComponentCandidateDocument _document;
  ComponentCandidateDocument get document => _document;
  int? selectedDraftKey;
  WizardVisualCandidateShape currentShape = WizardVisualCandidateShape.circle;
  double currentSizeScale = 1;
  double currentRotation = 0;
  bool isDragging = false;

  ComponentCandidateDraft? get selected {
    for (final candidate in _document.candidates) {
      if (candidate.draftKey == selectedDraftKey) return candidate;
    }
    return null;
  }

  void replaceDocument(ComponentCandidateDocument value) {
    _document = value;
    selectedDraftKey = null;
    currentShape = WizardVisualCandidateShape.circle;
    currentSizeScale = 1;
    currentRotation = 0;
    isDragging = false;
    notifyListeners();
  }

  void select(int? key) {
    selectedDraftKey = key;
    final candidate = selected;
    if (candidate != null) {
      currentShape = candidate.shape;
      currentSizeScale = candidate.sizeScale;
      currentRotation = candidate.rotationRadians;
    }
    notifyListeners();
  }

  void addAt(Offset point) {
    final key = _document.nextDraftKey;
    final candidate = ComponentCandidateDraft(
      draftKey: key,
      position: point,
      shape: currentShape,
      sizeScale: currentSizeScale,
      rotationRadians: currentRotation,
    );
    _document = _document.copyWith(
      candidates: [..._document.candidates, candidate],
      nextDraftKey: key + 1,
    );
    selectedDraftKey = key;
    notifyListeners();
  }

  void _updateSelected(
      ComponentCandidateDraft Function(ComponentCandidateDraft) edit) {
    if (selected != null) {
      _document = _document.copyWith(candidates: [
        for (final candidate in _document.candidates)
          candidate.draftKey == selectedDraftKey ? edit(candidate) : candidate,
      ]);
    }
    notifyListeners();
  }

  void setShape(WizardVisualCandidateShape shape) {
    if (shape == currentShape) return;
    currentShape = shape;
    _updateSelected((candidate) => candidate.copyWith(shape: shape));
  }

  void setSizeScale(double value) {
    if (!value.isFinite) return;
    final next = value.clamp(.5, 2.5).toDouble();
    if (next == currentSizeScale) return;
    currentSizeScale = next;
    _updateSelected(
        (candidate) => candidate.copyWith(sizeScale: currentSizeScale));
  }

  void setRotation(double value) {
    if (!value.isFinite) return;
    final next = (value + math.pi) % (2 * math.pi) - math.pi;
    if (next == currentRotation) return;
    currentRotation = next;
    _updateSelected(
        (candidate) => candidate.copyWith(rotationRadians: currentRotation));
  }

  void moveSelected(Offset point) {
    if (selected?.position == point) return;
    _updateSelected((candidate) => candidate.copyWith(position: point));
  }

  void deleteSelected() {
    if (selected == null) return;
    _document = _document.copyWith(candidates: [
      for (final candidate in _document.candidates)
        if (candidate.draftKey != selectedDraftKey) candidate,
    ]);
    selectedDraftKey = null;
    notifyListeners();
  }

  WizardCandidateGeometry geometryFor(
          ComponentCandidateDraft candidate, Rect frame) =>
      WizardCandidateGeometry.resolve(
        referenceRect: frame,
        normalizedCenter: candidate.position,
        shape: candidate.shape,
        sizeScale: candidate.sizeScale,
        rotationRadians: candidate.rotationRadians,
      );

  int? hitTest(Offset position, Rect frame) {
    if (!frame.contains(position)) return null;
    int? found;
    var distance = double.infinity;
    // Nearest center wins in overlapping touch targets; last painted wins a tie.
    for (final candidate in _document.candidates) {
      final geometry = geometryFor(candidate, frame);
      final nextDistance = (geometry.center - position).distanceSquared;
      if (geometry.hitBounds.contains(position) && nextDistance <= distance) {
        found = candidate.draftKey;
        distance = nextDistance;
      }
    }
    return found;
  }
}

String componentCandidateShapeLabel(WizardVisualCandidateShape shape) =>
    switch (shape) {
      WizardVisualCandidateShape.circle => 'Ümar',
      WizardVisualCandidateShape.square => 'Ruut',
      WizardVisualCandidateShape.rectangle => 'Ristkülik',
      WizardVisualCandidateShape.roundedRectangle => 'Ümardatud ristkülik',
    };

/// Two presentation slots of the same editor, sharing one caller-owned controller.
/// This lets each workbench keep its own photo, contour and responsive layout.
class ComponentCandidateEditor extends StatefulWidget {
  const ComponentCandidateEditor.surface({
    super.key,
    required this.controller,
    required this.referenceRect,
    this.keyPrefix = 'candidate',
    this.enabled = true,
    this.allowAdd = true,
    this.onSelectionChanged,
    this.onEditCompleted,
    this.inputKey,
    this.canInteractAt,
  })  : controls = false,
        contourClosed = false;

  const ComponentCandidateEditor.controls({
    super.key,
    required this.controller,
    this.keyPrefix = 'candidate',
    this.enabled = true,
    this.contourClosed = false,
    this.onEditCompleted,
  })  : referenceRect = null,
        controls = true,
        allowAdd = false,
        onSelectionChanged = null,
        inputKey = null,
        canInteractAt = null;

  final ComponentCandidateEditorController controller;
  final Rect? referenceRect;
  final String keyPrefix;
  final bool controls;
  final bool enabled;
  final bool allowAdd;
  final bool contourClosed;
  final VoidCallback? onSelectionChanged;
  final VoidCallback? onEditCompleted;
  final Key? inputKey;
  final bool Function(Offset)? canInteractAt;

  @override
  State<ComponentCandidateEditor> createState() =>
      _ComponentCandidateEditorState();
}

class _ComponentCandidateEditorState extends State<ComponentCandidateEditor> {
  int? _pointer;
  int? _downKey;
  bool _moved = false;
  ComponentCandidateEditorController get editor => widget.controller;
  ValueKey<String> keyFor(String suffix) =>
      ValueKey('${widget.keyPrefix}-$suffix');

  void edit(VoidCallback action) {
    final before = editor.document;
    action();
    if (!identical(before, editor.document)) widget.onEditCompleted?.call();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: editor,
        builder: (context, _) => widget.controls ? _controls() : _surface(),
      );

  Widget _surface() {
    final frame = widget.referenceRect!;
    final painter = ComponentCandidatePainter(
      candidates: editor.document.candidates,
      selectedDraftKey: editor.selectedDraftKey,
      referenceRect: frame,
      interactive: widget.enabled,
      allowAdd: widget.allowAdd,
      canInteractAt: widget.canInteractAt,
    );
    return Semantics(
      label: 'Komponentide asetuse redaktor',
      value: '${editor.document.candidates.length} kandidaati, '
          '${editor.selectedDraftKey == null ? 'valik puudub' : 'kandidaat ${editor.selectedDraftKey} valitud'}',
      child: Listener(
        onPointerDown: !widget.enabled
            ? null
            : (event) {
                if (_pointer != null) return;
                final key = editor.hitTest(event.localPosition, frame);
                _downKey = key;
                if (key == null) return;
                _pointer = event.pointer;
                _moved = false;
                editor.isDragging = true;
                editor.select(key);
                widget.onSelectionChanged?.call();
              },
        onPointerMove: !widget.enabled
            ? null
            : (event) {
                if (event.pointer != _pointer) return;
                final point = event.localPosition;
                if (frame.width <= 0 ||
                    frame.height <= 0 ||
                    !frame.contains(point)) {
                  return;
                }
                editor.moveSelected(Offset(
                  ((point.dx - frame.left) / frame.width).clamp(0.0, 1.0),
                  ((point.dy - frame.top) / frame.height).clamp(0.0, 1.0),
                ));
                _moved = true;
              },
        onPointerUp: (event) {
          if (event.pointer != _pointer) return;
          _pointer = null;
          editor.isDragging = false;
          editor.select(editor.selectedDraftKey);
          if (_moved) widget.onEditCompleted?.call();
        },
        onPointerCancel: (event) {
          if (event.pointer != _pointer) return;
          _pointer = null;
          editor.isDragging = false;
          editor.select(editor.selectedDraftKey);
          if (_moved) widget.onEditCompleted?.call();
        },
        child: GestureDetector(
          key: widget.inputKey ?? keyFor('canvas'),
          // The painter only intercepts candidates (or the reference in Add).
          behavior: HitTestBehavior.deferToChild,
          onPanStart: widget.enabled ? (_) {} : null,
          onTapUp: !widget.enabled
              ? null
              : (event) {
                  if (!frame.contains(event.localPosition)) return;
                  final key =
                      _downKey ?? editor.hitTest(event.localPosition, frame);
                  if (key != null) {
                    editor.select(key);
                    widget.onSelectionChanged?.call();
                  } else if (widget.allowAdd) {
                    edit(() => editor.addAt(Offset(
                          (event.localPosition.dx - frame.left) / frame.width,
                          (event.localPosition.dy - frame.top) / frame.height,
                        )));
                    widget.onSelectionChanged?.call();
                  }
                },
          child: CustomPaint(
            key: keyFor('painter'),
            painter: painter,
            size: Size.infinite,
          ),
        ),
      ),
    );
  }

  Widget _controls() {
    final count = editor.document.candidates.length;
    final selectedKey = editor.selectedDraftKey;
    final size = (editor.currentSizeScale * 100).round();
    final rotation = (editor.currentRotation * 180 / math.pi).round();
    final signed = rotation > 0 ? '+$rotation' : '$rotation';
    final summary = '${selectedKey == null ? 'Järgmine' : 'Valitud'}: '
        '${componentCandidateShapeLabel(editor.currentShape)} · $size% · $rotation°';
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: WorkbenchColors.paper,
        border: Border.all(color: WorkbenchColors.rule),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          key: keyFor('status'),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: WorkbenchColors.navyDeep,
            border: Border.all(color: WorkbenchColors.rule),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: _stateRow('count', Icons.widgets_outlined,
                      '$count komponent-kandidaa${count == 1 ? 't' : 'ti'}')),
              const SizedBox(width: 8),
              Expanded(
                  child: _stateRow(
                      'selection',
                      Icons.ads_click_outlined,
                      selectedKey == null
                          ? 'Ühtegi kandidaati pole valitud'
                          : 'Kandidaat $selectedKey valitud')),
            ]),
            const SizedBox(height: 7),
            _stateRow(
                'contour-guide',
                Icons.visibility_outlined,
                widget.contourClosed
                    ? 'Suletud kontuur on ainult visuaalne juhis'
                    : 'Kontuur pole suletud'),
            const SizedBox(height: 7),
            Semantics(
                key: keyFor('style-summary'),
                container: true,
                label: summary,
                child: Text(summary,
                    style: const TextStyle(
                        color: WorkbenchColors.navy,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800))),
          ]),
        ),
        const SizedBox(height: 12),
        KeyedSubtree(
          key: keyFor('shape-grid'),
          child: WizardCompactTileSelector<WizardVisualCandidateShape>(
            label: 'Kuju',
            value: editor.currentShape,
            onChanged: widget.enabled
                ? (shape) => edit(() => editor.setShape(shape))
                : null,
            tiles: [
              for (final shape in WizardVisualCandidateShape.values)
                WizardCompactTile(
                  key: keyFor(
                      'shape-${shape == WizardVisualCandidateShape.roundedRectangle ? 'rounded-rectangle' : shape.name}'),
                  value: shape,
                  label: componentCandidateShapeLabel(shape),
                  icon: switch (shape) {
                    WizardVisualCandidateShape.circle => Icons.circle_outlined,
                    WizardVisualCandidateShape.square => Icons.crop_square,
                    WizardVisualCandidateShape.rectangle => Icons.crop_16_9,
                    WizardVisualCandidateShape.roundedRectangle =>
                      Icons.rounded_corner,
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text('Suurus · $size%',
            style: const TextStyle(
                color: WorkbenchColors.muted,
                fontSize: 12.5,
                fontWeight: FontWeight.w800)),
        Semantics(
            label: 'Markeri suurus',
            value: '$size%',
            slider: true,
            child: Slider(
                key: keyFor('size-slider'),
                value: editor.currentSizeScale,
                min: .5,
                max: 2.5,
                divisions: 200,
                label: '$size%',
                semanticFormatterCallback: (value) =>
                    '${(value * 100).round()}%',
                onChanged: widget.enabled ? editor.setSizeScale : null,
                onChangeEnd: widget.enabled
                    ? (_) => widget.onEditCompleted?.call()
                    : null,
                activeColor: WorkbenchColors.signal,
                inactiveColor: WorkbenchColors.rule)),
        const Text('Pööre',
            style: TextStyle(
                color: WorkbenchColors.muted,
                fontSize: 12.5,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Row(children: [
          _rotationButton(
              'rotate-minus',
              'Pööra markerit 15° vasakule',
              Icons.rotate_left,
              () => editor.setRotation(editor.currentRotation - math.pi / 12)),
          const SizedBox(width: 5),
          _rotationButton(
              'rotate-plus',
              'Pööra markerit 15° paremale',
              Icons.rotate_right,
              () => editor.setRotation(editor.currentRotation + math.pi / 12)),
          const SizedBox(width: 5),
          _rotationButton('rotate-reset', 'Nulli markeri pööre 0°',
              Icons.refresh, () => editor.setRotation(0)),
          const Spacer(),
          Semantics(
              key: keyFor('rotation-value'),
              label: 'Markeri pööre: $signed°',
              excludeSemantics: true,
              child: Text('$signed°',
                  style: const TextStyle(
                      color: WorkbenchColors.navy,
                      fontWeight: FontWeight.w800))),
        ]),
        const SizedBox(height: 16),
        OutlinedButton.icon(
            key: keyFor('delete'),
            onPressed: !widget.enabled || selectedKey == null
                ? null
                : () => edit(editor.deleteSelected),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Kustuta valitud kandidaat'),
            style: OutlinedButton.styleFrom(
                foregroundColor: WorkbenchColors.danger,
                side: const BorderSide(color: WorkbenchColors.danger),
                padding: const EdgeInsets.symmetric(vertical: 13))),
        const SizedBox(height: 14),
        const Text(
            'Tühja ala puudutus lisab kandidaadi. Valimiseks puuduta '
            'kandidaati ning liigutamiseks lohista seda. Kontuur ei piira paigutust.',
            style: TextStyle(
                color: WorkbenchColors.muted, fontSize: 12.5, height: 1.45)),
      ]),
    );
  }

  Widget _stateRow(String suffix, IconData icon, String label) => Row(
        key: keyFor(suffix),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: WorkbenchColors.muted, size: 16),
          const SizedBox(width: 6),
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      color: WorkbenchColors.navy,
                      fontSize: 11.5,
                      height: 1.25,
                      fontWeight: FontWeight.w700)))
        ],
      );

  Widget _rotationButton(
          String suffix, String tooltip, IconData icon, VoidCallback action) =>
      Semantics(
          key: keyFor(suffix),
          button: true,
          label: tooltip,
          excludeSemantics: true,
          child: IconButton.outlined(
              tooltip: tooltip,
              onPressed: widget.enabled ? () => edit(action) : null,
              icon: Icon(icon),
              color: WorkbenchColors.signal));
}

/// The only candidate body painter. Interaction and preview use identical geometry.
class ComponentCandidatePainter extends CustomPainter {
  const ComponentCandidatePainter(
      {required this.candidates,
      required this.selectedDraftKey,
      required this.referenceRect,
      this.interactive = false,
      this.allowAdd = false,
      this.canInteractAt});

  final List<ComponentCandidateDraft> candidates;
  final int? selectedDraftKey;
  final Rect referenceRect;
  final bool interactive;
  final bool allowAdd;
  final bool Function(Offset)? canInteractAt;

  Iterable<({int draftKey, WizardCandidateGeometry geometry})>
      markerGeometries() sync* {
    for (final candidate in candidates) {
      yield (
        draftKey: candidate.draftKey,
        geometry: WizardCandidateGeometry.resolve(
            referenceRect: referenceRect,
            normalizedCenter: candidate.position,
            shape: candidate.shape,
            sizeScale: candidate.sizeScale,
            rotationRadians: candidate.rotationRadians)
      );
    }
  }

  @override
  bool? hitTest(Offset position) =>
      interactive &&
      referenceRect.contains(position) &&
      (canInteractAt?.call(position) ?? true) &&
      (allowAdd ||
          markerGeometries()
              .any((marker) => marker.geometry.hitBounds.contains(position)));

  @override
  void paint(Canvas canvas, Size size) {
    for (final marker in markerGeometries()) {
      final geometry = marker.geometry;
      final selected = marker.draftKey == selectedDraftKey;
      canvas.save();
      canvas.translate(geometry.center.dx, geometry.center.dy);
      canvas.rotate(geometry.effectiveRotation);
      if (selected) {
        canvas.drawPath(
            geometry.localPath,
            Paint()
              ..color = WorkbenchColors.signal.withValues(alpha: .72)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..strokeJoin = StrokeJoin.round);
      }
      canvas.drawPath(
          geometry.localPath,
          Paint()
            ..color = selected ? WorkbenchColors.signal : WorkbenchColors.navy
            ..style = PaintingStyle.fill);
      canvas.drawPath(
          geometry.localPath,
          Paint()
            ..color = WorkbenchColors.navyDeep
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..strokeJoin = StrokeJoin.round);
      final arm = math.max(2.0, geometry.minorDimension * .28);
      final paint = Paint()
        ..color = WorkbenchColors.navyDeep
        ..strokeWidth = math.max(1.2, geometry.minorDimension * .1)
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(-arm, 0), Offset(arm, 0), paint);
      canvas.drawLine(Offset(0, -arm), Offset(0, arm), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ComponentCandidatePainter oldDelegate) =>
      oldDelegate.candidates != candidates ||
      oldDelegate.selectedDraftKey != selectedDraftKey ||
      oldDelegate.referenceRect != referenceRect;
}
