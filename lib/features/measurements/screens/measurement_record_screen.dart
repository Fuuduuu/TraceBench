import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/event_write/measurement_event_writer.dart';

class MeasurementRecordScreen extends ConsumerStatefulWidget {
  const MeasurementRecordScreen({super.key});

  @override
  ConsumerState<MeasurementRecordScreen> createState() =>
      _MeasurementRecordScreenState();
}

class _MeasurementRecordScreenState
    extends ConsumerState<MeasurementRecordScreen> {
  final _valueController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _customUnitController = TextEditingController();
  String? _selectedUnit;
  String? _lastSuccessfulFormKey;
  bool _isSubmitting = false;
  String? _successMessage;
  String? _errorMessage;

  static const String _defaultMode = 'continuity';
  static const String _defaultPowerState = 'unknown';
  static const String _otherUnitValue = '__custom_unit__';
  static const List<String> _unitOptions = <String>[
    'V',
    'mV',
    'A',
    'mA',
    'Ω',
    'kΩ',
    'Hz',
    _otherUnitValue,
  ];

  num? get _parsedValue {
    final value = _valueController.text.trim();
    if (value.isEmpty) return null;
    return num.tryParse(value);
  }

  String get _unit {
    if (_selectedUnit == null) return '';
    if (_selectedUnit == _otherUnitValue) {
      return _customUnitController.text.trim();
    }
    return _selectedUnit!;
  }

  String? get _currentFormKey {
    final parsedValue = _parsedValue;
    final fromTarget = _fromController.text.trim();
    final toTarget = _toController.text.trim();
    final unit = _unit.trim();
    if (parsedValue == null ||
        !parsedValue.isFinite ||
        fromTarget.isEmpty ||
        toTarget.isEmpty ||
        unit.isEmpty) {
      return null;
    }
    return [
      'mode=$_defaultMode',
      'from=$fromTarget',
      'to=$toTarget',
      'value=${parsedValue.toString()}',
      'unit=$unit',
      'power_state=$_defaultPowerState',
    ].join('|');
  }

  bool _isDuplicateFormKey(String? formKey) {
    if (formKey == null) {
      return false;
    }
    return formKey == _lastSuccessfulFormKey;
  }

  bool get _canSubmit {
    final formKey = _currentFormKey;
    return !_isSubmitting &&
        formKey != null &&
        !_isDuplicateFormKey(formKey);
  }

  Future<void> _saveMeasurement() async {
    if (_isSubmitting) {
      return;
    }
    final formKey = _currentFormKey;
    if (formKey == null || _isDuplicateFormKey(formKey)) {
      return;
    }

    final projectState = ref.read(projectStateProvider);
    if (projectState == null) {
      setState(() {
        _errorMessage = 'No project loaded.';
        _successMessage = null;
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final writer = MeasurementEventWriter();
      final request = MeasurementWriteRequest(
        value: _parsedValue,
        unit: _unit,
        fromTarget: _fromController.text.trim(),
        toTarget: _toController.text.trim(),
        mode: _defaultMode,
        powerState: _defaultPowerState,
      );
      final result = await writer.writeMeasurement(
        projectState: projectState,
        request: request,
      );
      ref.read(projectStateProvider.notifier).state =
          result.updatedProjectState;
      setState(() {
        _lastSuccessfulFormKey = formKey;
        _successMessage =
            'Measurement event saved. Known facts projection must be refreshed before derived views update.';
      });
    } on MeasurementWriteException catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _customUnitController.dispose();
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
      appBar: AppBar(
        title: const Text('Lisa mõõtmine'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            key: const ValueKey('measurement-value-field'),
            controller: _valueController,
            decoration: const InputDecoration(labelText: 'Mõõte (väärtus)'),
            onChanged: (_) => setState(() {}),
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: true),
          ),
          const SizedBox(height: 12),
          TextFormField(
            key: const ValueKey('measurement-from-field'),
            controller: _fromController,
            decoration: const InputDecoration(labelText: 'From target'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextFormField(
            key: const ValueKey('measurement-to-field'),
            controller: _toController,
            decoration: const InputDecoration(labelText: 'To target'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: const ValueKey('measurement-unit-dropdown'),
            value: _selectedUnit,
            decoration: const InputDecoration(labelText: 'Ühik'),
            items: _unitOptions
                .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(
                        unit == _otherUnitValue
                            ? 'Muu (sisesta käsitsi)'
                            : unit,
                      ),
                    ))
                .toList(growable: false),
            onChanged: (value) {
              setState(() {
                _selectedUnit = value;
                if (value != _otherUnitValue) {
                  _customUnitController.clear();
                }
              });
            },
          ),
          if (_selectedUnit == _otherUnitValue) ...[
            const SizedBox(height: 12),
            TextFormField(
              key: const ValueKey('measurement-unit-custom-field'),
              controller: _customUnitController,
              decoration: const InputDecoration(labelText: 'Sisesta ühik'),
              onChanged: (_) => setState(() {}),
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            key: const ValueKey('measurement-submit-button'),
            onPressed: _canSubmit ? _saveMeasurement : null,
            child: const Text('Salvesta sündmus'),
          ),
          if (_successMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _successMessage!,
              key: const ValueKey('measurement-success-message'),
            ),
          ],
          if (_errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorMessage!,
              key: const ValueKey('measurement-error-message'),
            ),
          ],
        ],
      ),
    );
  }
}
