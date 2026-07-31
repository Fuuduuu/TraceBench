import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/features/project/widgets/new_project_wizard_photo_editor.dart';

class _PhotoEditorHarness extends StatefulWidget {
  const _PhotoEditorHarness({
    super.key,
    this.initialTransform = const NewProjectWizardPhotoTransform(),
    this.compact = false,
    this.renderError = false,
  });

  final NewProjectWizardPhotoTransform initialTransform;
  final bool compact;
  final bool renderError;

  @override
  State<_PhotoEditorHarness> createState() => _PhotoEditorHarnessState();
}

class _PhotoEditorHarnessState extends State<_PhotoEditorHarness> {
  static const String photoPath = 'C:/photos/board.png';

  late NewProjectWizardPhotoTransform transform = widget.initialTransform;
  var resetCount = 0;
  var replaceCount = 0;
  var removeCount = 0;

  @override
  Widget build(BuildContext context) {
    return NewProjectWizardPhotoEditor(
      key: const ValueKey('test-photo-editor'),
      photoPath: photoPath,
      transform: transform,
      onTranslationChanged: (translation) {
        setState(() {
          transform = transform.copyWith(translation: translation);
        });
      },
      onScaleChanged: (scale) {
        setState(() {
          transform = transform.copyWith(
            scale: scale
                .clamp(
                  NewProjectWizardPhotoEditor.minimumScale,
                  NewProjectWizardPhotoEditor.maximumScale,
                )
                .toDouble(),
          );
        });
      },
      onRotationChanged: (rotation) {
        setState(() {
          transform = transform.copyWith(rotation: rotation);
        });
      },
      onOpacityChanged: (opacity) {
        setState(() {
          transform = transform.copyWith(
            opacity: opacity.clamp(0.0, 1.0).toDouble(),
          );
        });
      },
      onReset: () {
        setState(() {
          resetCount += 1;
          transform = NewProjectWizardPhotoTransform(
            opacity: transform.opacity,
          );
        });
      },
      onReplace: () {
        setState(() {
          replaceCount += 1;
        });
      },
      onRemove: () {
        setState(() {
          removeCount += 1;
        });
      },
      compact: widget.compact,
      imageBuilder: (_, __, errorWidget) {
        if (widget.renderError) {
          return errorWidget;
        }
        return const ColoredBox(
          key: ValueKey('test-photo-image'),
          color: Color(0xFF28506B),
        );
      },
    );
  }
}

