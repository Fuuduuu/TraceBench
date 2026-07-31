import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/features/project/screens/new_project_wizard_screen.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';

class _TestPlatformInfo extends PlatformInfo {
  const _TestPlatformInfo(this._isMobile);

  final bool _isMobile;

  @override
  bool get isMobile => _isMobile;
}

class _MutableTestPlatformInfo extends PlatformInfo {
  _MutableTestPlatformInfo(this.isMobile);

  @override
  bool isMobile;
}

class _FakePhotoFilePicker extends FilePicker {
  _FakePhotoFilePicker(Iterable<Object?> outcomes)
      : _outcomes = List<Object?>.of(outcomes);

  final List<Object?> _outcomes;
  var pickCount = 0;
  FileType? requestedType;
  List<String>? requestedExtensions;
  bool? requestedWithData;
  bool? requestedAllowMultiple;

  @override
  Future<FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    bool allowCompression = true,
    int compressionQuality = 30,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    bool readSequential = false,
  }) async {
    pickCount += 1;
    requestedType = type;
    requestedExtensions = allowedExtensions;
    requestedWithData = withData;
    requestedAllowMultiple = allowMultiple;
    final outcome = _outcomes.removeAt(0);
    if (outcome is Exception) {
      throw outcome;
    }
    if (outcome == null) {
      return null;
    }
    final path = outcome as String;
    return FilePickerResult(<PlatformFile>[
      PlatformFile(
        name: path.split(RegExp(r'[/\\]')).last,
        path: path,
        size: 1,
      ),
    ]);
  }
}

void _installPhotoPicker(_FakePhotoFilePicker picker) {
  FilePicker? originalPicker;
  try {
    originalPicker = FilePicker.platform;
  } catch (_) {
    originalPicker = null;
  }
  FilePicker.platform = picker;
  addTearDown(() {
    final pickerToRestore = originalPicker;
    if (pickerToRestore != null) {
      FilePicker.platform = pickerToRestore;
    }
  });
}

Widget _buildWizardApp({
  Future<String?> Function()? directoryPicker,
  PlatformInfo platformInfo = const _TestPlatformInfo(false),
}) {
  final router = GoRouter(
    initialLocation: '/new-project',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (_, __) => const Scaffold(
          key: ValueKey('test-home'),
          body: Center(child: Text('Test Home')),
        ),
      ),
      GoRoute(
        path: '/new-project',
        builder: (_, __) => NewProjectWizardScreen(
          directoryPicker: directoryPicker,
          platformInfo: platformInfo,
        ),
      ),
    ],
  );
  addTearDown(router.dispose);

  return MaterialApp.router(
    theme: ThemeData(useMaterial3: true),
    routerConfig: router,
  );
}

Future<void> _pumpFrames(
  WidgetTester tester, {
  int count = 3,
}) async {
  for (var index = 0; index < count; index += 1) {
    await tester.pump(const Duration(milliseconds: 40));
  }
}

Future<void> _enterText(
  WidgetTester tester,
  String key,
  String value,
) async {
  final finder = find.byKey(ValueKey(key));
  await tester.ensureVisible(finder);
  await tester.enterText(finder, value);
  await tester.pump();
}

Future<void> _tapKey(WidgetTester tester, String key) async {
  final finder = find.byKey(ValueKey(key));
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await _pumpFrames(tester);
}

Future<void> _completeStepOne(
  WidgetTester tester, {
  String projectName = 'Pelle PV20',
  String deviceName = 'Põletikontroller',
  String additionalInfo = 'Vahelduv väljalülitumine.',
}) async {
  await _enterText(tester, 'wizard-project-name', projectName);
  await _enterText(tester, 'wizard-device-name', deviceName);
  await _enterText(tester, 'wizard-additional-info', additionalInfo);
  await _tapKey(tester, 'wizard-pick-folder');
}

Future<void> _openContourStep(WidgetTester tester) async {
  await _completeStepOne(tester);
  await _tapKey(tester, 'wizard-next');
  await _tapKey(tester, 'wizard-next');
}

Rect _contourCanvasRect(WidgetTester tester) {
  return tester.getRect(
    find.byKey(const ValueKey('wizard-contour-canvas')),
  );
}

Future<void> _tapContourAt(
  WidgetTester tester,
  Offset normalizedPosition,
) async {
  final canvas = find.byKey(const ValueKey('wizard-contour-canvas'));
  await tester.ensureVisible(canvas);
  await tester.pump();
  final rect = _contourCanvasRect(tester);
  await tester.tapAt(
    rect.topLeft +
        Offset(
          rect.width * normalizedPosition.dx,
          rect.height * normalizedPosition.dy,
        ),
  );
  await _pumpFrames(tester);
}

Future<void> _dragContourPoint(
  WidgetTester tester, {
  required Offset from,
  required Offset to,
}) async {
  final canvas = find.byKey(const ValueKey('wizard-contour-canvas'));
  await tester.ensureVisible(canvas);
  await tester.pump();
  final rect = _contourCanvasRect(tester);
  final start =
      rect.topLeft + Offset(rect.width * from.dx, rect.height * from.dy);
  final delta = Offset(
    rect.width * (to.dx - from.dx),
    rect.height * (to.dy - from.dy),
  );
  final gesture = await tester.startGesture(start);
  await gesture.moveTo(start + delta * 0.5);
  await tester.pump(const Duration(milliseconds: 16));
  await gesture.moveTo(start + delta);
  await tester.pump(const Duration(milliseconds: 16));
  await gesture.up();
  await _pumpFrames(tester);
}

dynamic _contourPainter(WidgetTester tester) {
  return tester
      .widget<CustomPaint>(
        find.byKey(const ValueKey('wizard-contour-painter')),
      )
      .painter;
}

