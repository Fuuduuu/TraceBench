import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/features/project/screens/new_project_wizard_screen.dart';
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
  var translationCount = 0;
  var scaleCount = 0;
  var rotationCount = 0;
  var opacityCount = 0;

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return NewProjectWizardPhotoEditor(
      key: const ValueKey('test-photo-editor'),
      photoPath: photoPath,
      transform: transform,
      onTranslationChanged: (translation) {
        translationCount += 1;
        setState(() {
          transform = transform.copyWith(translation: translation);
        });
      },
      onScaleChanged: (scale) {
        scaleCount += 1;
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
        rotationCount += 1;
        setState(() {
          transform = transform.copyWith(rotation: rotation);
        });
      },
      onOpacityChanged: (opacity) {
        opacityCount += 1;
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
  double textScale = 1,
}) {
  return MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: Scaffold(
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
    ),
  );
}

bool _focusIsWithin(WidgetTester tester, Finder target) {
  final targetElement = tester.element(target);
  final focusContext = FocusManager.instance.primaryFocus?.context;
  if (focusContext == null) {
    return false;
  }
  if (identical(focusContext, targetElement)) {
    return true;
  }
  var found = false;
  (focusContext as Element).visitAncestorElements((element) {
    if (identical(element, targetElement)) {
      found = true;
      return false;
    }
    return true;
  });
  return found;
}

void main() {
  testWidgets('the parent Step 2 no-photo state remains honest and optional',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: NewProjectWizardScreen(
          directoryPicker: () async => 'C:/projects',
        ),
      ),
    );
    await tester.enterText(
      find.byKey(const ValueKey('wizard-project-name')),
      'Foto puudub',
    );
    final folder = find.byKey(const ValueKey('wizard-pick-folder'));
    await tester.ensureVisible(folder);
    await tester.tap(folder);
    await tester.pump();
    final next = find.byKey(const ValueKey('wizard-next'));
    await tester.ensureVisible(next);
    await tester.tap(next);
    await tester.pump();

    expect(find.byKey(const ValueKey('wizard-photo-empty')), findsOneWidget);
    expect(find.text('Foto pole valitud'), findsOneWidget);
    expect(find.byKey(const ValueKey('wizard-photo-editor')), findsNothing);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const ValueKey('wizard-next')))
          .onPressed,
      isNotNull,
      reason: 'Step 2 remains optional.',
    );
  });

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
    expect(harnessKey.currentState!.scaleCount, 2);
    expect(harnessKey.currentState!.rotationCount, 2);
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
    expect(harnessKey.currentState!.translationCount, greaterThan(0));
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

  testWidgets('compact toolbar path and actions stay fully accessible',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildEditorApp(harnessKey, compact: true),
    );
    await tester.pump();

    expect(find.byKey(const ValueKey('wizard-photo-toolbar')), findsOneWidget);
    expect(find.text('board.png'), findsOneWidget);
    expect(find.byTooltip(_PhotoEditorHarnessState.photoPath), findsOneWidget);
    expect(
      find.bySemanticsLabel(
        'Valitud foto: ${_PhotoEditorHarnessState.photoPath}',
      ),
      findsOneWidget,
    );
    for (final label in const <String>[
      'Vähenda fotot',
      'Suurenda fotot',
      'Pööra fotot vasakule',
      'Pööra fotot paremale',
      'Nulli fotovaade',
      'Asenda foto',
    ]) {
      expect(find.byTooltip(label), findsOneWidget);
      expect(find.bySemanticsLabel(label), findsOneWidget);
    }
    expect(find.byTooltip('Eemalda foto'), findsOneWidget);
    expect(
      find.bySemanticsLabel('Eemalda foto, hävitav toiming'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('compact photo actions support keyboard activation',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildEditorApp(harnessKey, compact: true),
    );
    await tester.pump();

    final zoomIn = find.byKey(const ValueKey('wizard-photo-zoom-in'));
    for (var index = 0;
        index < 12 && !_focusIsWithin(tester, zoomIn);
        index += 1) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
    }
    expect(_focusIsWithin(tester, zoomIn), isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    expect(harnessKey.currentState!.transform.scale, 1.25);
    expect(harnessKey.currentState!.scaleCount, 1);
  });

  testWidgets('canvas drag stays isolated while an outside drag scrolls page',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(390, 420));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildEditorApp(
        harnessKey,
        compact: true,
        textScale: 2,
      ),
    );
    await tester.pump();

    final scrollable = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    expect(scrollable.position.pixels, 0);

    final canvas = find.byKey(const ValueKey('wizard-photo-canvas'));
    await tester.drag(canvas, const Offset(0, -120));
    await tester.pump();
    expect(scrollable.position.pixels, 0);
    expect(harnessKey.currentState!.translationCount, greaterThan(0));

    await tester.drag(
      find.byKey(const ValueKey('wizard-photo-file-chip')),
      const Offset(0, -220),
    );
    await tester.pumpAndSettle();
    expect(scrollable.position.pixels, greaterThan(0));
  });

  testWidgets('controlled rebuild emits nothing and each draft action once',
      (tester) async {
    final harnessKey = GlobalKey<_PhotoEditorHarnessState>();
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    harnessKey.currentState!.rebuild();
    await tester.pump();
    final before = harnessKey.currentState!;
    expect(before.translationCount, 0);
    expect(before.scaleCount, 0);
    expect(before.rotationCount, 0);
    expect(before.opacityCount, 0);
    expect(before.resetCount, 0);
    expect(before.replaceCount, 0);
    expect(before.removeCount, 0);

    for (final key in const <String>[
      'wizard-photo-reset',
      'wizard-photo-replace',
      'wizard-photo-remove',
    ]) {
      await tester.tap(find.byKey(ValueKey<String>(key)));
      await tester.pump();
    }
    expect(harnessKey.currentState!.resetCount, 1);
    expect(harnessKey.currentState!.replaceCount, 1);
    expect(harnessKey.currentState!.removeCount, 1);
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
    addTearDown(() => tester.binding.setSurfaceSize(null));
    for (final size in const <Size>[
      Size(390, 760),
      Size(519, 800),
      Size(559, 800),
      Size(599, 800),
      Size(779, 800),
      Size(819, 800),
      Size(1049, 800),
      Size(1440, 900),
    ]) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(
        _buildEditorApp(
          harnessKey,
          compact: size.width < 820,
          textScale: size.width == 390 ? 2 : 1,
        ),
      );
      await tester.pump();

      expect(
        find.byKey(
          ValueKey<String>(
            size.width < 820
                ? 'wizard-photo-compact-controls'
                : 'wizard-photo-wide-controls',
          ),
        ),
        findsOneWidget,
      );
      expect(find.text('Eemalda foto'), findsNothing);
      expect(find.byTooltip('Eemalda foto'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'viewport $size');
    }
  });
}
