import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/models/trace_bench_event.dart';
import '../services/v2_edit_component_writer.dart';

class EditComponentScreen extends ConsumerStatefulWidget {
  const EditComponentScreen({super.key});

  @override
  ConsumerState<EditComponentScreen> createState() =>
      _EditComponentScreenState();
}

class _EditComponentScreenState extends ConsumerState<EditComponentScreen> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _referenceDesignatorController =
      TextEditingController();
  final TextEditingController _packageHintController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  String? _selectedComponentId;
  bool _humanConfirmed = false;
  bool _isSaving = false;
  String? _lastSuccessfulFormKey;
  String? _successMessage;
  String? _errorMessage;

  bool get _canEdit {
    final formKey = _formKey;
    return !_isSaving &&
        _humanConfirmed &&
        formKey != null &&
        formKey != _lastSuccessfulFormKey;
  }

  String? get _formKey {
    final component = _selectedComponent;
    if (component == null) {
      return null;
    }
    final changes = _changesFor(component);
    if (changes.isEmpty) {
      return null;
    }
    return <String>[
      component.componentId,
      _editReason,
      ...changes.map((change) =>
          '${change.field}:${change.oldValueObserved}:${change.newValue}:${change.changeKind}'),
    ].join('|');
  }

  String get _editReason {
    final value = _reasonController.text.trim();
    return value.isEmpty ? 'human_component_edit' : value;
  }

  ComponentFact? get _selectedComponent {
    final projectState = ref.read(projectStateProvider);
    if (projectState == null || _selectedComponentId == null) {
      return null;
    }
    for (final component in projectState.knownFacts.components) {
      if (component.componentId == _selectedComponentId) {
        return component;
      }
    }
    return null;
  }

  Future<void> _editComponent() async {
    if (_isSaving) {
      return;
    }
    final projectState = ref.read(projectStateProvider);
    final component = _selectedComponent;
    final formKey = _formKey;
    if (projectState == null || component == null || formKey == null) {
      return;
    }
    final changes = _changesFor(component);
    if (changes.isEmpty) {
      return;
    }

    setState(() {
      _isSaving = true;
      _successMessage = null;
      _errorMessage = null;
    });

    try {
      final result =
          await ref.read(v2EditComponentWriterProvider).editComponent(
                projectState: projectState,
                request: V2EditComponentRequest(
                  componentId: component.componentId,
                  changes: changes,
                  editReason: _editReason,
                  clientOperationId: _clientOperationId(formKey),
                ),
              );

      final eventAlreadyPresent =
          _hasLocalEvent(projectState.events, result.event);
      final updatedEvents = List<TraceBenchEvent>.from(projectState.events);
      if (!eventAlreadyPresent) {
        updatedEvents.add(TraceBenchEvent.fromJson(result.event));
      }
      ref.read(projectStateProvider.notifier).state = projectState.copyWith(
        events: updatedEvents,
        isProjectionStale: true,
      );

      setState(() {
        _lastSuccessfulFormKey = formKey;
        _successMessage = result.status == V2EditComponentWriteStatus.existing
            ? 'Muudetud (idempotentne kordus).'
            : 'Muudetud.';
      });
    } on V2EditComponentException catch (error) {
      setState(() {
        _errorMessage = _messageForFailure(error);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  List<V2ComponentChange> _changesFor(ComponentFact component) {
    final changes = <V2ComponentChange>[];
    _addChangeIfDifferent(
      changes,
      field: 'label',
      oldValue: component.designator ?? component.componentId,
      newValue: _labelController.text,
    );
    _addChangeIfDifferent(
      changes,
      field: 'reference_designator',
      oldValue: component.designator ?? 'unknown',
      newValue: _referenceDesignatorController.text,
    );
    _addChangeIfDifferent(
      changes,
      field: 'package_hint',
      oldValue: component.package ?? 'unknown',
      newValue: _packageHintController.text,
    );
    return changes;
  }

  void _addChangeIfDifferent(
    List<V2ComponentChange> changes, {
    required String field,
    required String oldValue,
    required String newValue,
  }) {
    final trimmed = newValue.trim();
    if (trimmed.isEmpty || trimmed == oldValue) {
      return;
    }
    changes.add(
      V2ComponentChange(
        field: field,
        oldValueObserved: oldValue,
        newValue: trimmed,
        changeKind: oldValue == 'unknown' ? 'set' : 'replace',
      ),
    );
  }

  bool _hasLocalEvent(
    List<TraceBenchEvent> localEvents,
    Map<String, dynamic> candidate,
  ) {
    final eventId = candidate['event_id']?.toString();
    final clientOperationId = candidate['client_operation_id']?.toString();
    return localEvents.any((event) {
      if (eventId != null && eventId.isNotEmpty && event.eventId == eventId) {
        return true;
      }
      if (clientOperationId == null || clientOperationId.isEmpty) {
        return false;
      }
      return _clientOperationIdForEvent(event) == clientOperationId;
    });
  }

  String? _clientOperationIdForEvent(TraceBenchEvent event) {
    final serializedValue = event.toJson()['client_operation_id'];
    if (serializedValue != null && serializedValue.toString().isNotEmpty) {
      return serializedValue.toString();
    }

    final payloadValue = event.payload['client_operation_id'];
    if (payloadValue != null && payloadValue.toString().isNotEmpty) {
      return payloadValue.toString();
    }
    return null;
  }

  String _clientOperationId(String formKey) {
    final normalized = formKey
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return 'edit_component_$normalized';
  }

  String _messageForFailure(V2EditComponentException error) {
    switch (error.kind) {
      case V2EditComponentFailureKind.validation:
        return 'Not saved: validation failed.';
      case V2EditComponentFailureKind.append:
        return 'Not saved: writer append failed.';
      case V2EditComponentFailureKind.lockConflict:
        return 'Not saved: writer is busy, retry.';
      case V2EditComponentFailureKind.pythonUnavailable:
        return 'Not saved: Python writer service unavailable.';
      case V2EditComponentFailureKind.noProjectDirectory:
        return 'Not saved: local project folder required.';
      case V2EditComponentFailureKind.invalidProjectDirectory:
        return 'Not saved: project path is invalid.';
      case V2EditComponentFailureKind.unknownComponent:
        return 'Not saved: choose an existing component.';
    }
  }

  void _clearMessages() {
    setState(() {
      _successMessage = null;
      _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _labelController.dispose();
    _referenceDesignatorController.dispose();
    _packageHintController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(
        body: Center(child: Text('No project loaded')),
      );
    }
    final components = projectState.knownFacts.components;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Component')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SafetyCard(projectState: projectState),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Koht → Väärtus → Ühik → Muuda',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    key: const ValueKey('edit-component-select-dropdown'),
                    initialValue: _selectedComponentId,
                    decoration: const InputDecoration(
                      labelText: 'Koht / olemasolev komponent',
                      helperText: 'Muuda ainult olemasolevat komponenti.',
                    ),
                    items: components
                        .map(
                          (component) => DropdownMenuItem<String>(
                            value: component.componentId,
                            child: Text(component.componentId),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: _isSaving
                        ? null
                        : (value) => setState(() {
                              _selectedComponentId = value;
                              _humanConfirmed = false;
                              _successMessage = null;
                              _errorMessage = null;
                            }),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('edit-component-label-field'),
                    controller: _labelController,
                    decoration: const InputDecoration(
                      labelText: 'Väärtus / uus nimi',
                      helperText: 'Ainult inimese sisestatud nimemuudatus.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('edit-component-reference-field'),
                    controller: _referenceDesignatorController,
                    decoration: const InputDecoration(
                      labelText: 'Reference designator hint',
                      helperText: 'Optional label context only.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('edit-component-package-field'),
                    controller: _packageHintController,
                    decoration: const InputDecoration(
                      labelText: 'Package hint',
                      helperText: 'Optional package context only.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('edit-component-reason-field'),
                    controller: _reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Muutmise põhjus',
                      helperText: 'Defaults to human_component_edit if blank.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    key: const ValueKey('edit-component-confirm-checkbox'),
                    value: _humanConfirmed,
                    onChanged: _isSaving
                        ? null
                        : (value) => setState(() {
                              _humanConfirmed = value ?? false;
                              _successMessage = null;
                              _errorMessage = null;
                            }),
                    title: const Text('Kinnitan komponendi muudatuse'),
                    subtitle: const Text(
                      'This records component_updated after explicit human action.',
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    key: const ValueKey('edit-component-button'),
                    onPressed: _canEdit ? _editComponent : null,
                    child: Text(_isSaving ? 'Muudan...' : 'Muuda komponenti'),
                  ),
                  if (_successMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _successMessage!,
                      key: const ValueKey('edit-component-success-message'),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Projection stale until refresh.',
                      key: ValueKey('edit-component-stale-projection-message'),
                    ),
                  ],
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      key: const ValueKey('edit-component-error-message'),
                    ),
                  ],
                  const SizedBox(height: 12),
                  const _TechnicalDetailsTile(
                    eventType: 'component_updated',
                    writerCopy:
                        'Edit Component uses the accepted V2 writer service.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _HintBoundaryCard(),
        ],
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  const _SafetyCard({required this.projectState});

  final ProjectState projectState;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Component',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Project: ${projectState.manifest.projectId}'),
            const SizedBox(height: 8),
            const Text('Human is the sensor. AI is the graph engine.'),
            const Text('Koht → Väärtus → Ühik → Muuda'),
            const Text(
              'Creates component_updated only after explicit human action.',
            ),
            const Text(
              'Edits existing components only; no new component is created.',
            ),
          ],
        ),
      ),
    );
  }
}

class _HintBoundaryCard extends StatelessWidget {
  const _HintBoundaryCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hint boundary'),
            SizedBox(height: 8),
            Text(
              'Template, footprint, package, photo, helper, candidate, vector, and AI context stay hint/context only.',
            ),
            Text(
              'Hints do not confirm component identity, pins, nets, or measurements.',
            ),
          ],
        ),
      ),
    );
  }
}

class _TechnicalDetailsTile extends StatelessWidget {
  const _TechnicalDetailsTile({
    required this.eventType,
    required this.writerCopy,
  });

  final String eventType;
  final String writerCopy;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: const Text('Tehnilised detailid'),
      childrenPadding: const EdgeInsets.only(bottom: 8),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(writerCopy),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Event type: $eventType'),
        ),
      ],
    );
  }
}
