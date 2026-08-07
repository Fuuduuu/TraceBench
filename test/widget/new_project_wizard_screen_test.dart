import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show SemanticsAction;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/features/project/screens/new_project_wizard_screen.dart';
import 'package:trace_bench_viewer/features/project/widgets/new_project_wizard_problem_description.dart';
import 'package:trace_bench_viewer/features/project/widgets/wizard_compact_widgets.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/wizard_intake.dart';
import 'package:trace_bench_viewer/shared/services/project_creator.dart';
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
  Future<ProjectCreationResult> Function(ProjectCreationRequest)? createProject,
  ValueChanged<ProjectState>? onProjectCreated,
  double textScale = 1,
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
          createProject: createProject ??
              (_) async => const ProjectCreationFailed(
                    sanitizedMessage: 'Test creation failure.',
                  ),
          onProjectCreated: onProjectCreated,
        ),
      ),
      GoRoute(
        path: '/project',
        builder: (_, __) => const Scaffold(
          key: ValueKey('test-project'),
          body: Center(child: Text('Test Project')),
        ),
      ),
    ],
  );
  addTearDown(router.dispose);

  return MaterialApp.router(
    theme: ThemeData(useMaterial3: true),
    routerConfig: router,
    builder: textScale == 1
        ? null
        : (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(textScale),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
  );
}

