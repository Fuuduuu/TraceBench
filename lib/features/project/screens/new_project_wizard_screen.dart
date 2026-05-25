import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../shared/services/project_creator.dart';
import '../../../shared/services/python_runner.dart';

final Provider<ProjectCreator> projectCreatorProvider =
    Provider<ProjectCreator>((_) => ProjectCreator());

class NewProjectWizardScreen extends ConsumerStatefulWidget {
  const NewProjectWizardScreen({
    super.key,
    this.projectCreator,
    this.directoryPicker,
    this.platformInfo,
  });

  final ProjectCreator? projectCreator;
  final Future<String?> Function()? directoryPicker;
  final PlatformInfo? platformInfo;

  @override
  ConsumerState<NewProjectWizardScreen> createState() =>
      _NewProjectWizardScreenState();
}

class _NewProjectWizardScreenState
    extends ConsumerState<NewProjectWizardScreen> {
  final TextEditingController _deviceTypeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _symptomController = TextEditingController();

  String? _selectedParentPath;
  bool _isSubmitting = false;

  bool get _isMobile {
    final info = widget.platformInfo ?? const DefaultPlatformInfo();
    return info.isMobile;
  }

  Future<void> _pickFolder() async {
    if (_isMobile) {
      _showMessage('Uue projekti loomine tuleb järgmises versioonis.');
      return;
    }
    final picker =
        widget.directoryPicker ?? FilePicker.platform.getDirectoryPath;
    final path = await picker();
    if (!mounted) {
      return;
    }
    if (path == null || path.trim().isEmpty) {
      return;
    }
    setState(() {
      _selectedParentPath = path;
    });
  }

  Future<void> _createProject() async {
    if (_isMobile) {
      _showMessage('Uue projekti loomine tuleb järgmises versioonis.');
      return;
    }
    if (_selectedParentPath == null || _selectedParentPath!.trim().isEmpty) {
      _showMessage('Vali projekti asukoht.');
      return;
    }
    setState(() {
      _isSubmitting = true;
    });

    final ProjectCreator creator =
        widget.projectCreator ?? ref.read(projectCreatorProvider);
    final result = await creator.createProject(
      ProjectCreationRequest(
        destinationParentPath: _selectedParentPath!,
        deviceType: _deviceTypeController.text,
        model: _modelController.text,
        symptom: _symptomController.text,
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    switch (result) {
      case ProjectCreationSuccess(:final projectState):
        ref.read(projectStateProvider.notifier).state = projectState;
        context.go('/project');
      case ProjectCreationCollision():
        _showMessage('Projektikaust on juba olemas.');
      case ProjectCreationInvalidDestination():
        _showMessage('Vali projekti asukoht.');
      case ProjectCreationPythonNotFound():
        _showMessage(
          'Pythonit ei leitud. Uue projekti loomine vajab Python toolingut.',
        );
      case ProjectCreationMaterializerFailed(:final sanitizedMessage):
        _showMessage(sanitizedMessage);
      case ProjectCreationMobilePlaceholder():
        _showMessage('Uue projekti loomine tuleb järgmises versioonis.');
      case ProjectCreationFailed(:final sanitizedMessage):
        _showMessage(sanitizedMessage);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _deviceTypeController.dispose();
    _modelController.dispose();
    _symptomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPath = _selectedParentPath;
    final destinationText = selectedPath == null
        ? 'Asukoht valimata'
        : selectedPath.replaceAll(Platform.pathSeparator, '/');

    return Scaffold(
      appBar: AppBar(title: const Text('Uus projekt')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Loo tühi kohalik TraceBench projekt.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                key: const ValueKey('wizard-pick-folder'),
                onPressed: _isSubmitting ? null : _pickFolder,
                child: const Text('Vali projekti asukoht'),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(destinationText)),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            key: const ValueKey('wizard-device-type'),
            controller: _deviceTypeController,
            decoration:
                const InputDecoration(labelText: 'Device type (valikuline)'),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const ValueKey('wizard-model'),
            controller: _modelController,
            decoration: const InputDecoration(labelText: 'Model (valikuline)'),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const ValueKey('wizard-symptom'),
            controller: _symptomController,
            decoration:
                const InputDecoration(labelText: 'Symptom (valikuline)'),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                key: const ValueKey('wizard-create'),
                onPressed: _isSubmitting ? null : _createProject,
                child: Text(_isSubmitting ? 'Loon...' : 'Loo projekt'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                key: const ValueKey('wizard-cancel'),
                onPressed: _isSubmitting ? null : () => context.go('/'),
                child: const Text('Tühista'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
