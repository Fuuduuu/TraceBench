import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

typedef WizardPhotoImageBuilder = Widget Function(
  BuildContext context,
  String photoPath,
  Widget errorWidget,
);

@immutable
class NewProjectWizardPhotoTransform {
  const NewProjectWizardPhotoTransform({
    this.translation = Offset.zero,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.opacity = 0.65,
  });

  final Offset translation;
  final double scale;
  final double rotation;
  final double opacity;

  NewProjectWizardPhotoTransform copyWith({
    Offset? translation,
    double? scale,
    double? rotation,
    double? opacity,
  }) {
    return NewProjectWizardPhotoTransform(
      translation: translation ?? this.translation,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      opacity: opacity ?? this.opacity,
    );
  }
}

class NewProjectWizardPhotoLayer extends StatelessWidget {
  const NewProjectWizardPhotoLayer({
    super.key,
    required this.photoPath,
    required this.transform,
    this.imageBuilder,
  });

  final String photoPath;
  final NewProjectWizardPhotoTransform transform;
  final WizardPhotoImageBuilder? imageBuilder;

  Widget _buildRenderError() {
    return Center(
      child: Container(
        key: const ValueKey('wizard-photo-render-error'),
        constraints: const BoxConstraints(maxWidth: 360),
        decoration: BoxDecoration(
          color: _PhotoEditorPalette.panel.withValues(alpha: 0.94),
          border: Border.all(color: _PhotoEditorPalette.warning),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.broken_image_outlined,
              color: _PhotoEditorPalette.warningBright,
              size: 30,
            ),
            SizedBox(height: 9),
            Text(
              'Foto kuvamine ebaõnnestus.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _PhotoEditorPalette.cream,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Mustand jääb alles. Foto saab asendada või eemaldada.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _PhotoEditorPalette.muted,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    final errorWidget = _buildRenderError();
    final builder = imageBuilder;
    if (builder != null) {
      return builder(context, photoPath, errorWidget);
    }
    return Image.file(
      File(photoPath),
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => errorWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final editorSize = constraints.biggest;
        final pixelTranslation = Offset(
          transform.translation.dx * editorSize.width,
          transform.translation.dy * editorSize.height,
        );
        return Stack(
          key: const ValueKey('wizard-photo-stack'),
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              key: const ValueKey('photo-layer'),
              child: ClipRect(
                child: Transform.translate(
                  key: const ValueKey('wizard-photo-translation-layer'),
                  offset: pixelTranslation,
                  child: Transform.rotate(
                    key: const ValueKey('wizard-photo-rotation-layer'),
                    angle: transform.rotation,
                    child: Transform.scale(
                      key: const ValueKey('wizard-photo-scale-layer'),
                      scale: transform.scale,
                      child: Opacity(
                        key: const ValueKey('wizard-photo-opacity-layer'),
                        opacity: transform.opacity,
                        child: SizedBox.expand(
                          child: _buildPhoto(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (transform.opacity == 0.0)
              const Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: IgnorePointer(
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xE61A1916),
                        borderRadius: BorderRadius.all(
                          Radius.circular(999),
                        ),
                        border: Border.fromBorderSide(
                          BorderSide(color: _PhotoEditorPalette.edgeGold),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 7,
                        ),
                        child: Text(
                          'Foto peidetud',
                          style: TextStyle(
                            color: _PhotoEditorPalette.gold,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class NewProjectWizardPhotoEditor extends StatefulWidget {
  const NewProjectWizardPhotoEditor({
    super.key,
    required this.photoPath,
    required this.transform,
    required this.onTranslationChanged,
    required this.onScaleChanged,
    required this.onRotationChanged,
    required this.onOpacityChanged,
    required this.onReset,
    required this.onReplace,
    required this.onRemove,
    this.compact = false,
    this.imageBuilder,
  });

  static const double minimumScale = 0.25;
  static const double maximumScale = 8.0;

  final String photoPath;
  final NewProjectWizardPhotoTransform transform;
  final ValueChanged<Offset> onTranslationChanged;
  final ValueChanged<double> onScaleChanged;
  final ValueChanged<double> onRotationChanged;
  final ValueChanged<double> onOpacityChanged;
  final VoidCallback onReset;
  final VoidCallback onReplace;
  final VoidCallback onRemove;
  final bool compact;
  final WizardPhotoImageBuilder? imageBuilder;

  @override
  State<NewProjectWizardPhotoEditor> createState() =>
      _NewProjectWizardPhotoEditorState();
}

class _NewProjectWizardPhotoEditorState
    extends State<NewProjectWizardPhotoEditor> {
  Offset? _dragOrigin;
  Offset _dragPixels = Offset.zero;

  void _startDrag(DragStartDetails details) {
    _dragOrigin = widget.transform.translation;
    _dragPixels = Offset.zero;
  }

  void _updateDrag(DragUpdateDetails details, Size editorSize) {
    final origin = _dragOrigin;
    if (origin == null || editorSize.width <= 0 || editorSize.height <= 0) {
      return;
    }
    _dragPixels += details.delta;
    widget.onTranslationChanged(
      Offset(
        origin.dx + (_dragPixels.dx / editorSize.width),
        origin.dy + (_dragPixels.dy / editorSize.height),
      ),
    );
  }

  void _endDrag([DragEndDetails? _]) {
    _dragOrigin = null;
    _dragPixels = Offset.zero;
  }

  Widget _buildCanvas() {
    final height = widget.compact ? 300.0 : 430.0;
    return Semantics(
      container: true,
      label: 'Foto joondamise redaktor',
      value: 'Läbipaistvus '
          '${(widget.transform.opacity * 100).round()} protsenti',
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _PhotoEditorPalette.inset,
          border: Border.all(color: _PhotoEditorPalette.edgeGold),
          borderRadius: BorderRadius.circular(14),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final editorSize = constraints.biggest;
            return GestureDetector(
              key: const ValueKey('wizard-photo-canvas'),
              behavior: HitTestBehavior.opaque,
              onPanStart: _startDrag,
              onPanUpdate: (details) => _updateDrag(details, editorSize),
              onPanEnd: _endDrag,
              onPanCancel: _endDrag,
              child: NewProjectWizardPhotoLayer(
                photoPath: widget.photoPath,
                transform: widget.transform,
                imageBuilder: widget.imageBuilder,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransformControls() {
    final scale = widget.transform.scale;
    const scaleFactor = 1.25;
    const rotationStep = math.pi / 12;
    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: <Widget>[
        OutlinedButton.icon(
          key: const ValueKey('wizard-photo-zoom-out'),
          onPressed: scale <= NewProjectWizardPhotoEditor.minimumScale
              ? null
              : () => widget.onScaleChanged(scale / scaleFactor),
          icon: const Icon(Icons.zoom_out),
          label: const Text('Vähenda'),
        ),
        OutlinedButton.icon(
          key: const ValueKey('wizard-photo-zoom-in'),
          onPressed: scale >= NewProjectWizardPhotoEditor.maximumScale
              ? null
              : () => widget.onScaleChanged(scale * scaleFactor),
          icon: const Icon(Icons.zoom_in),
          label: const Text('Suurenda'),
        ),
        OutlinedButton.icon(
          key: const ValueKey('wizard-photo-rotate-left'),
          onPressed: () => widget.onRotationChanged(
            widget.transform.rotation - rotationStep,
          ),
          icon: const Icon(Icons.rotate_left),
          label: const Text('Pööra vasakule'),
        ),
        OutlinedButton.icon(
          key: const ValueKey('wizard-photo-rotate-right'),
          onPressed: () => widget.onRotationChanged(
            widget.transform.rotation + rotationStep,
          ),
          icon: const Icon(Icons.rotate_right),
          label: const Text('Pööra paremale'),
        ),
      ],
    );
  }

  Widget _buildOpacityControl() {
    final percent = (widget.transform.opacity * 100).round();
    final slider = Slider(
      key: const ValueKey('wizard-photo-opacity-slider'),
      value: widget.transform.opacity,
      min: 0.0,
      max: 1.0,
      divisions: 100,
      label: '$percent%',
      onChanged: widget.onOpacityChanged,
    );
    final value = Text(
      '$percent%',
      key: const ValueKey('wizard-photo-opacity-value'),
      style: const TextStyle(
        color: _PhotoEditorPalette.gold,
        fontWeight: FontWeight.w800,
      ),
    );
    if (widget.compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Foto läbipaistvus',
            style: TextStyle(
              color: _PhotoEditorPalette.cream,
              fontWeight: FontWeight.w700,
            ),
          ),
          slider,
          Align(alignment: Alignment.centerRight, child: value),
        ],
      );
    }
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 138,
          child: Text(
            'Foto läbipaistvus',
            style: TextStyle(
              color: _PhotoEditorPalette.cream,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: slider),
        const SizedBox(width: 10),
        SizedBox(width: 44, child: value),
      ],
    );
  }

  Widget _buildDraftActions() {
    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: <Widget>[
        OutlinedButton.icon(
          key: const ValueKey('wizard-photo-reset'),
          onPressed: widget.onReset,
          icon: const Icon(Icons.restart_alt),
          label: const Text('Nulli vaade'),
        ),
        OutlinedButton.icon(
          key: const ValueKey('wizard-photo-replace'),
          onPressed: widget.onReplace,
          icon: const Icon(Icons.find_replace_outlined),
          label: const Text('Asenda foto'),
        ),
        OutlinedButton.icon(
          key: const ValueKey('wizard-photo-remove'),
          onPressed: widget.onRemove,
          icon: const Icon(Icons.delete_outline),
          label: const Text('Eemalda foto'),
          style: OutlinedButton.styleFrom(
            foregroundColor: _PhotoEditorPalette.warningBright,
            side: const BorderSide(color: _PhotoEditorPalette.warning),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(
        widget.compact
            ? 'wizard-photo-compact-controls'
            : 'wizard-photo-wide-controls',
      ),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildCanvas(),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: _PhotoEditorPalette.panel,
            border: Border.all(color: _PhotoEditorPalette.edge),
            borderRadius: BorderRadius.circular(13),
          ),
          padding: EdgeInsets.all(widget.compact ? 12 : 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTransformControls(),
              const SizedBox(height: 13),
              _buildOpacityControl(),
              const SizedBox(height: 13),
              _buildDraftActions(),
              const SizedBox(height: 10),
              Text(
                'Suum ${widget.transform.scale.toStringAsFixed(2)}× · '
                'pööre '
                '${(widget.transform.rotation * 180 / math.pi).round()}°',
                style: const TextStyle(
                  color: _PhotoEditorPalette.muted,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

abstract final class _PhotoEditorPalette {
  static const Color panel = Color(0xFF141310);
  static const Color inset = Color(0xFF0A0A0A);
  static const Color edge = Color(0xFF332E22);
  static const Color edgeGold = Color(0xFF6B5A30);
  static const Color gold = Color(0xFFE7C25A);
  static const Color cream = Color(0xFFF3ECDC);
  static const Color muted = Color(0xFFA89F8C);
  static const Color warning = Color(0xFFE08A55);
  static const Color warningBright = Color(0xFFF0A268);
}