Widget _buildEditorApp(
  GlobalKey<_PhotoEditorHarnessState> harnessKey, {
  NewProjectWizardPhotoTransform initialTransform =
      const NewProjectWizardPhotoTransform(),
  bool compact = false,
  bool renderError = false,
}) {
  return MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: _PhotoEditorHarness(
            key: harnessKey,
            initialTransform: initialTransform,
            compact: compact,
            renderError: renderError,
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('default photo opacity is 65% with no future guide overlays',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    final opacity = tester.widget<Opacity>(
      find.byKey(const ValueKey('wizard-photo-opacity-layer')),
    );
    expect(opacity.opacity, 0.65);
    expect(find.text('65%'), findsWidgets);
    expect(
      find.byKey(const ValueKey('test-photo-image')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-photo-guide-painter')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('guide-layer')),
      findsNothing,
    );
  });

  testWidgets('opacity slider hides only the image and reaches 100%',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    var slider = tester.widget<Slider>(
      find.byKey(const ValueKey('wizard-photo-opacity-slider')),
    );
    slider.onChanged!(0.0);
    await tester.pump();

    expect(harnessKey.currentState!.transform.opacity, 0.0);
    expect(
      tester
          .widget<Opacity>(
            find.byKey(const ValueKey('wizard-photo-opacity-layer')),
          )
          .opacity,
      0.0,
    );
    expect(find.text('Foto peidetud'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('test-photo-image')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-photo-guide-painter')),
      findsNothing,
    );

    slider = tester.widget<Slider>(
      find.byKey(const ValueKey('wizard-photo-opacity-slider')),
    );
    slider.onChanged!(1.0);
    await tester.pump();

    expect(harnessKey.currentState!.transform.opacity, 1.0);
    expect(
      tester
          .widget<Opacity>(
            find.byKey(const ValueKey('wizard-photo-opacity-layer')),
          )
          .opacity,
      1.0,
    );
    expect(find.text('100%'), findsWidgets);
    expect(find.text('Foto peidetud'), findsNothing);
  });

  testWidgets('zoom and rotate controls emit bounded visible adjustments',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    await tester.tap(
      find.byKey(const ValueKey('wizard-photo-zoom-in')),
    );
    await tester.pump();
    expect(harnessKey.currentState!.transform.scale, 1.25);

    await tester.tap(
      find.byKey(const ValueKey('wizard-photo-zoom-out')),
    );
    await tester.pump();
    expect(harnessKey.currentState!.transform.scale, 1.0);

    await tester.tap(
      find.byKey(const ValueKey('wizard-photo-rotate-right')),
    );
    await tester.pump();
    expect(
      harnessKey.currentState!.transform.rotation,
      closeTo(math.pi / 12, 0.000001),
    );

    await tester.tap(
      find.byKey(const ValueKey('wizard-photo-rotate-left')),
    );
    await tester.pump();
    expect(harnessKey.currentState!.transform.rotation, closeTo(0.0, 0.000001));
  });

  testWidgets('drag emits editor-normalized translation for the photo only',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    final canvas = find.byKey(const ValueKey('wizard-photo-canvas'));
    final canvasRect = tester.getRect(canvas);
    final gesture = await tester.startGesture(canvasRect.center);
    await gesture.moveBy(const Offset(80, 50));
    await tester.pump(const Duration(milliseconds: 16));
    await gesture.up();
    await tester.pump();

    final translation = harnessKey.currentState!.transform.translation;
    expect(translation.dx, closeTo(80 / canvasRect.width, 0.001));
    expect(translation.dy, closeTo(50 / canvasRect.height, 0.001));
    expect(
      find.byKey(const ValueKey('wizard-photo-guide-painter')),
      findsNothing,
    );
  });

  testWidgets('reset preserves path and opacity while restoring the view',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildEditorApp(
        harnessKey,
        initialTransform: const NewProjectWizardPhotoTransform(
          translation: Offset(0.2, -0.1),
          scale: 2.5,
          rotation: 0.9,
          opacity: 0.28,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(
      find.byKey(const ValueKey('wizard-photo-reset')),
    );
    await tester.pump();

    final state = harnessKey.currentState!;
    expect(state.resetCount, 1);
    expect(_PhotoEditorHarnessState.photoPath, 'C:/photos/board.png');
    expect(state.transform.translation, Offset.zero);
    expect(state.transform.scale, 1.0);
    expect(state.transform.rotation, 0.0);
    expect(state.transform.opacity, 0.28);
    expect(find.text('28%'), findsWidgets);
  });

  testWidgets('render failure is honest and recovery actions remain usable',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildEditorApp(harnessKey, renderError: true),
    );
    await tester.pump();

    expect(
      find.byKey(const ValueKey('wizard-photo-render-error')),
      findsOneWidget,
    );
    expect(find.text('Foto kuvamine ebaõnnestus.'), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('wizard-photo-replace')),
    );
    await tester.pump();
    await tester.tap(
      find.byKey(const ValueKey('wizard-photo-remove')),
    );
    await tester.pump();

    expect(harnessKey.currentState!.replaceCount, 1);
    expect(harnessKey.currentState!.removeCount, 1);
  });

  testWidgets('wide and compact editor layouts remain operable',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    expect(
      find.byKey(const ValueKey('wizard-photo-wide-controls')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);

    await tester.binding.setSurfaceSize(const Size(390, 760));
    await tester.pumpWidget(
      _buildEditorApp(harnessKey, compact: true),
    );
    await tester.pump();

    expect(
      find.byKey(const ValueKey('wizard-photo-compact-controls')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-photo-opacity-slider')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
