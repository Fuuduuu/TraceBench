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
  testWidgets('six-step shell renders the exact Estonian step labels',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    for (final label in const <String>[
      'Projekti andmed',
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
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('wizard-contour-editor')),
        matching: find.text('Samm 2 / 6'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Step 2 starts empty and keeps Edasi disabled', (tester) async {
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

  testWidgets('reset clears points, selection, closure, and the Step 2 gate',
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
      'Step 3 starts empty, renders the closed contour guide, and stays ungated',
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
      find.byKey(const ValueKey('wizard-placeholder-3')),
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

  testWidgets('Step 4 round-trip retains candidate keys and positions',
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
      find.byKey(const ValueKey('wizard-placeholder-4')),
      findsOneWidget,
    );
    final thirdProgress = find.byKey(
      const ValueKey('wizard-progress-step-3'),
    );
    expect(
      find.descendant(
        of: thirdProgress,
        matching: find.text('Vaadatud'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: thirdProgress,
        matching: find.text('Valmis'),
      ),
      findsNothing,
    );

    await _tapKey(tester, 'wizard-back');
    expect(_paintedComponentDraftKeys(tester), keysBefore);
    expect(_paintedComponentPositions(tester), positionsBefore);
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
      find.byKey(const ValueKey('wizard-contour-editor')),
      findsOneWidget,
    );
  });

  testWidgets('Steps 4 through 6 remain honest non-functional placeholders',
      (tester) async {
    await tester.pumpWidget(
      _buildWizardApp(directoryPicker: () async => 'C:/projects'),
    );
    await tester.pump();

    await _openComponentPlacementStep(tester);
    await _tapKey(tester, 'wizard-next');

    const labels = <int, String>{
      4: 'Probleemi kirjeldus',
      5: 'Kontroll ja kinnitus',
      6: 'Kokkuvõte',
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
      if (entry.key < 6) {
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
      find.byKey(const ValueKey('wizard-contour-editor')),
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

  testWidgets('Step 3 wide desktop layout is operable without overflow',
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

  testWidgets('Step 3 compact layout is operable without overflow',
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

    await _closeContour(tester);
    await _tapKey(tester, 'wizard-next');

    expect(
      find.descendant(
        of: secondProgress,
        matching: find.text('Valmis'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: secondProgress,
        matching: find.byIcon(Icons.check_circle),
      ),
      findsWidgets,
    );

    for (var step = 3; step < 6; step += 1) {
      await _tapKey(tester, 'wizard-next');
    }

    for (var step = 3; step < 6; step += 1) {
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
    expect(
      find.descendant(
        of: sixthProgress,
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
    for (var step = 3; step < 6; step += 1) {
      await _tapKey(tester, 'wizard-next');
    }

    final context = tester.element(
      find.byKey(const ValueKey('wizard-placeholder-6')),
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
