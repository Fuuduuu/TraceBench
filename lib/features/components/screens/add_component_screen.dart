import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/models/trace_bench_event.dart';
import '../services/v2_add_component_writer.dart';

class AddComponentScreen extends ConsumerStatefulWidget {
  const AddComponentScreen({super.key});

  @override
  ConsumerState<AddComponentScreen> createState() => _AddComponentScreenState();
}

class _AddComponentScreenState extends ConsumerState<AddComponentScreen> {
  static const List<String> _componentKinds = <String>[
    'unknown',
    'passive',
    'ic',
    'connector',
    'regulator',
  ];

  final TextEditingController _componentIdController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _referenceDesignatorController =
      TextEditingController();
  final TextEditingController _packageHintController = TextEditingController();
  final TextEditingController _footprintHintController =
      TextEditingController();
  final TextEditingController _templateIdHintController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _selectedKind;
  bool _isSaving = false;
  String? _lastSuccessfulFormKey;
  String? _successMessage;
  String? _errorMessage;

  String get _componentId => _componentIdController.text.trim();
  String get _label => _labelController.text.trim();

  String? get _formKey {
    final kind = _selectedKind;
    if (_componentId.isEmpty || _label.isEmpty || kind == null) {
      return null;
    }
    return <String>[
      _componentId,
      _label,
      kind,
      _referenceDesignatorController.text.trim(),
      _packageHintController.text.trim(),
      _footprintHintController.text.trim(),
      _templateIdHintController.text.trim(),
      _noteController.text.trim(),
    ].join('|');
  }

  bool get _canAdd {
    final formKey = _formKey;
    return !_isSaving && formKey != null && formKey != _lastSuccessfulFormKey;
  }

  Future<void> _addComponent() async {
    if (_isSaving) {
      return;
    }
    final formKey = _formKey;
    final componentKind = _selectedKind;
    if (formKey == null || componentKind == null) {
      return;
    }

    final projectState = ref.read(projectStateProvider);
    if (projectState == null) {
      setState(() {
        _successMessage = null;
        _errorMessage = 'Not saved: no project loaded.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _successMessage = null;
      _errorMessage = null;
    });

    try {
      final result = await ref.read(v2AddComponentWriterProvider).addComponent(
            projectState: projectState,
            request: V2AddComponentRequest(
              componentId: _componentId,
              label: _label,
              componentKind: componentKind,
              clientOperationId: _clientOperationId(formKey),
              referenceDesignator:
                  _optionalText(_referenceDesignatorController),
              packageHint: _optionalText(_packageHintController),
              footprintHint: _optionalText(_footprintHintController),
              templateIdHint: _optionalText(_templateIdHintController),
              humanNote: _optionalText(_noteController),
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
        _successMessage = result.status == V2AddComponentWriteStatus.existing
            ? 'Lisatud (idempotentne kordus).'
            : 'Lisatud.';
      });
    } on V2AddComponentException catch (error) {
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

  String? _optionalText(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
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
    return 'add_component_$normalized';
  }

  String _messageForFailure(V2AddComponentException error) {
    switch (error.kind) {
      case V2AddComponentFailureKind.validation:
        return 'Not saved: validation failed.';
      case V2AddComponentFailureKind.append:
        return 'Not saved: writer append failed.';
      case V2AddComponentFailureKind.lockConflict:
        return 'Not saved: writer is busy, retry.';
      case V2AddComponentFailureKind.pythonUnavailable:
        return 'Not saved: writer service is unavailable.';
      case V2AddComponentFailureKind.noProjectDirectory:
        return 'Not saved: project must be opened from a local folder.';
      case V2AddComponentFailureKind.invalidProjectDirectory:
        return 'Not saved: project path is invalid.';
    }
  }

  @override
  void dispose() {
    _componentIdController.dispose();
    _labelController.dispose();
    _referenceDesignatorController.dispose();
    _packageHintController.dispose();
    _footprintHintController.dispose();
    _templateIdHintController.dispose();
    _noteController.dispose();
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

    return Scaffold(
      appBar: AppBar(title: const Text('Add Component')),
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
                    'Koht → Väärtus → Ühik → Lisa',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('add-component-id-field'),
                    controller: _componentIdController,
                    decoration: const InputDecoration(
                      labelText: 'Koht / komponent',
                      helperText:
                          'Inimese sisestatud projekti ID, näiteks U10 või Q2.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('add-component-label-field'),
                    controller: _labelController,
                    decoration: const InputDecoration(
                      labelText: 'Väärtus / nimi',
                      helperText: 'Tehniku kuvatav nimi projektis.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    key: const ValueKey('add-component-kind-dropdown'),
                    initialValue: _selectedKind,
                    decoration: const InputDecoration(
                      labelText: 'Ühik / liik',
                      helperText: 'Lai inimese sisestatud liik või unknown.',
                    ),
                    items: _componentKinds
                        .map(
                          (kind) => DropdownMenuItem<String>(
                            value: kind,
                            child: Text(kind),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: _isSaving
                        ? null
                        : (value) => setState(() {
                              _selectedKind = value;
                              _successMessage = null;
                              _errorMessage = null;
                            }),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('add-component-reference-field'),
                    controller: _referenceDesignatorController,
                    decoration: const InputDecoration(
                      labelText: 'Reference designator hint',
                      helperText: 'Optional label context only.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('add-component-package-field'),
                    controller: _packageHintController,
                    decoration: const InputDecoration(
                      labelText: 'Package hint',
                      helperText: 'Optional geometry/package context only.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('add-component-footprint-field'),
                    controller: _footprintHintController,
                    decoration: const InputDecoration(
                      labelText: 'Footprint hint',
                      helperText: 'Optional layout context only.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('add-component-template-field'),
                    controller: _templateIdHintController,
                    decoration: const InputDecoration(
                      labelText: 'Template ID hint',
                      helperText: 'Optional visual template context only.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('add-component-note-field'),
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Human note',
                      helperText: 'Optional technician note.',
                    ),
                    onChanged: (_) => _clearMessages(),
                  ),
                  const SizedBox(height: 8),
                  const Text('Vihjed on kontekst, mitte tõend.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    key: const ValueKey('add-component-button'),
                    onPressed: _canAdd ? _addComponent : null,
                    child: Text(_isSaving ? 'Lisan...' : 'Lisa komponent'),
                  ),
                  if (_successMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _successMessage!,
                      key: const ValueKey('add-component-success-message'),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Projection stale until refresh.',
                      key: ValueKey('add-component-stale-projection-message'),
                    ),
                  ],
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      key: const ValueKey('add-component-error-message'),
                    ),
                  ],
                  const SizedBox(height: 12),
                  const _TechnicalDetailsTile(
                    eventType: 'component_created',
                    writerCopy:
                        'Add Component uses the accepted V2 writer service.',
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

  void _clearMessages() {
    setState(() {
      _successMessage = null;
      _errorMessage = null;
    });
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
              'Add Component',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Project: ${projectState.manifest.projectId}'),
            const SizedBox(height: 8),
            const Text('Human is the sensor. AI is the graph engine.'),
            const Text('Koht → Väärtus → Ühik → Lisa'),
            const Text(
                'Creates component_created only after explicit human action.'),
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
              'Package, footprint, template, photo, helper, candidate, vector, and AI context stay hint/context only.',
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