List<Offset> _paintedContourPoints(WidgetTester tester) {
  return List<Offset>.from(
    (_contourPainter(tester) as dynamic).points as Iterable,
  );
}

bool _paintedContourIsClosed(WidgetTester tester) {
  return (_contourPainter(tester) as dynamic).closed as bool;
}

Future<void> _addTriangle(WidgetTester tester) async {
  await _tapContourAt(tester, const Offset(0.2, 0.25));
  await _tapContourAt(tester, const Offset(0.8, 0.25));
  await _tapContourAt(tester, const Offset(0.5, 0.78));
}

Future<void> _closeContour(WidgetTester tester) async {
  await _addTriangle(tester);
  await _tapKey(tester, 'wizard-contour-close');
}

Future<void> _openComponentPlacementStep(WidgetTester tester) async {
  await _openContourStep(tester);
  await _closeContour(tester);
  await _tapKey(tester, 'wizard-next');
}

Future<void> _openPhotoAlignmentStep(WidgetTester tester) async {
  await _completeStepOne(tester);
  await _tapKey(tester, 'wizard-next');
}

dynamic _photoEditor(WidgetTester tester) {
  return tester.widget(
    find.byKey(const ValueKey('wizard-photo-editor')),
  );
}

dynamic _photoTransform(WidgetTester tester) {
  return (_photoEditor(tester) as dynamic).transform;
}

Rect _componentCanvasRect(WidgetTester tester) {
  return tester.getRect(
    find.byKey(const ValueKey('wizard-component-canvas')),
  );
}

Future<void> _tapComponentAt(
  WidgetTester tester,
  Offset normalizedPosition,
) async {
  final canvas = find.byKey(const ValueKey('wizard-component-canvas'));
  await tester.ensureVisible(canvas);
  await tester.pump();
  final rect = _componentCanvasRect(tester);
  await tester.tapAt(
    rect.topLeft +
        Offset(
          rect.width * normalizedPosition.dx,
          rect.height * normalizedPosition.dy,
        ),
  );
  await _pumpFrames(tester);
}

Future<void> _dragComponentCandidate(
  WidgetTester tester, {
  required Offset from,
  required Offset to,
}) async {
  final canvas = find.byKey(const ValueKey('wizard-component-canvas'));
  await tester.ensureVisible(canvas);
  await tester.pump();
  final rect = _componentCanvasRect(tester);
  final start =
      rect.topLeft + Offset(rect.width * from.dx, rect.height * from.dy);
  final delta = Offset(
    rect.width * (to.dx - from.dx),
    rect.height * (to.dy - from.dy),
  );
  final gesture = await tester.startGesture(start);
  await gesture.moveTo(start + delta * 0.5);
  await tester.pump(const Duration(milliseconds: 16));
  await gesture.moveTo(start + delta);
  await tester.pump(const Duration(milliseconds: 16));
  await gesture.up();
  await _pumpFrames(tester);
}

dynamic _componentPainter(WidgetTester tester) {
  return tester
      .widget<CustomPaint>(
        find.byKey(const ValueKey('wizard-component-painter')),
      )
      .painter;
}

List<dynamic> _paintedComponentCandidates(WidgetTester tester) {
  return List<dynamic>.from(
    (_componentPainter(tester) as dynamic).candidates as Iterable,
  );
}

List<int> _paintedComponentDraftKeys(WidgetTester tester) {
  return _paintedComponentCandidates(tester)
      .map((candidate) => (candidate as dynamic).draftKey as int)
      .toList(growable: false);
}

List<Offset> _paintedComponentPositions(WidgetTester tester) {
  return _paintedComponentCandidates(tester)
      .map((candidate) => (candidate as dynamic).position as Offset)
      .toList(growable: false);
}

int? _paintedSelectedComponentDraftKey(WidgetTester tester) {
  return (_componentPainter(tester) as dynamic).selectedDraftKey as int?;
}

List<Offset> _paintedComponentGuidePoints(WidgetTester tester) {
  return List<Offset>.from(
    (_componentPainter(tester) as dynamic).guideContourPoints as Iterable,
  );
}

bool _paintedComponentGuideIsClosed(WidgetTester tester) {
  return (_componentPainter(tester) as dynamic).guideClosed as bool;
}