ProjectState _createdProjectState({
  String projectName = 'Loodud projekt',
  String projectId = 'prj_a1b2c3d4',
  String projectDirectory = 'C:/projects/prj_a1b2c3d4',
  WizardIntake? wizardIntake,
}) {
  return ProjectState(
    manifest: ProjectManifest(
      projectId: projectId,
      schemaVersion: '1.0',
      createdAt: '2026-08-04T10:00:00Z',
      projectName: projectName,
      deviceName: 'Põletikontroller',
      additionalInfo: 'Vahelduv väljalülitumine.',
      deviceType: 'Põletikontroller',
      manufacturer: 'Pelle',
      model: 'PV20',
      revision: 'REV_0.1',
      symptom: 'Toide katkeb.',
    ),
    knownFacts: KnownFacts(
      projectId: projectId,
      components: const [],
      pins: const [],
      measurements: const [],
      nets: const [],
      excludedFromFaultCandidates: const [],
      componentPinIndex: const {},
      photos: const [],
      damageRegions: const [],
      suspectRegions: const [],
      visualTraces: const [],
    ),
    events: const [],
    customerReport: '# Test report\n',
    projectDirectory: projectDirectory,
    wizardIntake: wizardIntake,
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
  String? deviceType,
  String? manufacturer,
  String? model,
  String? revision,
}) async {
  await _enterText(tester, 'wizard-project-name', projectName);
  await _enterText(tester, 'wizard-device-name', deviceName);
  await _enterText(tester, 'wizard-additional-info', additionalInfo);
  await _tapKey(tester, 'wizard-pick-folder');
  if (<String?>[deviceType, manufacturer, model, revision]
      .any((value) => value != null)) {
    await _tapKey(tester, 'wizard-step-one-advanced');
    await _enterText(tester, 'wizard-device-type', deviceType ?? '');
    await _enterText(tester, 'wizard-manufacturer', manufacturer ?? '');
    await _enterText(tester, 'wizard-model', model ?? '');
    await _enterText(tester, 'wizard-revision', revision ?? '');
  }
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

Future<void> _openProblemDescriptionStep(WidgetTester tester) async {
  await _openComponentPlacementStep(tester);
  await _tapKey(tester, 'wizard-next');
}

Future<void> _completeProblemDescription(WidgetTester tester) async {
  await _enterText(
    tester,
    'wizard-problem-description',
    '  Toide katkeb.\nVahel taastub.  ',
  );
  await _enterText(
    tester,
    'wizard-problem-when',
    'Pärast soojenemist',
  );
  await _enterText(
    tester,
    'wizard-problem-symptoms',
    'LED vilgub\nja kostab klõps',
  );
  await _enterText(
    tester,
    'wizard-problem-attempts',
    'Toitekaabel vahetatud',
  );
  await _tapKey(tester, 'wizard-problem-occurrence-intermittent');
}

Future<void> _openReviewStep(WidgetTester tester) async {
  await _openProblemDescriptionStep(tester);
  await _completeProblemDescription(tester);
  await _tapKey(tester, 'wizard-next');
}

Finder _progressStep(int stepNumber) {
  return find.byKey(ValueKey('wizard-progress-step-$stepNumber'));
}

void _expectProgressStatus(int stepNumber, String status) {
  expect(
    find.descendant(
      of: _progressStep(stepNumber),
      matching: find.text(status),
    ),
    findsOneWidget,
  );
}

bool _progressHasTapAction(WidgetTester tester, int stepNumber) {
  return tester
      .getSemantics(_progressStep(stepNumber))
      .getSemanticsData()
      .hasAction(SemanticsAction.tap);
}

bool _progressHasButtonFlag(WidgetTester tester, int stepNumber) {
  return tester
      .getSemantics(_progressStep(stepNumber))
      .getSemanticsData()
      .flagsCollection
      .isButton;
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

Future<void> _tapComponentFromCentreOffset(
  WidgetTester tester, {
  required Offset centre,
  required Offset canvasOffset,
}) async {
  final canvas = find.byKey(const ValueKey('wizard-component-canvas'));
  await tester.ensureVisible(canvas);
  await tester.pump();
  final rect = _componentCanvasRect(tester);
  final centreOnCanvas = Offset(
    rect.width * centre.dx,
    rect.height * centre.dy,
  );
  await tester.tapAt(rect.topLeft + centreOnCanvas + canvasOffset);
  await _pumpFrames(tester);
}

Future<void> _dragComponentFromCentreOffset(
  WidgetTester tester, {
  required Offset centre,
  required Offset canvasOffset,
  required Offset dragDelta,
}) async {
  final canvas = find.byKey(const ValueKey('wizard-component-canvas'));
  await tester.ensureVisible(canvas);
  await tester.pump();
  final rect = _componentCanvasRect(tester);
  final centreOnCanvas = Offset(
    rect.width * centre.dx,
    rect.height * centre.dy,
  );
  final start = rect.topLeft + centreOnCanvas + canvasOffset;
  final gesture = await tester.startGesture(start);
  await gesture.moveTo(start + dragDelta * 0.5);
  await tester.pump(const Duration(milliseconds: 16));
  await gesture.moveTo(start + dragDelta);
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

dynamic _componentGeometry(
  WidgetTester tester,
  int draftKey,
) {
  final geometries = List<dynamic>.from(
    (_componentPainter(tester) as dynamic).markerGeometries(
      _componentCanvasRect(tester).size,
    ) as Iterable,
  );
  return geometries.singleWhere(
    (geometry) => (geometry as dynamic).draftKey == draftKey,
  );
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

typedef _ComponentStyleSnapshot = ({
  int draftKey,
  Offset position,
  String shape,
  double sizeScale,
  double rotation,
});

List<_ComponentStyleSnapshot> _paintedComponentStyles(
  WidgetTester tester,
) {
  return _paintedComponentCandidates(tester).map((candidate) {
    final value = candidate as dynamic;
    return (
      draftKey: value.draftKey as int,
      position: value.position as Offset,
      shape: value.shape.toString().split('.').last,
      sizeScale: value.sizeScale as double,
      rotation: value.rotation as double,
    );
  }).toList(growable: false);
}

Future<void> _setComponentSize(
  WidgetTester tester,
  double value,
) async {
  final slider = tester.widget<Slider>(
    find.byKey(const ValueKey('wizard-component-size-slider')),
  );
  slider.onChanged!(value);
  await _pumpFrames(tester);
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
      'Projekt loodud',
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

  testWidgets(
      'Step 1 advanced drafts retain raw values and never change its gate',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _tapKey(tester, 'wizard-step-one-advanced');
    expect(find.text('Täpsemalt'), findsOneWidget);
    expect(find.textContaining('AI'), findsWidgets);

    await _enterText(tester, 'wizard-device-type', '  Kontroller  ');
    await _enterText(tester, 'wizard-manufacturer', '  Pelle  ');
    await _enterText(tester, 'wizard-model', '  PV20  ');
    await _enterText(tester, 'wizard-revision', '  REV_0.1  ');
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNull,
    );

    await _completeStepOne(tester);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNotNull,
    );
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-back');

    String advancedText(String key) => tester
        .widget<TextField>(find.byKey(ValueKey<String>(key)))
        .controller!
        .text;
    expect(advancedText('wizard-device-type'), '  Kontroller  ');
    expect(advancedText('wizard-manufacturer'), '  Pelle  ');
    expect(advancedText('wizard-model'), '  PV20  ');
    expect(advancedText('wizard-revision'), '  REV_0.1  ');
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

  testWidgets(
      'a point can be selected, dragged, and ignores out-of-frame moves',
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
    expect(moved.dx, closeTo(0.825, 0.001));
    expect(moved.dy, closeTo(0.8, 0.001));
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

  testWidgets(
      'Step 3 latches one fitted reference frame that Step 4 reuses after resize',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>['C:/Photos/BOARD.JPG']);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openContourStep(tester);
    final initialCanvas = _contourCanvasRect(tester);
    final latchedAspect = initialCanvas.width / initialCanvas.height;
    await _closeContour(tester);

    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-photo-pick');
    await _tapKey(tester, 'wizard-photo-remove');
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-contour-reset');
    expect(_paintedContourPoints(tester), isEmpty);
    await _closeContour(tester);

    await tester.binding.setSurfaceSize(const Size(720, 1000));
    await tester.pumpAndSettle();
    final resizedCanvas = _contourCanvasRect(tester);
    final resizedContourFrame = tester.getRect(
      find.byKey(const ValueKey('wizard-contour-painter')),
    );
    expect(
      (resizedCanvas.width / resizedCanvas.height - latchedAspect).abs(),
      greaterThan(0.1),
      reason: 'The resized editor must differ enough to exercise letterboxing.',
    );
    expect(
      resizedContourFrame.width / resizedContourFrame.height,
      closeTo(latchedAspect, 0.001),
      reason: 'Step 3 must retain the first authoring-plane aspect.',
    );

    await _tapKey(tester, 'wizard-next');
    final componentCanvas = _componentCanvasRect(tester);
    final componentFrame = tester.getRect(
      find.byKey(const ValueKey('wizard-component-painter')),
    );
    expect(
      componentFrame.width / componentFrame.height,
      closeTo(latchedAspect, 0.001),
      reason: 'Step 4 must reuse the Step 3 reference plane.',
    );
    expect(componentFrame.size, resizedContourFrame.size);

    final inertBarPoint = componentFrame.left > componentCanvas.left + 1
        ? Offset(componentCanvas.left + 1, componentCanvas.center.dy)
        : Offset(componentCanvas.center.dx, componentCanvas.top + 1);
    expect(componentFrame.contains(inertBarPoint), isFalse);
    await tester.tapAt(inertBarPoint);
    await _pumpFrames(tester);
    expect(
      _paintedComponentCandidates(tester),
      isEmpty,
      reason: 'A letterbox tap must not create a visual candidate.',
    );
  });

  testWidgets(
      'Step 4 exposes the compact status shape rotation and boundary contract',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);

    final status = find.byKey(
      const ValueKey('wizard-component-status'),
    );
    expect(status, findsOneWidget);
    for (final detailKey in const <String>[
      'wizard-component-count',
      'wizard-component-selection',
      'wizard-component-contour-guide',
      'wizard-component-style-summary',
    ]) {
      expect(
        find.descendant(
          of: status,
          matching: find.byKey(ValueKey(detailKey)),
        ),
        findsOneWidget,
      );
    }

    final shapeGrid = find.byKey(
      const ValueKey('wizard-component-shape-grid'),
    );
    expect(shapeGrid, findsOneWidget);

    const shapeChoices = <String, String>{
      'wizard-component-shape-circle': 'Ümar',
      'wizard-component-shape-square': 'Ruut',
      'wizard-component-shape-rectangle': 'Ristkülik',
      'wizard-component-shape-rounded-rectangle': 'Ümardatud ristkülik',
    };
    for (final entry in shapeChoices.entries) {
      final choice = find.byKey(ValueKey(entry.key));
      expect(choice, findsOneWidget);
      expect(
        tester.getSemantics(choice).label,
        contains(entry.value),
      );
    }
    expect(find.byType(ChoiceChip), findsNWidgets(4));
    final shapeRects = shapeChoices.keys
        .map((key) => tester.getRect(find.byKey(ValueKey(key))))
        .toList(growable: false);
    expect(shapeRects[0].width, closeTo(shapeRects[1].width, 0.001));
    expect(shapeRects[0].width, closeTo(shapeRects[2].width, 0.001));
    expect(shapeRects[0].width, closeTo(shapeRects[3].width, 0.001));
    expect(shapeRects[0].top, closeTo(shapeRects[1].top, 0.001));
    expect(shapeRects[2].top, closeTo(shapeRects[3].top, 0.001));
    expect(shapeRects[2].top, greaterThan(shapeRects[0].bottom));

    final summary = find.byKey(
      const ValueKey('wizard-component-style-summary'),
    );
    expect(summary, findsOneWidget);
    expect(find.text('Järgmine: Ümar · 100% · 0°'), findsOneWidget);
    expect(
      tester.getSemantics(summary).label,
      contains('Järgmine: Ümar · 100% · 0°'),
    );

    final slider = tester.widget<Slider>(
      find.byKey(const ValueKey('wizard-component-size-slider')),
    );
    expect(slider.min, 0.5);
    expect(slider.max, 2.5);
    expect(slider.value, 1.0);
    expect(
      tester
          .getSemantics(
            find.byKey(const ValueKey('wizard-component-size-slider')),
          )
          .label,
      contains('Markeri suurus'),
    );
    expect(
      tester
          .getSemantics(
            find.byKey(const ValueKey('wizard-component-size-slider')),
          )
          .value,
      '100%',
    );

    const rotationControls = <String, (String, IconData)>{
      'wizard-component-rotate-minus': (
        'Pööra markerit 15° vasakule',
        Icons.rotate_left,
      ),
      'wizard-component-rotate-plus': (
        'Pööra markerit 15° paremale',
        Icons.rotate_right,
      ),
      'wizard-component-rotate-reset': (
        'Nulli markeri pööre 0°',
        Icons.refresh,
      ),
    };
    for (final entry in rotationControls.entries) {
      final control = find.byKey(ValueKey(entry.key));
      expect(control, findsOneWidget);
      final iconButton = find.descendant(
        of: control,
        matching: find.byType(IconButton),
      );
      expect(iconButton, findsOneWidget);
      expect(tester.widget<IconButton>(iconButton).tooltip, entry.value.$1);
      expect(tester.getSemantics(control).label, contains(entry.value.$1));
      expect(
        find.descendant(of: control, matching: find.byIcon(entry.value.$2)),
        findsOneWidget,
      );
    }

    final rotationValue = find.byKey(
      const ValueKey('wizard-component-rotation-value'),
    );
    expect(rotationValue, findsOneWidget);
    expect(find.descendant(of: rotationValue, matching: find.text('0°')),
        findsOneWidget);
    expect(tester.getSemantics(rotationValue).label, 'Markeri pööre: 0°');

    const boundaryCopy =
        'Kandidaadid on inimese loodud visuaalsed ettepanekud. Need ei '
        'kinnita komponendi identiteeti, tüüpi, väärtust, tähist, korpust, '
        'jalajälge, jalgu, kontakte, plaadipoolt, ühendusi, võrku, mõõtmist '
        'ega diagnoosi ning ei loo püsivat ega kanoonilist fakti.';
    final boundary = find.byKey(
      const ValueKey('wizard-component-boundary-note'),
    );
    expect(boundary, findsOneWidget);
    expect(find.descendant(of: boundary, matching: find.text(boundaryCopy)),
        findsOneWidget);
    expect(_paintedComponentCandidates(tester), isEmpty);
  });

  testWidgets(
      'rotation readout is signed and reset preserves non-rotation data',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-component-shape-rectangle');
    await _setComponentSize(tester, 1.6);
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapComponentAt(tester, const Offset(0.42, 0.58));
    final beforeReset = _paintedComponentStyles(tester).single;

    await _tapKey(tester, 'wizard-component-rotate-reset');
    final afterReset = _paintedComponentStyles(tester).single;
    expect(afterReset.draftKey, beforeReset.draftKey);
    expect(afterReset.position, beforeReset.position);
    expect(afterReset.shape, beforeReset.shape);
    expect(afterReset.sizeScale, beforeReset.sizeScale);
    expect(afterReset.rotation, 0.0);
    expect(find.text('0°'), findsWidgets);
    expect(
      tester
          .getSemantics(
            find.byKey(
              const ValueKey('wizard-component-rotation-value'),
            ),
          )
          .label,
      'Markeri pööre: 0°',
    );

    await _tapKey(tester, 'wizard-component-rotate-minus');
    expect(find.text('-15°'), findsOneWidget);
    expect(
      tester
          .getSemantics(
            find.byKey(
              const ValueKey('wizard-component-rotation-value'),
            ),
          )
          .label,
      'Markeri pööre: -15°',
    );
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapKey(tester, 'wizard-component-rotate-plus');
    expect(find.text('+15°'), findsOneWidget);
    expect(
      tester
          .getSemantics(
            find.byKey(
              const ValueKey('wizard-component-rotation-value'),
            ),
          )
          .label,
      'Markeri pööre: +15°',
    );
  });

  testWidgets('a new marker inherits the complete current style',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-component-shape-rectangle');
    await _setComponentSize(tester, 1.4);
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapKey(tester, 'wizard-component-rotate-plus');

    expect(_paintedComponentCandidates(tester), isEmpty);
    expect(
      find.text('Järgmine: Ristkülik · 140% · 30°'),
      findsOneWidget,
    );

    await _tapComponentAt(tester, const Offset(0.22, 0.31));
    final inherited = _paintedComponentStyles(tester).single;
    expect(inherited.draftKey, 1);
    expect(inherited.position.dx, closeTo(0.22, 0.001));
    expect(inherited.position.dy, closeTo(0.31, 0.001));
    expect(inherited.shape, 'rectangle');
    expect(inherited.sizeScale, closeTo(1.4, 0.000001));
    expect(inherited.rotation, closeTo(math.pi / 6, 0.000001));
    expect(
      find.text('Valitud: Ristkülik · 140% · 30°'),
      findsOneWidget,
    );
  });

  testWidgets(
      'selection loads style and selected edits preserve independent geometry',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-component-shape-square');
    await _setComponentSize(tester, 0.8);
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapComponentAt(tester, const Offset(0.25, 0.35));
    await _tapComponentAt(tester, const Offset(0.75, 0.35));

    await _tapKey(tester, 'wizard-component-shape-rounded-rectangle');
    await _setComponentSize(tester, 2.0);
    await _tapKey(tester, 'wizard-component-rotate-minus');
    final secondBefore = _paintedComponentStyles(tester).last;

    await _tapComponentAt(tester, const Offset(0.25, 0.35));
    expect(
      find.text('Valitud: Ruut · 80% · 30°'),
      findsOneWidget,
    );
    final firstObjectBefore = _paintedComponentCandidates(tester).first;
    final firstBefore = _paintedComponentStyles(tester).first;

    await _tapKey(tester, 'wizard-component-shape-rectangle');
    var styles = _paintedComponentStyles(tester);
    expect(
        identical(_paintedComponentCandidates(tester).first, firstObjectBefore),
        isFalse);
    expect(
      (firstObjectBefore as dynamic).shape.toString().split('.').last,
      'square',
    );
    expect(styles.first.draftKey, firstBefore.draftKey);
    expect(styles.first.position, firstBefore.position);
    expect(styles.first.shape, 'rectangle');
    expect(styles.first.sizeScale, firstBefore.sizeScale);
    expect(styles.first.rotation, firstBefore.rotation);
    expect(styles.last, secondBefore);

    await _setComponentSize(tester, 1.6);
    styles = _paintedComponentStyles(tester);
    expect(styles.first.draftKey, firstBefore.draftKey);
    expect(styles.first.position, firstBefore.position);
    expect(styles.first.shape, 'rectangle');
    expect(styles.first.sizeScale, closeTo(1.6, 0.000001));
    expect(styles.first.rotation, firstBefore.rotation);
    expect(styles.last, secondBefore);

    await _tapKey(tester, 'wizard-component-rotate-plus');
    styles = _paintedComponentStyles(tester);
    expect(styles.first.draftKey, firstBefore.draftKey);
    expect(styles.first.position, firstBefore.position);
    expect(styles.first.shape, 'rectangle');
    expect(styles.first.sizeScale, closeTo(1.6, 0.000001));
    expect(styles.first.rotation, closeTo(math.pi / 4, 0.000001));
    expect(styles.last, secondBefore);

    await _tapKey(tester, 'wizard-component-shape-circle');
    styles = _paintedComponentStyles(tester);
    expect(styles.first.shape, 'circle');
    expect(styles.first.rotation, closeTo(math.pi / 4, 0.000001));
    expect(find.text('Valitud: Ümar · 160% · 45°'), findsOneWidget);
  });

  testWidgets('rotation normalizes and drag-delete retains the current style',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-component-shape-rounded-rectangle');
    await _setComponentSize(tester, 1.6);
    for (var index = 0; index < 13; index += 1) {
      await _tapKey(tester, 'wizard-component-rotate-plus');
    }
    await _tapComponentAt(tester, const Offset(0.4, 0.52));

    var style = _paintedComponentStyles(tester).single;
    expect(style.rotation, greaterThanOrEqualTo(-math.pi));
    expect(style.rotation, lessThan(math.pi));
    expect(style.rotation, closeTo(-11 * math.pi / 12, 0.000001));

    await _dragComponentCandidate(
      tester,
      from: const Offset(0.4, 0.52),
      to: const Offset(0.63, 0.7),
    );
    final moved = _paintedComponentStyles(tester).single;
    expect(moved.draftKey, style.draftKey);
    expect(moved.position.dx, closeTo(0.63, 0.001));
    expect(moved.position.dy, closeTo(0.7, 0.001));
    expect(moved.shape, style.shape);
    expect(moved.sizeScale, style.sizeScale);
    expect(moved.rotation, style.rotation);

    await _tapKey(tester, 'wizard-component-delete');
    expect(_paintedComponentCandidates(tester), isEmpty);
    expect(
      find.text('Järgmine: Ümardatud ristkülik · 160% · -165°'),
      findsOneWidget,
    );

    await _tapComponentAt(tester, const Offset(0.2, 0.25));
    style = _paintedComponentStyles(tester).single;
    expect(style.draftKey, 2);
    expect(style.shape, 'roundedRectangle');
    expect(style.sizeScale, closeTo(1.6, 0.000001));
    expect(style.rotation, closeTo(-11 * math.pi / 12, 0.000001));
  });

  testWidgets('marker geometry uses relative size, floor, and shape ratios',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _setComponentSize(tester, 0.5);
    await _tapComponentAt(tester, const Offset(0.5, 0.5));

    var geometry = _componentGeometry(tester, 1) as dynamic;
    expect(geometry.minorDimension as double, 8.0);
    expect((geometry.markerSize as Size).width, 8.0);
    expect((geometry.markerSize as Size).height, 8.0);
    expect((geometry.hitBounds as Rect).width, greaterThanOrEqualTo(56.0));
    expect((geometry.hitBounds as Rect).height, greaterThanOrEqualTo(56.0));
    expect(
      (geometry.localPath as Path).contains(const Offset(3.9, 3.9)),
      isFalse,
    );

    await _tapKey(tester, 'wizard-component-shape-square');
    geometry = _componentGeometry(tester, 1) as dynamic;
    expect((geometry.markerSize as Size).aspectRatio, 1.0);
    expect(
      (geometry.localPath as Path).contains(const Offset(3.9, 3.9)),
      isTrue,
    );

    await _tapKey(tester, 'wizard-component-shape-rectangle');
    geometry = _componentGeometry(tester, 1) as dynamic;
    expect((geometry.markerSize as Size).aspectRatio, closeTo(1.8, 0.000001));

    await _tapKey(tester, 'wizard-component-shape-rounded-rectangle');
    geometry = _componentGeometry(tester, 1) as dynamic;
    expect((geometry.markerSize as Size).aspectRatio, closeTo(2.2, 0.000001));
    final markerSize = geometry.markerSize as Size;
    expect(
      (geometry.localPath as Path).contains(
        Offset(markerSize.width / 2 - 0.1, markerSize.height / 2 - 0.1),
      ),
      isFalse,
    );
  });

  testWidgets('default marker is smaller than the predecessor fixed marker',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.5, 0.5));
    final canvasSize = _componentCanvasRect(tester).size;
    final geometry = _componentGeometry(tester, 1) as dynamic;
    final expectedMinor = math.max(
      8.0,
      canvasSize.shortestSide * 0.035,
    );

    expect(
      geometry.minorDimension as double,
      closeTo(expectedMinor, 0.000001),
    );
    expect(geometry.minorDimension as double, lessThan(22.0));
  });

  testWidgets('rotated rectangle corners and elongated ends stay draggable',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-component-shape-rectangle');
    await _setComponentSize(tester, 2.5);
    await _tapComponentAt(tester, const Offset(0.5, 0.5));
    var geometry = _componentGeometry(tester, 1) as dynamic;
    final unrotatedSize = geometry.markerSize as Size;
    final endOffset = Offset(unrotatedSize.width / 2 - 1, 0);

    await _tapComponentFromCentreOffset(
      tester,
      centre: const Offset(0.5, 0.5),
      canvasOffset: endOffset,
    );
    expect(_paintedComponentDraftKeys(tester), const <int>[1]);
    expect(_paintedSelectedComponentDraftKey(tester), 1);

    await _dragComponentFromCentreOffset(
      tester,
      centre: const Offset(0.5, 0.5),
      canvasOffset: endOffset,
      dragDelta: const Offset(36, 24),
    );
    final moved = _paintedComponentPositions(tester).single;
    expect(moved.dx, greaterThan(0.5));
    expect(moved.dy, greaterThan(0.5));

    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapKey(tester, 'wizard-component-rotate-plus');
    geometry = _componentGeometry(tester, 1) as dynamic;
    final markerSize = geometry.markerSize as Size;
    final rotation = geometry.effectiveRotation as double;
    final localCorner = Offset(
      markerSize.width * 0.46,
      markerSize.height * 0.46,
    );
    final rotatedCorner = Offset(
      localCorner.dx * math.cos(rotation) - localCorner.dy * math.sin(rotation),
      localCorner.dx * math.sin(rotation) + localCorner.dy * math.cos(rotation),
    );

    await _tapComponentFromCentreOffset(
      tester,
      centre: moved,
      canvasOffset: rotatedCorner,
    );
    expect(_paintedComponentDraftKeys(tester), const <int>[1]);
    expect(_paintedSelectedComponentDraftKey(tester), 1);
    expect(
      (geometry.rotatedBounds as Rect).contains(
        (geometry.centre as Offset) + rotatedCorner,
      ),
      isTrue,
    );
  });

  testWidgets('overlapping targets choose closest centre then insertion order',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.35, 0.5));
    await _tapComponentAt(tester, const Offset(0.7, 0.5));
    await _dragComponentCandidate(
      tester,
      from: const Offset(0.7, 0.5),
      to: const Offset(0.41, 0.5),
    );

    final rect = _componentCanvasRect(tester);
    final positions = _paintedComponentPositions(tester);
    final firstCentre = Offset(
      positions.first.dx * rect.width,
      positions.first.dy * rect.height,
    );
    final secondCentre = Offset(
      positions.last.dx * rect.width,
      positions.last.dy * rect.height,
    );
    final midpoint = Offset.lerp(firstCentre, secondCentre, 0.5)!;

    await tester.tapAt(rect.topLeft + midpoint);
    await _pumpFrames(tester);
    expect(_paintedSelectedComponentDraftKey(tester), 1);

    final towardSecond = Offset.lerp(midpoint, secondCentre, 0.2)!;
    await tester.tapAt(rect.topLeft + towardSecond);
    await _pumpFrames(tester);
    expect(_paintedSelectedComponentDraftKey(tester), 2);
    expect(_paintedComponentDraftKeys(tester), const <int>[1, 2]);
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

  testWidgets('user-paced empty taps each add exactly one candidate',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);

    Future<void> tapEmptySpace(
      Offset normalizedPosition, {
      int? expectedSelectionBeforeCompletion,
    }) async {
      final canvasFinder =
          find.byKey(const ValueKey('wizard-component-canvas'));
      await tester.ensureVisible(canvasFinder);
      await tester.pump();
      final canvas = _componentCanvasRect(tester);
      final gesture = await tester.startGesture(
        canvas.topLeft +
            Offset(
              normalizedPosition.dx * canvas.width,
              normalizedPosition.dy * canvas.height,
            ),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      if (expectedSelectionBeforeCompletion != null) {
        expect(
          _paintedSelectedComponentDraftKey(tester),
          expectedSelectionBeforeCompletion,
        );
      }
      await gesture.up();
      await _pumpFrames(tester);
    }

    await tapEmptySpace(const Offset(0.2, 0.3));
    expect(_paintedComponentDraftKeys(tester), const <int>[1]);

    await tapEmptySpace(
      const Offset(0.8, 0.7),
      expectedSelectionBeforeCompletion: 1,
    );
    expect(_paintedComponentDraftKeys(tester), const <int>[1, 2]);

    await tapEmptySpace(const Offset(0.2, 0.75));
    expect(_paintedComponentDraftKeys(tester), const <int>[1, 2, 3]);
    expect(_paintedSelectedComponentDraftKey(tester), 3);
  });

  testWidgets('pointer cancellation never adds a component candidate',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.3, 0.4));
    final canvasFinder = find.byKey(const ValueKey('wizard-component-canvas'));
    await tester.ensureVisible(canvasFinder);
    await tester.pump();
    final canvas = _componentCanvasRect(tester);

    final candidateGesture = await tester.startGesture(
      canvas.topLeft + Offset(canvas.width * 0.3, canvas.height * 0.4),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pump();
    await candidateGesture.cancel();
    await _pumpFrames(tester);
    expect(_paintedComponentDraftKeys(tester), const <int>[1]);

    final emptyGesture = await tester.startGesture(
      canvas.topLeft + Offset(canvas.width * 0.8, canvas.height * 0.75),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pump();
    await emptyGesture.cancel();
    await _pumpFrames(tester);
    expect(_paintedComponentDraftKeys(tester), const <int>[1]);
    expect(_paintedSelectedComponentDraftKey(tester), 1);
  });

  testWidgets(
      'selection and dragging change only the selected in-frame position',
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
    expect(positions.first.dx, closeTo(0.825, 0.001));
    expect(positions.first.dy, closeTo(0.825, 0.001));
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
    expect(positions.first.dx, closeTo(0.825, 0.001));
    expect(positions.first.dy, closeTo(0.825, 0.001));
    expect(positions.last.dx, closeTo(0.175, 0.001));
    expect(positions.last.dy, closeTo(0.025, 0.001));
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
      find.byKey(const ValueKey('wizard-problem-editor')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-placeholder-5')),
      findsNothing,
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

  testWidgets(
      'candidate and current style survive navigation resize and photo changes',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>[
      'C:/photos/front.png',
      'C:/photos/replacement.webp',
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
    await _tapKey(tester, 'wizard-next');
    await _closeContour(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-component-shape-rounded-rectangle');
    await _setComponentSize(tester, 1.8);
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapComponentAt(tester, const Offset(0.58, 0.55));

    final styleBefore = _paintedComponentStyles(tester);
    final renderedMinorBefore =
        (_componentGeometry(tester, 1) as dynamic).minorDimension as double;
    expect(
      find.text('Valitud: Ümardatud ristkülik · 180% · 30°'),
      findsOneWidget,
    );

    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-back');
    expect(_paintedComponentStyles(tester), styleBefore);
    expect(
      find.text('Valitud: Ümardatud ristkülik · 180% · 30°'),
      findsOneWidget,
    );

    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');
    (_photoEditor(tester) as dynamic).onTranslationChanged(
      const Offset(0.14, -0.08),
    );
    (_photoEditor(tester) as dynamic).onScaleChanged(1.7);
    (_photoEditor(tester) as dynamic).onRotationChanged(0.35);
    (_photoEditor(tester) as dynamic).onOpacityChanged(0.28);
    await tester.pump();
    await _tapKey(tester, 'wizard-photo-replace');
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');

    expect(_paintedComponentStyles(tester), styleBefore);
    expect(
      find.text('Valitud: Ümardatud ristkülik · 180% · 30°'),
      findsOneWidget,
    );
    expect(
      (tester.widget(
        find.byKey(const ValueKey('wizard-component-photo-view')),
      ) as dynamic)
          .photoPath as String,
      'C:/photos/replacement.webp',
    );

    await tester.binding.setSurfaceSize(const Size(390, 760));
    await tester.pump();
    await tester.ensureVisible(
      find.byKey(const ValueKey('wizard-component-canvas')),
    );
    await tester.pump();
    final renderedMinorAfter =
        (_componentGeometry(tester, 1) as dynamic).minorDimension as double;
    expect(_paintedComponentStyles(tester), styleBefore);
    expect(renderedMinorAfter, lessThan(renderedMinorBefore));
    expect(
      find.text('Valitud: Ümardatud ristkülik · 180% · 30°'),
      findsOneWidget,
    );

    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-photo-remove');
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');

    expect(
      find.byKey(const ValueKey('wizard-component-photo-layer')),
      findsNothing,
    );
    expect(_paintedComponentStyles(tester), styleBefore);
    expect(
      find.text('Valitud: Ümardatud ristkülik · 180% · 30°'),
      findsOneWidget,
    );
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

    final contourStack = tester
        .widgetList<Stack>(
          find.ancestor(
            of: find.byKey(const ValueKey('wizard-contour-photo-layer')),
            matching: find.byType(Stack),
          ),
        )
        .firstWhere(
          (stack) => stack.children.any(
            (child) => child.key == const ValueKey('wizard-contour-painter'),
          ),
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

    final componentStack = tester
        .widgetList<Stack>(
          find.ancestor(
            of: find.byKey(const ValueKey('wizard-component-photo-layer')),
            matching: find.byType(Stack),
          ),
        )
        .firstWhere(
          (stack) => stack.children.any(
            (child) => child.key == const ValueKey('wizard-component-painter'),
          ),
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
        'Projekt luuakse alles pärast andmete kontrollimist ja kinnitamist.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('Salvestuskoha valimine ei loo kausta ega faili.'),
      findsOneWidget,
    );
    expect(
        find.text('Projekt luuakse alles wizardi lõpetamisel.'), findsNothing);
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

  testWidgets(
      'Step 5 gates empty and whitespace text then completes with raw input',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openProblemDescriptionStep(tester);

    expect(
      find.byKey(const ValueKey('wizard-problem-editor')),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNull,
    );

    const whitespaceOnly = '  \n  ';
    await _enterText(
      tester,
      'wizard-problem-description',
      whitespaceOnly,
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-problem-description')),
          )
          .controller!
          .text,
      whitespaceOnly,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNull,
    );

    const rawDescription = '  Toide katkeb.\nVahel taastub.  ';
    await _enterText(
      tester,
      'wizard-problem-description',
      rawDescription,
    );
    await _enterText(tester, 'wizard-problem-when', 'Koormuse all');
    await _enterText(tester, 'wizard-problem-symptoms', 'LED vilgub');
    await _enterText(tester, 'wizard-problem-attempts', 'Kaabel vahetatud');
    await _tapKey(tester, 'wizard-problem-occurrence-continuous');
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-next')),
          )
          .onPressed,
      isNotNull,
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('wizard-problem-description')),
          )
          .controller!
          .text,
      rawDescription,
    );

    await _tapKey(tester, 'wizard-next');
    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );
    for (var step = 1; step <= 5; step += 1) {
      expect(
        find.byKey(ValueKey<String>('wizard-compact-review-section-$step')),
        findsOneWidget,
      );
    }
    final review = find.byKey(const ValueKey('wizard-review-summary'));
    for (final text in tester.widgetList<Text>(
      find.descendant(of: review, matching: find.byType(Text)),
    )) {
      expect(text.overflow, isNot(TextOverflow.ellipsis));
    }
    final fifthProgress = find.byKey(
      const ValueKey('wizard-progress-step-5'),
    );
    expect(
      find.descendant(of: fifthProgress, matching: find.text('Valmis')),
      findsOneWidget,
    );
  });

  testWidgets(
      'all five Step 5 values survive photo contour candidate changes and resize',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>[
      'C:/photos/problem-context.png',
    ]);
    _installPhotoPicker(picker);
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openProblemDescriptionStep(tester);
    await _completeProblemDescription(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-back');

    String fieldText(String key) => tester
        .widget<TextField>(find.byKey(ValueKey<String>(key)))
        .controller!
        .text;

    void expectCompleteDraft() {
      expect(fieldText('wizard-problem-description'),
          '  Toide katkeb.\nVahel taastub.  ');
      expect(fieldText('wizard-problem-when'), 'Pärast soojenemist');
      expect(
        fieldText('wizard-problem-symptoms'),
        'LED vilgub\nja kostab klõps',
      );
      expect(fieldText('wizard-problem-attempts'), 'Toitekaabel vahetatud');
      expect(
        tester
            .widget<ChoiceChip>(
              find.byKey(
                const ValueKey('wizard-problem-occurrence-intermittent'),
              ),
            )
            .selected,
        isTrue,
      );
    }

    expectCompleteDraft();
    await _tapKey(tester, 'wizard-back');
    await _tapComponentAt(tester, const Offset(0.32, 0.68));
    await _tapKey(tester, 'wizard-next');
    expectCompleteDraft();

    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');
    await _dragContourPoint(
      tester,
      from: const Offset(0.2, 0.25),
      to: const Offset(0.24, 0.31),
    );
    expect(_paintedContourIsClosed(tester), isFalse);
    await _tapKey(tester, 'wizard-contour-close');
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');
    expectCompleteDraft();

    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-back');
    await _tapKey(tester, 'wizard-photo-pick');
    (_photoEditor(tester) as dynamic).onScaleChanged(1.35);
    await tester.pump();
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');
    expectCompleteDraft();
    expect(picker.pickCount, 1);

    final editorBefore = tester.widget<NewProjectWizardProblemDescription>(
      find.byType(NewProjectWizardProblemDescription),
    );
    editorBefore.onChanged(editorBefore.value);
    await tester.pump();
    final editorAfter = tester.widget<NewProjectWizardProblemDescription>(
      find.byType(NewProjectWizardProblemDescription),
    );
    expect(identical(editorAfter, editorBefore), isTrue);

    await tester.binding.setSurfaceSize(const Size(390, 760));
    await _pumpFrames(tester);
    expect(
      find.byKey(const ValueKey('wizard-problem-compact-layout')),
      findsOneWidget,
    );
    expectCompleteDraft();
    expect(tester.takeException(), isNull);
  });

  testWidgets('effective Step 5 edit participates in dirty cancellation',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openProblemDescriptionStep(tester);
    await _enterText(
      tester,
      'wizard-problem-symptoms',
      'Kuuldav klõps',
    );
    await _tapKey(tester, 'wizard-cancel');

    expect(find.text('Katkestada projekti loomine?'), findsOneWidget);
    expect(find.text('Sisestatud andmeid ei salvestata.'), findsOneWidget);
  });

  testWidgets('Step 6 shows the complete draft and all five edit round-trips',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _completeStepOne(
      tester,
      projectName: '  Pelle projekt  ',
      deviceName: '  Põletikontroller  ',
      additionalInfo: '  Säilita täpselt.  ',
      deviceType: '  Juhtplokk  ',
      manufacturer: '  Pelle  ',
      model: '  PV20  ',
      revision: '  REV_0.1  ',
    );
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');
    await _closeContour(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapComponentAt(tester, const Offset(0.35, 0.65));
    await _tapKey(tester, 'wizard-next');
    await _completeProblemDescription(tester);
    await _tapKey(tester, 'wizard-next');

    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );
    for (final value in const <String>[
      '  Pelle projekt  ',
      '  Põletikontroller  ',
      'C:/projects',
      '  Säilita täpselt.  ',
      '  Juhtplokk  ',
      '  Pelle  ',
      '  PV20  ',
      '  REV_0.1  ',
      'Foto pole valitud',
      'Kontuur suletud',
      '3 punkti',
      '1 visuaalne kandidaat',
      '  Toide katkeb.\nVahel taastub.  ',
      'Vahelduv',
      'Pärast soojenemist',
      'LED vilgub\nja kostab klõps',
      'Toitekaabel vahetatud',
    ]) {
      expect(find.text(value), findsWidgets, reason: value);
    }
    expect(find.text('—'), findsWidgets);
    expect(find.text('Tulekul'), findsNothing);

    const editorKeys = <int, String>{
      1: 'wizard-step-1-editor',
      2: 'wizard-photo-step',
      3: 'wizard-contour-editor',
      4: 'wizard-component-editor',
      5: 'wizard-problem-step',
    };
    for (final entry in editorKeys.entries) {
      await _tapKey(tester, 'wizard-review-edit-step-${entry.key}');
      expect(find.byKey(ValueKey(entry.value)), findsOneWidget);
      await _tapKey(tester, 'wizard-progress-step-6');
      expect(
        find.byKey(const ValueKey('wizard-review-summary')),
        findsOneWidget,
      );
      expect(find.text('  Pelle projekt  '), findsWidgets);
      expect(find.text('  Toide katkeb.\nVahel taastub.  '), findsWidgets);
    }
    await tester.binding.setSurfaceSize(const Size(390, 760));
    await _pumpFrames(tester);
    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );
    expect(find.text('  Juhtplokk  '), findsWidgets);
    expect(tester.takeException(), isNull);
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

  testWidgets(
      'parent uses the accepted compact shell and content-driven step header',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    expect(find.byType(WizardCompactShell), findsOneWidget);
    expect(
      find.byKey(const ValueKey('wizard-compact-shell-wide')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-compact-step-header')),
      findsOneWidget,
    );
    expect(find.byType(WizardCompactNavigation), findsNothing);
    _expectProgressStatus(1, 'Praegune samm');
    _expectProgressStatus(2, 'Järgmine samm');

    await tester.binding.setSurfaceSize(const Size(390, 760));
    await _pumpFrames(tester);

    expect(
      find.byKey(const ValueKey('wizard-compact-shell-compact')),
      findsOneWidget,
    );
    for (var step = 1; step <= 7; step += 1) {
      expect(_progressStep(step), findsOneWidget);
    }
    expect(find.byType(WizardCompactNavigation), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all locked shell breakpoints remain overflow-free',
      (tester) async {
    const sizes = <Size>[
      Size(390, 760),
      Size(519, 800),
      Size(520, 800),
      Size(559, 800),
      Size(560, 800),
      Size(599, 800),
      Size(600, 800),
      Size(779, 800),
      Size(780, 800),
      Size(819, 800),
      Size(820, 800),
      Size(1049, 800),
      Size(1050, 800),
      Size(1120, 860),
      Size(1440, 900),
      Size(1600, 900),
    ];
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.binding.setSurfaceSize(sizes.first);
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    for (final size in sizes) {
      await tester.binding.setSurfaceSize(size);
      await _pumpFrames(tester);
      final compact = size.width < 1050;
      expect(
        find.byKey(
          ValueKey<String>(
            compact
                ? 'wizard-compact-shell-compact'
                : 'wizard-compact-shell-wide',
          ),
        ),
        findsOneWidget,
        reason: '$size shell',
      );
      await tester.ensureVisible(
        find.byKey(const ValueKey('wizard-next')),
      );
      await tester.pump();
      expect(tester.takeException(), isNull, reason: '$size overflow');
    }
  });

  testWidgets('compact parent remains readable and reachable at 200% text',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        textScale: 2,
      ),
    );
    await _pumpFrames(tester);

    expect(
      find.byKey(const ValueKey('wizard-compact-step-header')),
      findsOneWidget,
    );
    expect(find.text('Projekti andmed'), findsWidgets);
    expect(
      find.text(
        'Projekt luuakse alles pärast andmete kontrollimist ja kinnitamist.',
      ),
      findsOneWidget,
    );
    await tester.ensureVisible(find.byKey(const ValueKey('wizard-next')));
    await tester.pump();
    expect(find.byKey(const ValueKey('wizard-next')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('review and success stay complete at 200% text', (tester) async {
    final created = _createdProjectState(
      projectName: 'Pikk tagastatud projekti nimi',
      projectId: 'prj_cafebabe',
      projectDirectory:
          'C:/väga/pikk/projektide/asukoht/mitme/alamkaustaga/prj_cafebabe',
    );
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (_) async => ProjectCreationSuccess(created),
        textScale: 2,
      ),
    );
    await tester.pump();
    await _openReviewStep(tester);

    for (var step = 1; step <= 5; step += 1) {
      final edit =
          find.byKey(ValueKey<String>('wizard-review-edit-step-$step'));
      await tester.ensureVisible(edit);
      await tester.pump();
      expect(edit, findsOneWidget);
    }
    await tester.ensureVisible(
      find.byKey(const ValueKey('wizard-create-project-button')),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);

    await _tapKey(tester, 'wizard-create-project-button');
    expect(find.byType(WizardCompactSuccessCard), findsOneWidget);
    expect(find.text('prj_cafebabe'), findsOneWidget);
    expect(
      find.text(
        'C:/väga/pikk/projektide/asukoht/mitme/alamkaustaga/prj_cafebabe',
      ),
      findsOneWidget,
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey('wizard-open-project-button')),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'workspace and inspector stay independent of the overall shell breakpoint',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1049, 800));
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
      find.byKey(const ValueKey('wizard-compact-workspace-wide')),
      findsOneWidget,
    );

    await tester.binding.setSurfaceSize(const Size(779, 800));
    await _pumpFrames(tester);

    expect(
      find.byKey(const ValueKey('wizard-compact-workspace-stacked')),
      findsOneWidget,
    );
    await _closeContour(tester);
    await _tapKey(tester, 'wizard-next');
    expect(
      find.byWidgetPredicate(
        (widget) => widget.runtimeType.toString().startsWith(
              'WizardCompactTileSelector',
            ),
      ),
      findsOneWidget,
    );
    final circle = tester.getRect(
      find.byKey(const ValueKey('wizard-component-shape-circle')),
    );
    final square = tester.getRect(
      find.byKey(const ValueKey('wizard-component-shape-square')),
    );
    final rectangle = tester.getRect(
      find.byKey(const ValueKey('wizard-component-shape-rectangle')),
    );
    final roundedRectangle = tester.getRect(
      find.byKey(
        const ValueKey('wizard-component-shape-rounded-rectangle'),
      ),
    );
    expect(circle.top, closeTo(square.top, 0.01));
    expect(rectangle.top, closeTo(roundedRectangle.top, 0.01));
    expect(circle.left, lessThan(square.left));
    expect(rectangle.left, lessThan(roundedRectangle.left));
    expect(circle.top, lessThan(rectangle.top));
    await _tapKey(tester, 'wizard-component-shape-rectangle');
    expect(
      tester
          .widget<ChoiceChip>(
            find.byKey(
              const ValueKey('wizard-component-shape-rectangle'),
            ),
          )
          .selected,
      isTrue,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('eligible progress actions support Enter and Space in order',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();
    await _openReviewStep(tester);

    bool primaryFocusIsInside(Finder owner) {
      final focusContext = FocusManager.instance.primaryFocus?.context;
      if (focusContext == null) {
        return false;
      }
      final ownerElement = tester.element(owner);
      var inside = identical(focusContext, ownerElement);
      (focusContext as Element).visitAncestorElements((ancestor) {
        inside = inside || identical(ancestor, ownerElement);
        return !inside;
      });
      return inside;
    }

    Future<void> tabTo(Finder owner) async {
      for (var attempt = 0; attempt < 20; attempt += 1) {
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();
        if (primaryFocusIsInside(owner)) {
          return;
        }
      }
      fail('Tab traversal did not reach $owner');
    }

    await tabTo(_progressStep(1));
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await _pumpFrames(tester);
    expect(find.byKey(const ValueKey('wizard-step-1-editor')), findsOneWidget);

    await tabTo(_progressStep(6));
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await _pumpFrames(tester);
    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );
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
    expect(
      find.byKey(const ValueKey('wizard-component-status')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-component-shape-grid')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-component-boundary-note')),
      findsOneWidget,
    );
    expect(movedPosition.dx, closeTo(0.65, 0.001));
    expect(movedPosition.dy, closeTo(0.72, 0.001));
    expect(pageScroll.pixels, closeTo(scrollOffsetBeforeDrag, 0.001));
    expect(tester.takeException(), isNull);
  });

  testWidgets('active and unvisited progress tiles are inert and non-dirty',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    expect(_progressHasTapAction(tester, 1), isFalse);
    expect(_progressHasButtonFlag(tester, 1), isFalse);
    expect(_progressHasTapAction(tester, 2), isFalse);
    expect(_progressHasButtonFlag(tester, 2), isFalse);
    _expectProgressStatus(1, 'Praegune samm');
    _expectProgressStatus(2, 'Järgmine samm');

    await tester.tap(_progressStep(1));
    await tester.tap(_progressStep(2));
    await _pumpFrames(tester);
    expect(find.byKey(const ValueKey('wizard-step-1-editor')), findsOneWidget);

    await _tapKey(tester, 'wizard-cancel');
    expect(find.byKey(const ValueKey('test-home')), findsOneWidget);
    expect(find.text('Katkestada projekti loomine?'), findsNothing);
  });

  testWidgets(
      'visited tiles navigate backward and gate-valid forward in wide and compact views',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-component-shape-square');
    await _setComponentSize(tester, 1.4);
    await _tapKey(tester, 'wizard-component-rotate-plus');
    await _tapComponentAt(tester, const Offset(0.64, 0.46));
    final candidateBefore = _paintedComponentStyles(tester).single;
    await _tapKey(tester, 'wizard-next');
    await _completeProblemDescription(tester);
    await _tapKey(tester, 'wizard-next');

    for (final stepNumber in const <int>[1, 3, 5]) {
      _expectProgressStatus(stepNumber, 'Valmis');
    }
    for (final stepNumber in const <int>[2, 4]) {
      _expectProgressStatus(stepNumber, 'Vaadatud');
    }
    _expectProgressStatus(6, 'Praegune samm');
    _expectProgressStatus(7, 'Järgmine samm');
    expect(_progressHasTapAction(tester, 4), isTrue);
    expect(_progressHasButtonFlag(tester, 4), isTrue);

    await _tapKey(tester, 'wizard-progress-step-4');
    expect(
        find.byKey(const ValueKey('wizard-component-editor')), findsOneWidget);
    expect(_paintedComponentStyles(tester).single, candidateBefore);

    await _tapKey(tester, 'wizard-progress-step-6');
    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );

    await tester.binding.setSurfaceSize(const Size(390, 760));
    await _pumpFrames(tester);
    await _tapKey(tester, 'wizard-progress-step-2');
    expect(find.byKey(const ValueKey('wizard-photo-step')), findsOneWidget);
    expect(_progressHasTapAction(tester, 3), isTrue);
    await _tapKey(tester, 'wizard-progress-step-3');
    expect(find.byKey(const ValueKey('wizard-contour-editor')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Step 1 gate status and forward navigation update after editing',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openReviewStep(tester);
    await _tapKey(tester, 'wizard-progress-step-1');
    await _enterText(tester, 'wizard-project-name', '   ');

    _expectProgressStatus(1, 'Praegune samm');
    expect(
      find.descendant(
        of: _progressStep(1),
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );
    _expectProgressStatus(3, 'Valmis');
    _expectProgressStatus(5, 'Valmis');
    expect(_progressHasTapAction(tester, 6), isFalse);

    await tester.tap(_progressStep(6));
    await _pumpFrames(tester);
    expect(find.byKey(const ValueKey('wizard-step-1-editor')), findsOneWidget);

    await _enterText(tester, 'wizard-project-name', 'Pelle PV20');
    expect(_progressHasTapAction(tester, 6), isTrue);
    await _tapKey(tester, 'wizard-progress-step-6');
    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );
  });

  testWidgets(
      'Step 3 and Step 5 visited statuses invalidate restore and guard forward navigation',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openReviewStep(tester);
    await _tapKey(tester, 'wizard-progress-step-3');
    await _dragContourPoint(
      tester,
      from: const Offset(0.2, 0.25),
      to: const Offset(0.24, 0.31),
    );
    expect(_paintedContourIsClosed(tester), isFalse);
    await _tapKey(tester, 'wizard-progress-step-2');
    _expectProgressStatus(3, 'Vaadatud');
    expect(
      find.descendant(
        of: _progressStep(3),
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );
    expect(_progressHasTapAction(tester, 6), isFalse);

    await _tapKey(tester, 'wizard-progress-step-3');
    await _tapKey(tester, 'wizard-contour-close');
    await _tapKey(tester, 'wizard-progress-step-2');
    _expectProgressStatus(3, 'Valmis');
    await _tapKey(tester, 'wizard-progress-step-6');

    await _tapKey(tester, 'wizard-progress-step-5');
    await _enterText(tester, 'wizard-problem-description', '   ');
    await _tapKey(tester, 'wizard-progress-step-4');
    _expectProgressStatus(5, 'Vaadatud');
    expect(
      find.descendant(
        of: _progressStep(5),
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );
    expect(_progressHasTapAction(tester, 6), isFalse);

    await _tapKey(tester, 'wizard-progress-step-5');
    await _enterText(
      tester,
      'wizard-problem-description',
      'Seade ei käivitu.',
    );
    await _tapKey(tester, 'wizard-progress-step-4');
    _expectProgressStatus(5, 'Valmis');
    await _tapKey(tester, 'wizard-progress-step-6');
    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );
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

    await _tapKey(tester, 'wizard-next');
    await _enterText(
      tester,
      'wizard-problem-description',
      'Seade ei käivitu.',
    );
    await _tapKey(tester, 'wizard-next');

    final fourthProgress = find.byKey(
      const ValueKey('wizard-progress-step-4'),
    );
    expect(
      find.descendant(of: fourthProgress, matching: find.text('Vaadatud')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: fourthProgress, matching: find.text('Valmis')),
      findsNothing,
    );
    final fifthProgress = find.byKey(
      const ValueKey('wizard-progress-step-5'),
    );
    expect(
      find.descendant(of: fifthProgress, matching: find.text('Valmis')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: fifthProgress,
        matching: find.byIcon(Icons.check_circle),
      ),
      findsWidgets,
    );
    final sixthProgress = find.byKey(
      const ValueKey('wizard-progress-step-6'),
    );
    expect(
      find.descendant(
        of: sixthProgress,
        matching: find.text('Praegune samm'),
      ),
      findsOneWidget,
    );

    final seventhProgress = find.byKey(
      const ValueKey('wizard-progress-step-7'),
    );
    expect(
      find.descendant(
        of: seventhProgress,
        matching: find.text('Järgmine samm'),
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

  testWidgets('create activation revalidates all three live required gates',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    var createCalls = 0;
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (request) async {
          createCalls += 1;
          return const ProjectCreationFailed(
            sanitizedMessage: 'Ei loodud.',
          );
        },
      ),
    );
    await tester.pump();
    await _openReviewStep(tester);

    VoidCallback currentCreateAction() => tester
        .widget<FilledButton>(
          find.byKey(const ValueKey('wizard-create-project-button')),
        )
        .onPressed!;

    var staleCreateAction = currentCreateAction();
    await _tapKey(tester, 'wizard-review-edit-step-1');
    await _enterText(tester, 'wizard-project-name', '   ');
    staleCreateAction();
    await tester.pump();
    expect(createCalls, 0);
    await _enterText(tester, 'wizard-project-name', 'Pelle PV20');
    await _tapKey(tester, 'wizard-progress-step-6');

    staleCreateAction = currentCreateAction();
    await _tapKey(tester, 'wizard-review-edit-step-3');
    await _dragContourPoint(
      tester,
      from: const Offset(0.2, 0.25),
      to: const Offset(0.24, 0.31),
    );
    staleCreateAction();
    await tester.pump();
    expect(createCalls, 0);
    await _tapKey(tester, 'wizard-contour-close');
    await _tapKey(tester, 'wizard-progress-step-6');

    staleCreateAction = currentCreateAction();
    await _tapKey(tester, 'wizard-review-edit-step-5');
    await _enterText(tester, 'wizard-problem-description', '   ');
    staleCreateAction();
    await tester.pump();
    expect(createCalls, 0);
    expect(
      find.byKey(const ValueKey('wizard-problem-step')),
      findsOneWidget,
    );
  });

  testWidgets('creation request preserves every no-photo draft value exactly',
      (tester) async {
    ProjectCreationRequest? captured;
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (request) async {
          captured = request;
          return const ProjectCreationCollision();
        },
      ),
    );
    await tester.pump();

    await _completeStepOne(
      tester,
      projectName: '  Inimese nimi  ',
      deviceName: '  Seadme nimi  ',
      additionalInfo: '  Lisainfo\nreas  ',
      deviceType: '  Juhtplokk  ',
      manufacturer: '  Pelle  ',
      model: '  PV20  ',
      revision: '  REV_0.1  ',
    );
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');
    final expectedReferenceFrameAspect =
        _contourCanvasRect(tester).width / _contourCanvasRect(tester).height;
    await _closeContour(tester);
    final contour = List<Offset>.of(_paintedContourPoints(tester));
    await _tapKey(tester, 'wizard-next');
    await _tapComponentAt(tester, const Offset(0.24, 0.38));
    await _tapComponentAt(tester, const Offset(0.73, 0.62));
    await _tapKey(tester, 'wizard-component-shape-rectangle');
    await _setComponentSize(tester, 1.65);
    await _tapKey(tester, 'wizard-component-rotate-plus');
    final candidates = List<_ComponentStyleSnapshot>.of(
      _paintedComponentStyles(tester),
    );
    await _tapKey(tester, 'wizard-next');
    await _completeProblemDescription(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-create-project-button');

    final request = captured!;
    expect(request.destinationParentPath, 'C:/projects');
    expect(request.projectName, '  Inimese nimi  ');
    expect(request.deviceName, '  Seadme nimi  ');
    expect(request.additionalInfo, '  Lisainfo\nreas  ');
    expect(request.deviceType, '  Juhtplokk  ');
    expect(request.manufacturer, '  Pelle  ');
    expect(request.model, '  PV20  ');
    expect(request.revision, '  REV_0.1  ');
    expect(request.sourcePhotoPath, isNull);

    final intake = request.wizardIntake;
    expect(intake.schemaVersion, '1.0');
    expect(intake.coordinateSpace, 'wizard_normalized');
    expect(
      intake.toJson()['reference_frame_aspect_ratio'],
      closeTo(expectedReferenceFrameAspect, 1e-9),
    );
    expect(intake.backgroundPhoto, isNull);
    expect(intake.problemDescription.description,
        '  Toide katkeb.\nVahel taastub.  ');
    expect(
      intake.problemDescription.occurrence,
      WizardProblemOccurrence.intermittent,
    );
    expect(intake.problemDescription.whenOccurs, 'Pärast soojenemist');
    expect(
      intake.problemDescription.symptoms,
      'LED vilgub\nja kostab klõps',
    );
    expect(intake.problemDescription.attempts, 'Toitekaabel vahetatud');
    expect(intake.contour.closed, isTrue);
    expect(intake.contour.points, hasLength(contour.length));
    for (var index = 0; index < contour.length; index += 1) {
      expect(intake.contour.points[index].x, closeTo(contour[index].dx, 1e-9));
      expect(intake.contour.points[index].y, closeTo(contour[index].dy, 1e-9));
    }
    expect(intake.visualCandidates, hasLength(2));
    for (var index = 0; index < candidates.length; index += 1) {
      final actual = intake.visualCandidates[index];
      final expected = candidates[index];
      expect(actual.draftKey, expected.draftKey);
      expect(actual.position.x, closeTo(expected.position.dx, 1e-9));
      expect(actual.position.y, closeTo(expected.position.dy, 1e-9));
      expect(actual.sizeScale, expected.sizeScale);
      expect(actual.rotationRadians, expected.rotation);
    }
    expect(
      intake.visualCandidates.map((candidate) => candidate.shape),
      <WizardVisualCandidateShape>[
        WizardVisualCandidateShape.circle,
        WizardVisualCandidateShape.rectangle,
      ],
    );
    expect(
      intake.visualCandidates.map((candidate) => candidate.draftKey),
      <int>[1, 2],
    );
    expect(
      find.byKey(const ValueKey('wizard-review-summary')),
      findsOneWidget,
    );
    for (final retained in const <String>[
      '  Inimese nimi  ',
      '  Seadme nimi  ',
      '  Lisainfo\nreas  ',
      '  Juhtplokk  ',
      '  Pelle  ',
      '  PV20  ',
      '  REV_0.1  ',
      '2 visuaalset kandidaati',
      '  Toide katkeb.\nVahel taastub.  ',
    ]) {
      expect(find.text(retained), findsWidgets, reason: retained);
    }
  });

  testWidgets('creation request maps photo path and complete transform',
      (tester) async {
    final picker = _FakePhotoFilePicker(<Object?>['C:/Photos/BOARD.JPEG']);
    _installPhotoPicker(picker);
    ProjectCreationRequest? captured;
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (request) async {
          captured = request;
          return const ProjectCreationInvalidDestination();
        },
      ),
    );
    await tester.pump();

    await _openPhotoAlignmentStep(tester);
    await _tapKey(tester, 'wizard-photo-pick');
    final editor = _photoEditor(tester) as dynamic;
    editor.onTranslationChanged(const Offset(12.5, -7.25));
    editor.onScaleChanged(1.6);
    editor.onRotationChanged(math.pi / 4);
    editor.onOpacityChanged(0.42);
    await tester.pump();
    await _tapKey(tester, 'wizard-next');
    final expectedReferenceFrameAspect =
        _contourCanvasRect(tester).width / _contourCanvasRect(tester).height;
    await _closeContour(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-next');
    await _completeProblemDescription(tester);
    await _tapKey(tester, 'wizard-next');
    await _tapKey(tester, 'wizard-create-project-button');

    final request = captured!;
    expect(request.sourcePhotoPath, 'C:/Photos/BOARD.JPEG');
    expect(
      request.wizardIntake.toJson()['reference_frame_aspect_ratio'],
      closeTo(expectedReferenceFrameAspect, 1e-9),
    );
    final photo = request.wizardIntake.backgroundPhoto!;
    expect(photo.relativePath, 'photos/wizard_background.jpeg');
    expect(photo.transform.translation.x, 12.5);
    expect(photo.transform.translation.y, -7.25);
    expect(photo.transform.scale, 1.6);
    expect(photo.transform.rotationRadians, closeTo(math.pi / 4, 1e-9));
    expect(photo.transform.opacity, 0.42);
  });

  testWidgets(
      'pending activation is single-call and explicit retry is one call',
      (tester) async {
    final attempts = <Completer<ProjectCreationResult>>[
      Completer<ProjectCreationResult>(),
      Completer<ProjectCreationResult>(),
    ];
    var calls = 0;
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (request) {
          final attempt = attempts[calls];
          calls += 1;
          return attempt.future;
        },
      ),
    );
    await tester.pump();
    await _openReviewStep(tester);

    final activation = tester
        .widget<FilledButton>(
          find.byKey(const ValueKey('wizard-create-project-button')),
        )
        .onPressed!;
    activation();
    activation();
    await tester.pump();
    expect(calls, 1);
    expect(
      find.byKey(const ValueKey('wizard-creation-progress')),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('wizard-create-project-button')),
          )
          .onPressed,
      isNull,
    );

    attempts.first.complete(
      const ProjectCreationFailed(sanitizedMessage: 'Proovi uuesti.'),
    );
    await _pumpFrames(tester);
    expect(calls, 1);
    expect(find.text('Proovi uuesti.'), findsOneWidget);
    expect(find.text('Pelle PV20'), findsWidgets);
    expect(find.text('3 punkti'), findsOneWidget);
    expect(find.text('Pärast soojenemist'), findsOneWidget);

    await _tapKey(tester, 'wizard-create-project-button');
    expect(calls, 2);
    expect(
      find.byKey(const ValueKey('wizard-creation-progress')),
      findsOneWidget,
    );
    attempts[1].complete(const ProjectCreationCollision());
    await _pumpFrames(tester);
    expect(calls, 2);
  });

  testWidgets('every typed failure and thrown exception is safely retryable',
      (tester) async {
    final outcomes = <Object>[
      const ProjectCreationMobilePlaceholder(),
      const ProjectCreationCollision(),
      const ProjectCreationInvalidDestination(),
      const ProjectCreationPythonNotFound(),
      const ProjectCreationMaterializerFailed(
        sanitizedMessage: 'Materialiseerimine ei õnnestunud.',
        rawDetail: 'SECRET MATERIALIZER OUTPUT',
      ),
      const ProjectCreationPhotoFailed(
        sanitizedMessage: 'Foto kopeerimine ei õnnestunud.',
        rawDetail: 'C:/private/source.png',
      ),
      const ProjectCreationFailed(
        sanitizedMessage: 'Üldine turvaline tõrge.',
        rawDetail: 'SECRET STACK',
      ),
      StateError('SECRET THROWN ERROR'),
    ];
    var calls = 0;
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (request) async {
          final outcome = outcomes[calls];
          calls += 1;
          if (outcome is ProjectCreationResult) {
            return outcome;
          }
          throw outcome;
        },
      ),
    );
    await tester.pump();
    await _openReviewStep(tester);

    const safeMessages = <String>[
      'Projekti loomine ei ole mobiilseadmes saadaval.',
      'Projekt on juba olemas. Vali uus projekt ja proovi uuesti.',
      'Valitud salvestuskoht ei ole saadaval.',
      'Pythonit ei leitud. Projekti ei loodud.',
      'Materialiseerimine ei õnnestunud.',
      'Foto kopeerimine ei õnnestunud.',
      'Üldine turvaline tõrge.',
      'Projekti loomine ebaõnnestus. Proovi uuesti.',
    ];
    for (var index = 0; index < outcomes.length; index += 1) {
      await _tapKey(tester, 'wizard-create-project-button');
      expect(calls, index + 1);
      expect(
        find.byKey(const ValueKey('wizard-review-summary')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('wizard-creation-error')),
        findsOneWidget,
      );
      expect(find.text(safeMessages[index]), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.byKey(const ValueKey('wizard-create-project-button')),
            )
            .onPressed,
        isNotNull,
      );
      for (final forbidden in const <String>[
        'SECRET MATERIALIZER OUTPUT',
        'C:/private/source.png',
        'SECRET STACK',
        'SECRET THROWN ERROR',
      ]) {
        expect(
            find.textContaining(forbidden, skipOffstage: false), findsNothing);
      }
    }
  });

  testWidgets(
      'success hands off once, shows returned state, waits, then opens project',
      (tester) async {
    final created = _createdProjectState(
      projectName: 'Tagastatud nimi',
      projectId: 'prj_deadbeef',
      projectDirectory: 'D:/projektid/prj_deadbeef',
    );
    var createCalls = 0;
    var handoffCalls = 0;
    ProjectState? handedOff;
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (request) async {
          createCalls += 1;
          return ProjectCreationSuccess(created);
        },
        onProjectCreated: (state) {
          handoffCalls += 1;
          handedOff = state;
        },
      ),
    );
    await tester.pump();
    await _openReviewStep(tester);
    final reviewContext = tester.element(
      find.byKey(const ValueKey('wizard-review-summary')),
    );
    expect(
      GoRouter.of(reviewContext).routeInformationProvider.value.uri.path,
      '/new-project',
    );

    await _tapKey(tester, 'wizard-create-project-button');
    expect(createCalls, 1);
    expect(handoffCalls, 1);
    expect(handedOff, same(created));
    expect(
      find.byKey(const ValueKey('wizard-created-success')),
      findsOneWidget,
    );
    expect(find.byType(WizardCompactSuccessCard), findsOneWidget);
    expect(
      find.byKey(const ValueKey('wizard-created-project-name')),
      findsOneWidget,
    );
    expect(find.text('Tagastatud nimi'), findsOneWidget);
    expect(find.text('prj_deadbeef'), findsOneWidget);
    expect(find.text('D:/projektid/prj_deadbeef'), findsOneWidget);
    expect(find.text('Copy ID'), findsNothing);
    expect(find.text('Open Folder'), findsNothing);
    expect(find.text('Kopeeri ID'), findsNothing);
    expect(find.text('Kopeeri tunnus'), findsNothing);
    expect(find.text('Ava kaust'), findsNothing);
    expect(
      find.descendant(
        of: find.byKey(
          const ValueKey('wizard-created-project-location'),
        ),
        matching: find.byType(SelectableText),
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('wizard-cancel')), findsNothing);
    expect(
      find.byKey(const ValueKey('wizard-review-edit-step-1')),
      findsNothing,
    );
    final successContext = tester.element(
      find.byKey(const ValueKey('wizard-created-success')),
    );
    expect(
      GoRouter.of(successContext).routeInformationProvider.value.uri.path,
      '/new-project',
    );

    await tester.pump();
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await _pumpFrames(tester);
    expect(createCalls, 1);
    expect(handoffCalls, 1);
    expect(tester.takeException(), isNull);

    await _tapKey(tester, 'wizard-open-project-button');
    expect(find.byKey(const ValueKey('test-project')), findsOneWidget);
    expect(createCalls, 1);
    expect(handoffCalls, 1);
  });

  testWidgets('creation and project routing stay inert until activation',
      (tester) async {
    var createCalls = 0;
    await tester.pumpWidget(
      _buildWizardApp(
        directoryPicker: () async => 'C:/projects',
        createProject: (request) async {
          createCalls += 1;
          return ProjectCreationSuccess(
            _createdProjectState(wizardIntake: request.wizardIntake),
          );
        },
      ),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapComponentAt(tester, const Offset(0.35, 0.65));
    await _tapKey(tester, 'wizard-next');
    await _enterText(
      tester,
      'wizard-problem-description',
      'Seade ei käivitu.',
    );
    await _tapKey(tester, 'wizard-next');

    final context = tester.element(
      find.byKey(const ValueKey('wizard-review-summary')),
    );
    expect(
      GoRouter.of(context).routeInformationProvider.value.uri.path,
      '/new-project',
    );
    expect(createCalls, 0);
    expect(
      find.byKey(const ValueKey('wizard-create-project-button')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('test-project')), findsNothing);
  });
}
