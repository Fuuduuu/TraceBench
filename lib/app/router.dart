import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/events/screens/events_viewer_screen.dart';
import '../features/board_graph/screens/board_graph_screen.dart';
import '../features/board_canvas/screens/board_canvas_screen.dart';
import '../features/known_facts/screens/component_list_screen.dart';
import '../features/known_facts/screens/known_facts_viewer_screen.dart';
import '../features/known_facts/screens/measurement_list_screen.dart';
import '../features/known_facts/screens/not_populated_screen.dart';
import '../features/known_facts/screens/pin_list_screen.dart';
import '../features/project/screens/home_screen.dart';
import '../features/project/screens/new_project_wizard_screen.dart';
import '../features/project/screens/project_overview_screen.dart';
import '../features/photos/screens/photo_list_screen.dart';
import '../features/reference_images/screens/reference_images_screen.dart';
import '../features/report/screens/customer_report_screen.dart';
import '../features/measurements/screens/measurement_record_screen.dart';

GoRouter buildTraceBenchRouter({
  String initialLocation = '/',
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'new-project',
            name: 'new-project',
            builder: (_, __) => const NewProjectWizardScreen(),
          ),
          GoRoute(
            path: 'project',
            name: 'project-overview',
            builder: (_, __) => const ProjectOverviewScreen(),
            routes: [
              GoRoute(
                path: 'components',
                name: 'component-list',
                builder: (_, __) => const ComponentListScreen(),
              ),
              GoRoute(
                path: 'measurements',
                name: 'measurement-list',
                builder: (_, __) => const MeasurementListScreen(),
              ),
              GoRoute(
                path: 'measurements/new',
                name: 'measurement-new',
                builder: (_, __) => const MeasurementRecordScreen(),
              ),
              GoRoute(
                path: 'not-populated',
                name: 'not-populated',
                builder: (_, __) => const NotPopulatedScreen(),
              ),
              GoRoute(
                path: 'pins',
                name: 'pin-list',
                builder: (_, __) => const PinListScreen(),
              ),
              GoRoute(
                path: 'events',
                name: 'events',
                builder: (_, __) => const EventsViewerScreen(),
              ),
              GoRoute(
                path: 'graph',
                name: 'board-graph',
                builder: (_, __) => const BoardGraphScreen(),
              ),
              GoRoute(
                path: 'board-canvas',
                name: 'board-canvas',
                builder: (_, __) => const BoardCanvasScreen(),
              ),
              GoRoute(
                path: 'known-facts',
                name: 'known-facts',
                builder: (_, __) => const KnownFactsViewerScreen(),
              ),
              GoRoute(
                path: 'photos',
                name: 'photos',
                builder: (_, __) => const PhotoListScreen(),
              ),
              GoRoute(
                path: 'reference-images',
                name: 'reference-images',
                builder: (_, __) => const ReferenceImagesScreen(),
              ),
              GoRoute(
                path: 'report',
                name: 'customer-report',
                builder: (_, __) => const CustomerReportScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(state.error?.toString() ?? 'Unknown route')),
    ),
  );
}