void main() {
  testWidgets('seven-step shell renders the exact Estonian step labels',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    for (final label in const <String>[
      'Projekti andmed',
      'Foto ja joondamine',
      'Plaadi kontuur',
      'Komponentide asetus',
      'Probleemi kirjeldus',
      'Kontroll ja kinnitus',
      'Kokkuvõte',
    ]) {
      expect(find.text(label), findsWidgets);
    }
  });

  testWidgets('Step 1 renders all four locked fields', (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    expect(
      find.byKey(const ValueKey('wizard-project-name')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-device-name')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-pick-folder')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-additional-info')),
      findsOneWidget,
    );
    expect(find.text('Projekti nimi'), findsOneWidget);
    expect(find.text('Seadme nimetus'), findsOneWidget);
    expect(find.text('Salvestuskoht'), findsOneWidget);
    expect(find.text('Lisainfo'), findsOneWidget);
  });

  testWidgets('Edasi is disabled without a nonblank project name',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _tapKey(tester, 'wizard-pick-folder');
    await _enterText(tester, 'wizard-project-name', '   ');

    final next = tester.widget<FilledButton>(
      find.byKey(const ValueKey('wizard-next')),
    );
    expect(next.onPressed, isNull);
  });

  testWidgets('Edasi is disabled without a selected parent path',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => null),
    );
    await tester.pump();

    await _enterText(tester, 'wizard-project-name', 'Pelle PV20');

    final next = tester.widget<FilledButton>(
      find.byKey(const ValueKey('wizard-next')),
    );
    expect(next.onPressed, isNull);
  });

  testWidgets('valid name and selected path advance to Step 2', (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _completeStepOne(tester);
    await _tapKey(tester, 'wizard-next');

    expect(
      find.byKey(const ValueKey('wizard-photo-step')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('wizard-photo-step')),
        matching: find.text('Samm 2 / 7'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Step 3 starts empty and keeps Edasi disabled', (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);

    expect(
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
    expect(find.text('0 punkti'), findsOneWidget);
    expect(find.text('Kontuur avatud'), findsOneWidget);
    expect(find.text('Ühtegi punkti pole valitud'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-contour-close')),
          )
          .onPressed,
      isNull,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('empty-canvas taps add points but closure needs three',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _tapContourAt(tester, const Offset(0.2, 0.25));
    await _tapContourAt(tester, const Offset(0.8, 0.25));

    expect(_paintedContourPoints(tester), hasLength(2));
    expect(find.text('2 punkti'), findsOneWidget);
    expect(find.text('Punkt 2 valitud'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-contour-close')),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('a point can be selected, dragged, and clamped to the editor',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _tapContourAt(tester, const Offset(0.25, 0.3));
    await _tapContourAt(tester, const Offset(0.75, 0.3));
    await _tapContourAt(tester, const Offset(0.25, 0.3));

    expect(find.text('Punkt 1 valitud'), findsOneWidget);

    await _dragContourPoint(
      tester,
      from: const Offset(0.25, 0.3),
      to: const Offset(1.4, 1.3),
    );

    final moved = _paintedContourPoints(tester).first;
    expect(moved.dx, inInclusiveRange(0.0, 1.0));
    expect(moved.dy, inInclusiveRange(0.0, 1.0));
    expect(moved.dx, closeTo(1.0, 0.001));
    expect(moved.dy, closeTo(1.0, 0.001));
    expect(find.text('Punkt 1 valitud'), findsOneWidget);
  });

  testWidgets('selected point can be deleted', (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _addTriangle(tester);
    await _tapContourAt(tester, const Offset(0.8, 0.25));
    await _tapKey(tester, 'wizard-contour-delete');

    expect(_paintedContourPoints(tester), hasLength(2));
    expect(find.text('2 punkti'), findsOneWidget);
    expect(find.text('Ühtegi punkti pole valitud'), findsOneWidget);
    expect(find.text('Kontuur avatud'), findsOneWidget);
  });

  testWidgets('reset clears points, selection, closure, and the Step 3 gate',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _closeContour(tester);
    await _tapKey(tester, 'wizard-contour-reset');

    expect(_paintedContourPoints(tester), isEmpty);
    expect(_paintedContourIsClosed(tester), isFalse);
    expect(find.text('0 punkti'), findsOneWidget);
    expect(find.text('Ühtegi punkti pole valitud'), findsOneWidget);
    expect(find.text('Kontuur avatud'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('explicit closure paints a closed loop and enables Edasi',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _addTriangle(tester);

    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-contour-close')),
          )
          .onPressed,
      isNotNull,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNull,
    );

    await _tapKey(tester, 'wizard-contour-close');

    expect(_paintedContourIsClosed(tester), isTrue);
    expect(find.text('Kontuur suletud'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('wizard-contour-status')),
        matching: find.byIcon(Icons.lock_outline),
      ),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('adding, moving, and deleting after closure each reopen it',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _closeContour(tester);

    await _tapContourAt(tester, const Offset(0.15, 0.72));
    expect(_paintedContourIsClosed(tester), isFalse);
    expect(find.text('Kontuur avatud'), findsOneWidget);

    await _tapKey(tester, 'wizard-contour-close');
    await _tapContourAt(tester, const Offset(0.2, 0.25));
    await _dragContourPoint(
      tester,
      from: const Offset(0.2, 0.25),
      to: const Offset(0.3, 0.4),
    );
    expect(_paintedContourIsClosed(tester), isFalse);

    await _tapKey(tester, 'wizard-contour-close');
    await _tapKey(tester, 'wizard-contour-delete');
    expect(_paintedContourIsClosed(tester), isFalse);
    expect(_paintedContourPoints(tester), hasLength(3));
  });

  testWidgets(
      'Step 4 starts empty, renders the closed contour guide, and stays ungated',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _closeContour(tester);
    final contourPoints = _paintedContourPoints(tester);
    await _tapKey(tester, 'wizard-next');

    expect(
      find.byKey(const ValueKey('wizard-component-editor')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-placeholder-4')),
      findsNothing,
    );
    expect(find.text('Tulekul'), findsNothing);
    expect(find.text('0 komponent-kandidaati'), findsOneWidget);
    expect(find.text('Ühtegi kandidaati pole valitud'), findsOneWidget);
    expect(_paintedComponentCandidates(tester), isEmpty);
    expect(_paintedComponentGuidePoints(tester), contourPoints);
    expect(_paintedComponentGuideIsClosed(tester), isTrue);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNotNull,
    );

    await _tapKey(tester, 'wizard-back');

    expect(
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
    expect(_paintedContourPoints(tester), hasLength(3));
    expect(_paintedContourIsClosed(tester), isTrue);
    expect(find.text('Kontuur suletud'), findsOneWidget);
  });

  testWidgets('empty-canvas tap adds and selects one generic candidate',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.08, 0.9));

    expect(_paintedComponentDraftKeys(tester), const <int>[1]);
    final position = _paintedComponentPositions(tester).single;
    expect(position.dx, closeTo(0.08, 0.001));
    expect(position.dy, closeTo(0.9, 0.001));
    expect(_paintedSelectedComponentDraftKey(tester), 1);
    expect(find.text('1 komponent-kandidaat'), findsOneWidget);
    expect(find.text('Kandidaat 1 valitud'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('wizard-component-count')),
        matching: find.byIcon(Icons.widgets_outlined),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('wizard-component-selection')),
        matching: find.byIcon(Icons.ads_click_outlined),
      ),
      findsOneWidget,
    );

    await _tapComponentAt(tester, const Offset(0.08, 0.9));
    expect(_paintedComponentDraftKeys(tester), const <int>[1]);
  });

  testWidgets(
      'selection and dragging change only the selected clamped position',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.25, 0.35));
    await _tapComponentAt(tester, const Offset(0.75, 0.35));
    await _tapComponentAt(tester, const Offset(0.25, 0.35));

    expect(find.text('Kandidaat 1 valitud'), findsOneWidget);
    await _dragComponentCandidate(
      tester,
      from: const Offset(0.25, 0.35),
      to: const Offset(1.4, 1.3),
    );

    var positions = _paintedComponentPositions(tester);
    expect(positions.first.dx, closeTo(1.0, 0.001));
    expect(positions.first.dy, closeTo(1.0, 0.001));
    expect(positions.last.dx, closeTo(0.75, 0.001));
    expect(positions.last.dy, closeTo(0.35, 0.001));
    expect(_paintedSelectedComponentDraftKey(tester), 1);

    await _tapComponentAt(tester, const Offset(0.75, 0.35));
    await _dragComponentCandidate(
      tester,
      from: const Offset(0.75, 0.35),
      to: const Offset(-0.4, -0.3),
    );

    positions = _paintedComponentPositions(tester);
    expect(positions.first.dx, closeTo(1.0, 0.001));
    expect(positions.first.dy, closeTo(1.0, 0.001));
    expect(positions.last.dx, closeTo(0.0, 0.001));
    expect(positions.last.dy, closeTo(0.0, 0.001));
    expect(_paintedSelectedComponentDraftKey(tester), 2);
    expect(find.text('2 komponent-kandidaati'), findsOneWidget);
  });

  testWidgets('deletion removes only the selected stable draft candidate',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.2, 0.35));
    await _tapComponentAt(tester, const Offset(0.5, 0.55));
    await _tapComponentAt(tester, const Offset(0.8, 0.35));
    final positionsBefore = _paintedComponentPositions(tester);
    await _tapComponentAt(tester, const Offset(0.5, 0.55));
    await _tapKey(tester, 'wizard-component-delete');

    expect(_paintedComponentDraftKeys(tester), const <int>[1, 3]);
    expect(
      _paintedComponentPositions(tester),
      <Offset>[positionsBefore.first, positionsBefore.last],
    );
    expect(_paintedSelectedComponentDraftKey(tester), isNull);
    expect(find.text('2 komponent-kandidaati'), findsOneWidget);
    expect(find.text('Ühtegi kandidaati pole valitud'), findsOneWidget);
    expect(
      tester
          .widget<OutlinedButton>(
            find.byKey(const ValueKey('wizard-component-delete')),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('Step 4 to Step 5 round-trip retains candidate geometry',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.18, 0.82));
    await _tapComponentAt(tester, const Offset(0.72, 0.42));
    final keysBefore = _paintedComponentDraftKeys(tester);
    final positionsBefore = _paintedComponentPositions(tester);
    await _tapKey(tester, 'wizard-next');

    expect(
      find.byKey(const ValueKey('wizard-placeholder-5')),
      findsOneWidget,
    );
    final fourthProgress = find.byKey(
      const ValueKey('wizard-progress-step-4'),
    );
    expect(
      find.descendant(
        of: fourthProgress,
        matching: find.text('Vaadatud'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: fourthProgress,
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );

    await _tapKey(tester, 'wizard-back');
    expect(_paintedComponentDraftKeys(tester), keysBefore);
    expect(_paintedComponentPositions(tester), positionsBefore);
  });

  testWidgets('Step 2 is optional, ungated, and becomes Vaadatud',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);

    expect(
      find.byKey(const ValueKey('wizard-photo-step')),
      findsOneWidget,
    );
    expect(find.text('Foto ja joondamine'), findsWidgets);
    expect(find.text('Valikuline'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNotNull,
    );

    await _tapKey(tester, 'wizard-next');

    expect(
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
    final secondProgress = find.byKey(
      const ValueKey('wizard-progress-step-2'),
    );
    expect(
      find.descendant(
        of: secondProgress,
        matching: find.text('Vaadatud'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: secondProgress,
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );
  });

  testWidgets('desktop picker uses the locked filter and default photo view',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>['C:/photos/board.JPG']);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');

    expect(picker.pickCount, 1);
    expect(picker.requestedType, FileType.custom);
    expect(
      picker.requestedExtensions,
      const <String>['jpg', 'jpeg', 'png', 'webp'],
    );
    expect(picker.requestedAllowMultiple, isFalse);
    expect(picker.requestedWithData, isFalse);
    expect(
      find.byKey(const ValueKey('wizard-photo-editor')),
      findsOneWidget,
    );
    final editor = _photoEditor(tester) as dynamic;
    final transform = _photoTransform(tester) as dynamic;
    expect(editor.photoPath as String, 'C:/photos/board.JPG');
    expect(transform.translation as Offset, Offset.zero);
    expect(transform.scale as double, 1.0);
    expect(transform.rotation as double, 0.0);
    expect(transform.opacity as double, 0.65);
    expect(find.text('65%'), findsWidgets);
  });

  testWidgets('photo stays below independent contour and candidate geometry',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>[
      'C:/photos/front.png',
      'C:/photos/back.webp',
    ]);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');
    (_photoEditor(tester) as dynamic).onTranslationChanged(
      const Offset(0.17, -0.11),
    );
    (_photoEditor(tester) as dynamic).onScaleChanged(1.8);
    (_photoEditor(tester) as dynamic).onRotationChanged(0.4);
    (_photoEditor(tester) as dynamic).onOpacityChanged(0.0);
    await tester.pump();

    expect(
      find.byKey(const ValueKey('wizard-photo-guide-painter')),
      findsNothing,
    );
    await _tapKey(tester, 'wizard-next');

    final contourStack = tester.widget<Stack>(
      find.byKey(const ValueKey('wizard-contour-stack')),
    );
    final contourPhotoIndex = contourStack.children.indexWhere(
      (child) => child.key == const ValueKey('wizard-contour-photo-layer'),
    );
    final contourPainterIndex = contourStack.children.indexWhere(
      (child) => child.key == const ValueKey('wizard-contour-painter'),
    );
    expect(contourPhotoIndex, greaterThanOrEqualTo(0));
    expect(contourPhotoIndex, lessThan(contourPainterIndex));
    final contourPhotoView = tester.widget(
      find.byKey(const ValueKey('wizard-contour-photo-view')),
    ) as dynamic;
    final contourPhotoTransform = contourPhotoView.transform as dynamic;
    expect(contourPhotoView.photoPath as String, 'C:/photos/front.png');
    expect(
      contourPhotoTransform.translation as Offset,
      const Offset(0.17, -0.11),
    );
    expect(contourPhotoTransform.scale as double, 1.8);
    expect(contourPhotoTransform.rotation as double, closeTo(0.4, 0.000001));
    expect(contourPhotoTransform.opacity as double, 0.0);
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
      find.byKey(const ValueKey('wizard-contour-painter')),
      findsOneWidget,
    );

    await _closeContour(tester);
    final contourBefore = _paintedContourPoints(tester);
    await _tapKey(tester, 'wizard-next');

    final componentStack = tester.widget<Stack>(
      find.byKey(const ValueKey('wizard-component-stack')),
    );
    final componentPhotoIndex = componentStack.children.indexWhere(
      (child) => child.key == const ValueKey('wizard-component-photo-layer'),
    );
    final componentPainterIndex = componentStack.children.indexWhere(
      (child) => child.key == const ValueKey('wizard-component-painter'),
    );
    expect(componentPhotoIndex, greaterThanOrEqualTo(0));
    expect(componentPhotoIndex, lessThan(componentPainterIndex));
    final componentPhotoView = tester.widget(
      find.byKey(const ValueKey('wizard-component-photo-view')),
    ) as dynamic;
    expect(componentPhotoView.photoPath as String, 'C:/photos/front.png');
    expect(_paintedComponentGuidePoints(tester), contourBefore);
    expect(_paintedComponentGuideIsClosed(tester), isTrue);

    await _tapComponentAt(tester, const Offset(0.68, 0.57));
    final candidateKeysBefore = _paintedComponentDraftKeys(tester);
    final candidatePositionsBefore = _paintedComponentPositions(tester);
    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-photo-replace');

    await _tapKey(tester, 'wizard-next');
    expect(_paintedContourPoints(tester), contourBefore);
    final replacedContourPhotoView = tester.widget(
      find.byKey(const ValueKey('wizard-contour-photo-view')),
    ) as dynamic;
    expect(replacedContourPhotoView.photoPath as String, 'C:/photos/back.webp');
    await _tapKey(tester, 'wizard-next');
    expect(_paintedComponentDraftKeys(tester), candidateKeysBefore);
    expect(_paintedComponentPositions(tester), candidatePositionsBefore);
    expect(_paintedComponentGuidePoints(tester), contourBefore);

    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-photo-remove');
    await _tapKey(tester, 'wizard-next');
    expect(
      find.byKey(const ValueKey('wizard-contour-photo-layer')),
      findsNothing,
    );
    expect(_paintedContourPoints(tester), contourBefore);
    await _tapKey(tester, 'wizard-next');
    expect(
      find.byKey(const ValueKey('wizard-component-photo-layer')),
      findsNothing,
    );
    expect(_paintedComponentDraftKeys(tester), candidateKeysBefore);
    expect(_paintedComponentPositions(tester), candidatePositionsBefore);
  });

  testWidgets('picker cancel and exception preserve the current photo draft',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>[
      'C:/photos/board.png',
      null,
      StateError('picker failed'),
    ]);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');
    (_photoEditor(tester) as dynamic).onTranslationChanged(
      const Offset(0.18, -0.12),
    );
    (_photoEditor(tester) as dynamic).onScaleChanged(2.4);
    (_photoEditor(tester) as dynamic).onRotationChanged(0.7);
    (_photoEditor(tester) as dynamic).onOpacityChanged(0.31);
    await tester.pump();
    final beforeCancel = _photoTransform(tester) as dynamic;

    await _tapKey(tester, 'wizard-photo-replace');

    var editor = _photoEditor(tester) as dynamic;
    var transform = _photoTransform(tester) as dynamic;
    expect(editor.photoPath as String, 'C:/photos/board.png');
    expect(transform.translation as Offset, beforeCancel.translation as Offset);
    expect(transform.scale as double, beforeCancel.scale as double);
    expect(transform.rotation as double, beforeCancel.rotation as double);
    expect(transform.opacity as double, beforeCancel.opacity as double);

    await _tapKey(tester, 'wizard-photo-replace');

    editor = _photoEditor(tester) as dynamic;
    transform = _photoTransform(tester) as dynamic;
    expect(editor.photoPath as String, 'C:/photos/board.png');
    expect(transform.translation as Offset, const Offset(0.18, -0.12));
    expect(transform.scale as double, 2.4);
    expect(transform.rotation as double, closeTo(0.7, 0.000001));
    expect(transform.opacity as double, 0.31);
    expect(find.text('Foto valimine ebaõnnestus.'), findsOneWidget);
  });

  testWidgets('parent clamps scale and opacity and normalizes rotation',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>['C:/photos/board.webp']);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');

    (_photoEditor(tester) as dynamic).onScaleChanged(0.01);
    await tester.pump();
    expect((_photoTransform(tester) as dynamic).scale as double, 0.25);
    (_photoEditor(tester) as dynamic).onScaleChanged(50.0);
    await tester.pump();
    expect((_photoTransform(tester) as dynamic).scale as double, 8.0);

    (_photoEditor(tester) as dynamic).onRotationChanged(3 * math.pi);
    await tester.pump();
    final rotation = (_photoTransform(tester) as dynamic).rotation as double;
    expect(rotation, closeTo(-math.pi, 0.000001));
    expect(rotation, greaterThanOrEqualTo(-math.pi));
    expect(rotation, lessThan(math.pi));

    (_photoEditor(tester) as dynamic).onOpacityChanged(-4.0);
    await tester.pump();
    expect((_photoTransform(tester) as dynamic).opacity as double, 0.0);
    (_photoEditor(tester) as dynamic).onOpacityChanged(4.0);
    await tester.pump();
    expect((_photoTransform(tester) as dynamic).opacity as double, 1.0);

    (_photoEditor(tester) as dynamic).onTranslationChanged(
      const Offset(double.infinity, 0.25),
    );
    await tester.pump();
    final translation =
        (_photoTransform(tester) as dynamic).translation as Offset;
    expect(translation.dx.isFinite, isTrue);
    expect(translation.dy.isFinite, isTrue);
  });

  testWidgets(
      'reset preserves photo and opacity; replace resets; remove clears',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>[
      'C:/photos/front.jpg',
      'C:/photos/back.jpeg',
    ]);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');
    (_photoEditor(tester) as dynamic).onTranslationChanged(
      const Offset(0.22, -0.16),
    );
    (_photoEditor(tester) as dynamic).onScaleChanged(3.0);
    (_photoEditor(tester) as dynamic).onRotationChanged(1.2);
    (_photoEditor(tester) as dynamic).onOpacityChanged(0.27);
    await tester.pump();

    await _tapKey(tester, 'wizard-photo-reset');

    var editor = _photoEditor(tester) as dynamic;
    var transform = _photoTransform(tester) as dynamic;
    expect(editor.photoPath as String, 'C:/photos/front.jpg');
    expect(transform.translation as Offset, Offset.zero);
    expect(transform.scale as double, 1.0);
    expect(transform.rotation as double, 0.0);
    expect(transform.opacity as double, 0.27);

    await _tapKey(tester, 'wizard-photo-replace');

    editor = _photoEditor(tester) as dynamic;
    transform = _photoTransform(tester) as dynamic;
    expect(editor.photoPath as String, 'C:/photos/back.jpeg');
    expect(transform.translation as Offset, Offset.zero);
    expect(transform.scale as double, 1.0);
    expect(transform.rotation as double, 0.0);
    expect(transform.opacity as double, 0.65);

    await _tapKey(tester, 'wizard-photo-remove');

    expect(
      find.byKey(const ValueKey('wizard-photo-editor')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('wizard-photo-empty')),
      findsOneWidget,
    );
  });

  testWidgets('photo draft survives Step 2-3-4 navigation and resize',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>['C:/photos/board.png']);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');
    (_photoEditor(tester) as dynamic).onTranslationChanged(
      const Offset(0.19, -0.23),
    );
    (_photoEditor(tester) as dynamic).onScaleChanged(1.75);
    (_photoEditor(tester) as dynamic).onRotationChanged(-0.8);
    (_photoEditor(tester) as dynamic).onOpacityChanged(0.42);
    await tester.pump();

    await _tapKey(tester, 'wizard-next');
    expect(
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
    await _closeContour(tester);
    await _tapKey(tester, 'wizard-next');
    expect(
      find.byKey(const ValueKey('wizard-component-editor')),
      findsOneWidget,
    );
    await tester.binding.setSurfaceSize(const Size(390, 760));
    await tester.pump();

    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');

    final editor = _photoEditor(tester) as dynamic;
    final transform = _photoTransform(tester) as dynamic;
    expect(editor.photoPath as String, 'C:/photos/board.png');
    expect(transform.translation as Offset, const Offset(0.19, -0.23));
    expect(transform.scale as double, 1.75);
    expect(transform.rotation as double, closeTo(-0.8, 0.000001));
    expect(transform.opacity as double, 0.42);
    expect(tester.takeException(), isNull);
  });

  testWidgets('compact photo drag moves the photo without moving page scroll',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>['C:/photos/board.png']);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');
    final canvas = find.byKey(const ValueKey('wizard-photo-canvas'));
    await tester.ensureVisible(canvas);
    await tester.pump();
    final pageScroll = Scrollable.of(tester.element(canvas)).position;
    final scrollOffsetBeforeDrag = pageScroll.pixels;
    final rect = tester.getRect(canvas);
    final gesture = await tester.startGesture(rect.center);
    await gesture.moveBy(const Offset(35, 22.5));
    await tester.pump(const Duration(milliseconds: 16));
    await gesture.moveBy(const Offset(35, 22.5));
    await tester.pump(const Duration(milliseconds: 16));
    await gesture.up();
    await tester.pump();

    final translation =
        (_photoTransform(tester) as dynamic).translation as Offset;
    expect(pageScroll.pixels, closeTo(scrollOffsetBeforeDrag, 0.001));
    expect(translation.dx, greaterThan(0));
    expect(translation.dy, greaterThan(0));

    final title = find.byKey(const ValueKey('wizard-step-title'));
    await tester.ensureVisible(title);
    await tester.pump();
    final scrollBeforePageDrag = pageScroll.pixels;
    await tester.drag(title, const Offset(0, -180));
    await tester.pump();
    expect(pageScroll.pixels, greaterThan(scrollBeforePageDrag));
    expect(tester.takeException(), isNull);
  });

  testWidgets('mobile photo action is honest and never invokes the picker',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>['C:/photos/board.png']);
    _installPhotoPicker(picker);
    final platformInfo = _MutableTestPlatformInfo(false);
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        platformInfo: platformInfo,
      ),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    platformInfo.isMobile = true;
    await tester.pump();
    await _tapKey(tester, 'wizard-photo-pick');

    expect(picker.pickCount, 0);
    expect(
      find.text(
        'Foto valimine on selles versioonis saadaval ainult '
        'töölauarakenduses.',
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-photo-editor')),
      findsNothing,
    );
  });

  testWidgets('candidate mutation participates in dirty-draft cancellation',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.3, 0.7));
    await _tapKey(tester, 'wizard-cancel');

    expect(find.text('Katkestada projekti loomine?'), findsOneWidget);
    expect(find.text('Sisestatud andmeid ei salvestata.'), findsOneWidget);
  });

  testWidgets('contour mutation participates in dirty-draft cancellation',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    await _tapContourAt(tester, const Offset(0.3, 0.35));
    await _tapKey(tester, 'wizard-cancel');

    expect(
      find.text('Katkestada projekti loomine?'),
      findsOneWidget,
    );
    expect(find.text('Sisestatud andmeid ei salvestata.'), findsOneWidget);
  });

  testWidgets(
      'selected parent path and safety copy state zero-write limitations',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _tapKey(tester, 'wizard-pick-folder');

    expect(find.text('C:/projects'), findsOneWidget);
    expect(
      find.text(
        'Lõplik projekti loomine ei ole selles wizardis veel rakendatud.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('Salvestuskoha valimine ei loo kausta ega faili.'),
      findsOneWidget,
    );
    expect(
      find.text('Projekt luuakse alles wizardi lõpetamisel.'),
      findsNothing,
    );
    expect(find.textContaining('projektikaust'), findsNothing);
    expect(find.textContaining('kirjutatav'), findsNothing);
    expect(find.textContaining('kollisioon'), findsNothing);
  });

  testWidgets('back and forward navigation preserve every Step 1 draft value',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _completeStepOne(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-back');

    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-project-name')),
          )
          .controller!
          .text,
      'Pelle PV20',
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-device-name')),
          )
          .controller!
          .text,
      'Põletikontroller',
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-additional-info')),
          )
          .controller!
          .text,
      'Vahelduv väljalülitumine.',
    );
    expect(find.text('C:/projects'), findsOneWidget);

    await _tapKey(tester, 'wizard-next');
    expect(
      find.byKey(const ValueKey('wizard-photo-step')),
      findsOneWidget,
    );
  });

  testWidgets('Steps 5 through 7 remain honest non-functional placeholders',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-next');

    const labels = <int, String>{
      5: 'Probleemi kirjeldus',
      6: 'Kontroll ja kinnitus',
      7: 'Kokkuvõte',
    };
    for (final entry in labels.entries) {
      final placeholder = find.byKey(
        ValueKey('wizard-placeholder-${entry.key}'),
      );
      expect(placeholder, findsOneWidget);
      expect(
        find.descendant(
          of: placeholder,
          matching: find.text(entry.value),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: placeholder,
          matching: find.text('Tulekul'),
        ),
        findsOneWidget,
      );
      if (entry.key < 7) {
        await _tapKey(tester, 'wizard-next');
      }
    }

    expect(find.byKey(const ValueKey('wizard-create')), findsNothing);
    expect(find.text('Loo projekt ja ava töölaud'), findsNothing);
    expect(find.byKey(const ValueKey('wizard-next')), findsNothing);
  });

  testWidgets('multiline Lisainfo accepts Enter without advancing',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _enterText(
      tester,
      'wizard-additional-info',
      'Esimene rida\nTeine rida',
    );

    final field = tester.widget<TextField>(
      find.byKey(const ValueKey('wizard-additional-info')),
    );
    expect(field.controller!.text, 'Esimene rida\nTeine rida');
    expect(field.keyboardType, TextInputType.multiline);
    expect(field.textInputAction, TextInputAction.newline);
    expect(
      find.byKey(const ValueKey('wizard-step-1-editor')),
      findsOneWidget,
    );
  });

  testWidgets('untouched cancellation returns Home without a dialog',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _tapKey(tester, 'wizard-cancel');

    expect(find.byKey(const ValueKey('test-home')), findsOneWidget);
    expect(
      find.text('Katkestada projekti loomine?'),
      findsNothing,
    );
  });

  testWidgets('touched cancellation shows the locked confirmation dialog',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _enterText(tester, 'wizard-device-name', 'Põletikontroller');
    await _tapKey(tester, 'wizard-cancel');

    expect(
      find.text('Katkestada projekti loomine?'),
      findsOneWidget,
    );
    expect(
      find.text('Sisestatud andmeid ei salvestata.'),
      findsOneWidget,
    );
    expect(find.text('Jätka loomist'), findsOneWidget);
    expect(find.text('Katkesta'), findsWidgets);
  });

  testWidgets('Jätka loomist preserves draft values and current step',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _completeStepOne(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-cancel');
    await _tapKey(tester, 'wizard-cancel-dialog-continue');

    expect(
      find.byKey(const ValueKey('wizard-photo-step')),
      findsOneWidget,
    );

    await _tapKey(tester, 'wizard-back');
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-project-name')),
          )
          .controller!
          .text,
      'Pelle PV20',
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-device-name')),
          )
          .controller!
          .text,
      'Põletikontroller',
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-additional-info')),
          )
          .controller!
          .text,
      'Vahelduv väljalülitumine.',
    );
    expect(find.text('C:/projects'), findsOneWidget);
  });

  testWidgets('confirmed Katkesta returns Home', (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _enterText(tester, 'wizard-project-name', 'Pelle PV20');
    await _tapKey(tester, 'wizard-cancel');
    await _tapKey(tester, 'wizard-cancel-dialog-confirm');

    expect(find.byKey(const ValueKey('test-home')), findsOneWidget);
  });

  testWidgets('mobile folder action does not invoke the picker',
      (tester) async {
    var pickerOpened = false;
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async {
          pickerOpened = true;
          return 'C:/projects';
        },
        platformInfo: const _TestPlatformInfo(true),
      ),
    );
    await tester.pump();

    await _tapKey(tester, 'wizard-pick-folder');

    expect(
      find.text('Uue projekti loomine tuleb järgmises versioonis.'),
      findsOneWidget,
    );
    expect(pickerOpened, isFalse);
    expect(find.text('C:/projects'), findsNothing);
  });

  testWidgets('wide desktop layout has no overflow', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await _openContourStep(tester);

    expect(
      find.byKey(const ValueKey('wizard-wide-layout')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('compact layout has no overflow', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await _openContourStep(tester);

    expect(
      find.byKey(const ValueKey('wizard-compact-layout')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Step 4 wide desktop layout is operable without overflow',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.35, 0.55));
    await _dragComponentCandidate(
      tester,
      from: const Offset(0.35, 0.55),
      to: const Offset(0.65, 0.72),
    );

    expect(
      find.byKey(const ValueKey('wizard-wide-layout')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-component-editor')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-component-delete')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Step 4 compact layout is operable without overflow',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.35, 0.55));
    final componentCanvas = find.byKey(
      const ValueKey('wizard-component-canvas'),
    );
    await tester.ensureVisible(componentCanvas);
    await tester.pump();
    final pageScroll = Scrollable.of(tester.element(componentCanvas)).position;
    final scrollOffsetBeforeDrag = pageScroll.pixels;
    await _dragComponentCandidate(
      tester,
      from: const Offset(0.35, 0.55),
      to: const Offset(0.65, 0.72),
    );
    final movedPosition = _paintedComponentPositions(tester).single;

    expect(
      find.byKey(const ValueKey('wizard-compact-layout')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-component-editor')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-component-delete')),
      findsOneWidget,
    );
    expect(movedPosition.dx, closeTo(0.65, 0.001));
    expect(movedPosition.dy, closeTo(0.72, 0.001));
    expect(pageScroll.pixels, closeTo(scrollOffsetBeforeDrag, 0.001));
    expect(tester.takeException(), isNull);
  });

  testWidgets('progress distinguishes completion from viewed placeholders',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    final firstProgress = find.byKey(
      const ValueKey('wizard-progress-step-1'),
    );
    expect(
      find.descendant(
        of: firstProgress,
        matching: find.text('Praegune samm'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: firstProgress,
        matching: find.byIcon(Icons.radio_button_checked),
      ),
      findsWidgets,
    );

    await _completeStepOne(tester);
    await _tapKey(tester, 'wizard-next');

    expect(
      find.descendant(
        of: firstProgress,
        matching: find.text('Valmis'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: firstProgress,
        matching: find.byIcon(Icons.check_circle),
      ),
      findsWidgets,
    );
    final secondProgress = find.byKey(
      const ValueKey('wizard-progress-step-2'),
    );
    expect(
      find.descendant(
        of: secondProgress,
        matching: find.text('Praegune samm'),
      ),
      findsOneWidget,
    );

    await _tapKey(tester, 'wizard-next');

    expect(
      find.descendant(
        of: secondProgress,
        matching: find.text('Vaadatud'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: secondProgress,
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );
    final thirdProgress = find.byKey(
      const ValueKey('wizard-progress-step-3'),
    );
    expect(
      find.descendant(
        of: thirdProgress,
        matching: find.text('Praegune samm'),
      ),
      findsOneWidget,
    );

    await _closeContour(tester);
    await _tapKey(tester, 'wizard-next');

    expect(
      find.descendant(
        of: thirdProgress,
        matching: find.text('Valmis'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: thirdProgress,
        matching: find.byIcon(Icons.check_circle),
      ),
      findsWidgets,
    );

    for (var step = 4; step < 7; step += 1) {
      await _tapKey(tester, 'wizard-next');
    }

    for (var step = 4; step < 7; step += 1) {
      final placeholderProgress = find.byKey(
        ValueKey('wizard-progress-step-$step'),
      );
      expect(
        find.descendant(
          of: placeholderProgress,
          matching: find.text('Vaadatud'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: placeholderProgress,
          matching: find.text('Valmis'),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: placeholderProgress,
          matching: find.byIcon(Icons.visibility_outlined),
        ),
        findsWidgets,
      );
    }

    final seventhProgress = find.byKey(
      const ValueKey('wizard-progress-step-7'),
    );
    expect(
      find.descendant(
        of: seventhProgress,
        matching: find.text('Praegune samm'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: seventhProgress,
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );
  });

  testWidgets('no creator, project-state, or project-route action is reachable',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.35, 0.65));
    for (var step = 4; step < 7; step += 1) {
      await _tapKey(tester, 'wizard-next');
    }

    final context = tester.element(
      find.byKey(const ValueKey('wizard-placeholder-7')),
    );
    expect(
      GoRouter.of(context).routeInformationProvider.value.uri.path,
      '/new-project',
    );
    expect(find.byKey(const ValueKey('wizard-create')), findsNothing);
    expect(find.text('Loo projekt ja ava töölaud'), findsNothing);
    expect(find.textContaining('/project'), findsNothing);
  });
}
