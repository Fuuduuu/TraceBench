import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/project/screens/new_project_wizard_screen.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_creator.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

class _TestPlatformInfo extends PlatformInfo {
  const _TestPlatformInfo(this._isMobile);

  final bool _isMobile;

  @override
  bool get isMobile => _isMobile;
}

class _FakeProjectCreator extends ProjectCreator {
  _FakeProjectCreator(this._handler);

  final Future<ProjectCreationResult> Function(ProjectCreationRequest request)
      _handler;
  final List<ProjectCreationRequest> requests = <ProjectCreationRequest>[];

  @override
  Future<ProjectCreationResult> createProject(
      ProjectCreationRequest request) async {
    requests.add(request);
    return _handler(request);
  }
}

ProjectState _inlineProjectState({bool stale = false}) {
  return ProjectState(
    manifest: ProjectManifest.fromJson({
      'project_id': 'prj_a1b2c3d4',
      'schema_version': '1.0',
      'created_at': '2026-05-25T10:00:00Z',
      'device_type': 'unknown',
      'model': 'unknown',
      'symptom': 'not_provided',
    }),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'prj_a1b2c3d4',
      'components': <Map<String, dynamic>>[],
      'pins': <Map<String, dynamic>>[],
      'measurements': <Map<String, dynamic>>[],
      'nets': <Map<String, dynamic>>[],
      'photos': <Map<String, dynamic>>[],
      'damage_regions': <Map<String, dynamic>>[],
      'suspect_regions': <Map<String, dynamic>>[],
      'visual_traces': <Map<String, dynamic>>[],
      'excluded_from_fault_candidates': <Map<String, dynamic>>[],
      'component_pin_index': <String, dynamic>{},
    }),
    events: const [],
    customerReport: '# TraceBench Project Report',
    projectDirectory: 'C:/tmp/prj_a1b2c3d4',
    isProjectionStale: stale,
  );
}

Widget _buildWizardApp({
  required ProjectCreator creator,
  required Future<String?> Function() directoryPicker,
  required PlatformInfo platformInfo,
}) {
  final router = GoRouter(
    initialLocation: '/new-project',
    routes: <RouteBase>[
      GoRoute(
        path: '/new-project',
        builder: (_, __) => NewProjectWizardScreen(
          projectCreator: creator,
          directoryPicker: directoryPicker,
          platformInfo: platformInfo,
        ),
      ),
      GoRoute(
        path: '/project',
        builder: (_, __) => const ProjectOverviewScreen(),
      ),
    ],
  );

  return ProviderScope(
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('folder selection required before create', (tester) async {
    final creator = _FakeProjectCreator(
      (_) async => ProjectCreationSuccess(_inlineProjectState()),
    );

    await tester.pumpWidget(
      _buildWizardApp(
        creator: creator,
        directoryPicker: () async => null,
        platformInfo: const _TestPlatformInfo(false),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('wizard-create')));
    await tester.pump();

    expect(find.text('Vali projekti asukoht.'), findsOneWidget);
    expect(creator.requests, isEmpty);
  });

  testWidgets('optional fields may be blank and create succeeds',
      (tester) async {
    final creator = _FakeProjectCreator(
      (_) async => ProjectCreationSuccess(_inlineProjectState(stale: false)),
    );

    await tester.pumpWidget(
      _buildWizardApp(
        creator: creator,
        directoryPicker: () async => 'C:/tmp/projects',
        platformInfo: const _TestPlatformInfo(false),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('wizard-pick-folder')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('wizard-create')));
    await tester.pumpAndSettle();

    expect(creator.requests.length, 1);
    expect(creator.requests.single.deviceType, isEmpty);
    expect(creator.requests.single.model, isEmpty);
    expect(creator.requests.single.symptom, isEmpty);
    expect(find.text('Project overview'), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsNothing);
  });

  testWidgets('collision shows error', (tester) async {
    final creator = _FakeProjectCreator(
      (_) async => const ProjectCreationCollision(),
    );

    await tester.pumpWidget(
      _buildWizardApp(
        creator: creator,
        directoryPicker: () async => 'C:/tmp/projects',
        platformInfo: const _TestPlatformInfo(false),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('wizard-pick-folder')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('wizard-create')));
    await tester.pump();

    expect(find.text('Projektikaust on juba olemas.'), findsOneWidget);
  });

  testWidgets('materializer failure shows sanitized message', (tester) async {
    final creator = _FakeProjectCreator(
      (_) async => const ProjectCreationMaterializerFailed(
        sanitizedMessage:
            'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.',
        rawDetail: 'C:\\Users\\demo\\Traceback: raw internals',
      ),
    );

    await tester.pumpWidget(
      _buildWizardApp(
        creator: creator,
        directoryPicker: () async => 'C:/tmp/projects',
        platformInfo: const _TestPlatformInfo(false),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('wizard-pick-folder')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('wizard-create')));
    await tester.pump();

    expect(
      find.text(
        'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('Traceback'), findsNothing);
    expect(find.textContaining('C:\\Users\\'), findsNothing);
  });

  testWidgets('mobile placeholder shown and directory picker is not opened',
      (tester) async {
    var pickerOpened = false;
    final creator = _FakeProjectCreator(
      (_) async => const ProjectCreationMobilePlaceholder(),
    );

    await tester.pumpWidget(
      _buildWizardApp(
        creator: creator,
        directoryPicker: () async {
          pickerOpened = true;
          return 'C:/tmp';
        },
        platformInfo: const _TestPlatformInfo(true),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('wizard-pick-folder')));
    await tester.pump();

    expect(find.text('Uue projekti loomine tuleb järgmises versioonis.'),
        findsOneWidget);
    expect(pickerOpened, isFalse);
  });
}
