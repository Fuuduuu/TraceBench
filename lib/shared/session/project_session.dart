import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project_state.dart';
import '../models/trace_bench_event.dart';

final NotifierProvider<ProjectSession, ProjectState?> projectStateProvider =
    NotifierProvider<ProjectSession, ProjectState?>(ProjectSession.new);

class ProjectSession extends Notifier<ProjectState?> {
  int _generation = 0;
  final Set<String> _acceptedEventIds = <String>{};
  final Set<String> _acceptedOperationIds = <String>{};

  @override
  ProjectState? build() {
    _generation = 0;
    _acceptedEventIds.clear();
    _acceptedOperationIds.clear();
    return null;
  }

  int get generation => _generation;

  bool openProject(
    ProjectState project, {
    required int generation,
  }) {
    if (generation != _generation) {
      return false;
    }
    _installProject(project);
    _generation += 1;
    return true;
  }

  void closeProject() {
    state = null;
    _acceptedEventIds.clear();
    _acceptedOperationIds.clear();
    _generation += 1;
  }

  bool applyCanonicalEvent(
    Map<String, dynamic> event, {
    required int generation,
  }) {
    final current = state;
    if (generation != _generation || current == null) {
      return false;
    }

    final eventId = _nonEmptyId(event['event_id']);
    final operationId = _nonEmptyId(event['client_operation_id']);
    if (eventId != null &&
        (_acceptedEventIds.contains(eventId) ||
            current.events.any((event) => event.eventId == eventId))) {
      return false;
    }
    if (operationId != null &&
        (_acceptedOperationIds.contains(operationId) ||
            current.events.any(
              (event) =>
                  _nonEmptyId(event.payload['client_operation_id']) ==
                  operationId,
            ))) {
      return false;
    }

    final parsedEvent = TraceBenchEvent.fromJson(event);
    state = current.copyWith(
      events: [...current.events, parsedEvent],
      projectionFreshness: current.projectionFreshness,
      isProjectionStale: true,
    );
    if (eventId != null) {
      _acceptedEventIds.add(eventId);
    }
    if (operationId != null) {
      _acceptedOperationIds.add(operationId);
    }
    return true;
  }

  bool replaceWithReloaded(
    ProjectState project, {
    required int generation,
  }) {
    if (generation != _generation || state == null) {
      return false;
    }
    _installProject(project);
    _generation += 1;
    return true;
  }

  void _installProject(ProjectState project) {
    state = project;
    _acceptedEventIds.clear();
    _acceptedOperationIds.clear();
    for (final event in project.events) {
      final eventId = _nonEmptyId(event.eventId);
      if (eventId != null) {
        _acceptedEventIds.add(eventId);
      }
      final operationId = _nonEmptyId(event.payload['client_operation_id']);
      if (operationId != null) {
        _acceptedOperationIds.add(operationId);
      }
    }
  }

  String? _nonEmptyId(Object? value) {
    final normalized = value?.toString().trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
