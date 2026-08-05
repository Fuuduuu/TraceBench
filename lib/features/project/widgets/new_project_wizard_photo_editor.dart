import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'wizard_compact_tokens.dart';
import 'wizard_compact_widgets.dart';

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
          color: WizardCompactTokens.panel.withValues(alpha: 0.94),
          border: Border.all(color: WizardCompactTokens.warning),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.broken_image_outlined,
              color: WizardCompactTokens.warningBright,
              size: 30,
            ),
            SizedBox(height: 9),
            Text(
              'Foto kuvamine ebaõnnestus.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: WizardCompactTokens.cream,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Mustand jääb alles. Foto saab asendada või eemaldada.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: WizardCompactTokens.muted,
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
                          BorderSide(color: WizardCompactTokens.edgeGold),
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
                            color: WizardCompactTokens.gold,
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
  int? _dragPointer;

  void _startDrag(PointerDownEvent event) {
    if (_dragPointer != null) {
      return;
    }
    _dragPointer = event.pointer;
    _dragOrigin = widget.transform.translation;
    _dragPixels = Offset.zero;
  }

  void _updateDrag(PointerMoveEvent event, Size editorSize) {
    final origin = _dragOrigin;
    if (_dragPointer != event.pointer ||
        origin == null ||
        editorSize.width <= 0 ||
        editorSize.height <= 0) {
      return;
    }
    _dragPixels += event.delta;
    widget.onTranslationChanged(
      Offset(
        origin.dx + (_dragPixels.dx / editorSize.width),
        origin.dy + (_dragPixels.dy / editorSize.height),
      ),
    );
  }

  void _endDrag(PointerEvent event) {
    if (_dragPointer != event.pointer) {
      return;
    }
    _dragPointer = null;
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
          color: WizardCompactTokens.inset,
          border: Border.all(color: WizardCompactTokens.edgeGold),
          borderRadius: BorderRadius.circular(14),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final editorSize = constraints.biggest;
            return RawGestureDetector(
              key: const ValueKey('wizard-photo-canvas'),
              behavior: HitTestBehavior.opaque,
              gestures: <Type, GestureRecognizerFactory>{
                EagerGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                    EagerGestureRecognizer>(
                  EagerGestureRecognizer.new,
                  (_) {},
                ),
              },
              child: Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: _startDrag,
                onPointerMove: (event) => _updateDrag(event, editorSize),
                onPointerUp: _endDrag,
                onPointerCancel: _endDrag,
                child: NewProjectWizardPhotoLayer(
                  photoPath: widget.photoPath,
                  transform: widget.transform,
                  imageBuilder: widget.imageBuilder,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    final scale = widget.transform.scale;
    const scaleFactor = 1.25;
    const rotationStep = math.pi / 12;
    return WizardCompactToolbar(
      key: const ValueKey('wizard-photo-toolbar'),
      label: 'Foto vaate tööriistariba',
      children: <Widget>[
        WizardCompactIconAction(
          key: const ValueKey('wizard-photo-zoom-out'),
          label: 'Vähenda fotot',
          icon: Icons.zoom_out,
          onPressed: scale <= NewProjectWizardPhotoEditor.minimumScale
              ? null
              : () => widget.onScaleChanged(scale / scaleFactor),
        ),
        WizardCompactIconAction(
          key: const ValueKey('wizard-photo-zoom-in'),
          label: 'Suurenda fotot',
          icon: Icons.zoom_in,
          onPressed: scale >= NewProjectWizardPhotoEditor.maximumScale
              ? null
              : () => widget.onScaleChanged(scale * scaleFactor),
        ),
        WizardCompactIconAction(
          key: const ValueKey('wizard-photo-rotate-left'),
          label: 'Pööra fotot vasakule',
          icon: Icons.rotate_left,
          onPressed: () => widget.onRotationChanged(
            widget.transform.rotation - rotationStep,
          ),
        ),
        WizardCompactIconAction(
          key: const ValueKey('wizard-photo-rotate-right'),
          label: 'Pööra fotot paremale',
          icon: Icons.rotate_right,
          onPressed: () => widget.onRotationChanged(
            widget.transform.rotation + rotationStep,
          ),
        ),
        WizardCompactIconAction(
          key: const ValueKey('wizard-photo-reset'),
          label: 'Nulli fotovaade',
          icon: Icons.restart_alt,
          onPressed: widget.onReset,
        ),
        WizardCompactIconAction(
          key: const ValueKey('wizard-photo-replace'),
          label: 'Asenda foto',
          icon: Icons.find_replace_outlined,
          onPressed: widget.onReplace,
        ),
        WizardCompactIconAction(
          key: const ValueKey('wizard-photo-remove'),
          label: 'Eemalda foto',
          icon: Icons.delete_outline,
          tone: WizardCompactActionTone.destructive,
          onPressed: widget.onRemove,
        ),
      ],
    );
  }

  Widget _buildOpacityControl() {
    final percent = (widget.transform.opacity * 100).round();
    return WizardCompactSlider(
      key: const ValueKey('wizard-photo-opacity-control'),
      controlKey: const ValueKey('wizard-photo-opacity-slider'),
      label: 'Foto läbipaistvus',
      valueLabel: '$percent%',
      value: widget.transform.opacity,
      min: 0.0,
      max: 1.0,
      divisions: 100,
      onChanged: widget.onOpacityChanged,
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
        WizardCompactFileChip(
          key: const ValueKey('wizard-photo-file-chip'),
          path: widget.photoPath,
        ),
        const SizedBox(height: WizardCompactTokens.space12),
        _buildCanvas(),
        const SizedBox(height: WizardCompactTokens.space12),
        Container(
          decoration: WizardCompactTokens.panelDecoration(),
          padding: const EdgeInsets.all(WizardCompactTokens.space12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildToolbar(),
              const SizedBox(height: WizardCompactTokens.space12),
              _buildOpacityControl(),
              const SizedBox(height: WizardCompactTokens.space8),
              Text(
                'Suum ${widget.transform.scale.toStringAsFixed(2)}× · '
                'pööre '
                '${(widget.transform.rotation * 180 / math.pi).round()}°',
                style: WizardCompactTokens.bodyStyle(
                  color: WizardCompactTokens.muted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
