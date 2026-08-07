import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/models/project_state.dart';
import '../../../shared/models/wizard_intake.dart';
import '../../../shared/services/project_creator.dart';
import '../../../shared/services/python_runner.dart';
import '../widgets/new_project_wizard_photo_editor.dart';
import '../widgets/new_project_wizard_problem_description.dart';

const List<_WizardStepDefinition> _wizardSteps = <_WizardStepDefinition>[
  _WizardStepDefinition(
    label: 'Projekti andmed',
    detail: 'nimi ja salvestuskoht',
    icon: Icons.description_outlined,
  ),
  _WizardStepDefinition(
    label: 'Foto ja joondamine',
    detail: 'valikuline lokaalne foto vaade',
    icon: Icons.photo_outlined,
  ),
  _WizardStepDefinition(
    label: 'Plaadi kontuur',
    detail: 'joonista ja sulge visuaalne kandidaat',
    icon: Icons.gesture_outlined,
  ),
  _WizardStepDefinition(
    label: 'Komponentide asetus',
    detail: 'paiguta visuaalsed kandidaadid',
    icon: Icons.location_on_outlined,
  ),
  _WizardStepDefinition(
    label: 'Probleemi kirjeldus',
    detail: 'inimese teada olevad tähelepanekud',
    icon: Icons.notes_outlined,
  ),
  _WizardStepDefinition(
    label: 'Kontroll ja kinnitus',
    detail: 'kontrolli mustandit ja loo projekt',
    icon: Icons.verified_user_outlined,
  ),
  _WizardStepDefinition(
    label: 'Projekt loodud',
    detail: 'projekt on valmis avamiseks',
    icon: Icons.fact_check_outlined,
  ),
];

enum _WizardCreationStatus {
  idle,
  creating,
  failed,
  succeeded,
}

class NewProjectWizardScreen extends StatefulWidget {
  const NewProjectWizardScreen({
    super.key,
    this.directoryPicker,
    this.platformInfo,
    this.createProject,
    this.onProjectCreated,
  });

  final Future<String?> Function()? directoryPicker;
  final PlatformInfo? platformInfo;
  final Future<ProjectCreationResult> Function(ProjectCreationRequest)?
      createProject;
  final ValueChanged<ProjectState>? onProjectCreated;

  @override
  State<NewProjectWizardScreen> createState() => _NewProjectWizardScreenState();
}

class _NewProjectWizardScreenState extends State<NewProjectWizardScreen> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();
  final TextEditingController _deviceTypeController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _revisionController = TextEditingController();

  String? _selectedParentPath;
  bool _advancedStepOneExpanded = false;
  final List<Offset> _contourPoints = <Offset>[];
  int? _selectedContourPointIndex;
  int? _draggingContourPointIndex;
  int? _draggingContourPointer;
  bool _contourClosed = false;
  double? _referenceFrameAspectRatio;
  final List<_WizardComponentCandidate> _componentCandidates =
      <_WizardComponentCandidate>[];
  int _nextComponentDraftKey = 1;
  int? _selectedComponentDraftKey;
  int? _draggingComponentDraftKey;
  int? _draggingComponentPointer;
  _WizardComponentShape _componentCurrentShape = _WizardComponentShape.circle;
  double _componentCurrentSizeScale = 1.0;
  double _componentCurrentRotation = 0.0;
  String? _photoPath;
  NewProjectWizardPhotoTransform _photoTransform =
      const NewProjectWizardPhotoTransform();
  NewProjectWizardProblemDescriptionDraft _problemDescriptionDraft =
      const NewProjectWizardProblemDescriptionDraft();
  bool _isPickingPhoto = false;
  String? _photoPickerError;
  int _currentStep = 0;
  final Set<int> _visitedSteps = <int>{0};
  bool _draftTouched = false;
  bool _isPickingFolder = false;
  _WizardCreationStatus _creationStatus = _WizardCreationStatus.idle;
  String? _creationError;
  ProjectState? _createdProjectState;
  bool _projectHandoffCompleted = false;

  bool get _isMobile {
    final info = widget.platformInfo ?? const DefaultPlatformInfo();
    return info.isMobile;
  }

  bool get _canPickPhoto => !kIsWeb && !_isMobile;

  bool get _canAdvanceFromStepOne {
    return _projectNameController.text.trim().isNotEmpty &&
        (_selectedParentPath?.trim().isNotEmpty ?? false);
  }

  bool get _canAdvanceFromContour {
    return _contourClosed && _contourPoints.length >= 3;
  }

  bool get _canAdvanceFromProblemDescription {
    return _problemDescriptionDraft.description.trim().isNotEmpty;
  }

  bool get _allCreationGatesAreValid {
    return _canAdvanceFromStepOne &&
        _canAdvanceFromContour &&
        _canAdvanceFromProblemDescription;
  }

  bool _isRequiredStep(int index) => index == 0 || index == 2 || index == 4;

  bool _requiredStepIsValid(int index) {
    return switch (index) {
      0 => _canAdvanceFromStepOne,
      2 => _canAdvanceFromContour,
      4 => _canAdvanceFromProblemDescription,
      _ => false,
    };
  }

  bool _canAdvanceFromStep(int index) {
    return !_isRequiredStep(index) || _requiredStepIsValid(index);
  }

  void _handleDraftTextChanged(String _) {
    setState(() {
      _draftTouched = true;
    });
  }

  void _handleProblemDescriptionChanged(
    NewProjectWizardProblemDescriptionDraft next,
  ) {
    if (next == _problemDescriptionDraft) {
      return;
    }
    setState(() {
      _problemDescriptionDraft = next;
      _draftTouched = true;
    });
  }

  ProjectCreationRequest _buildCreationRequest() {
    final photoPath = _photoPath;
    final backgroundPhoto = photoPath == null
        ? null
        : WizardBackgroundPhoto(
            relativePath:
                'photos/wizard_background.${_photoExtension(photoPath)}',
            transform: WizardPhotoTransform(
              translation: WizardPoint(
                x: _photoTransform.translation.dx,
                y: _photoTransform.translation.dy,
              ),
              scale: _photoTransform.scale,
              rotationRadians: _photoTransform.rotation,
              opacity: _photoTransform.opacity,
            ),
          );
    final intake = WizardIntake(
      schemaVersion: '1.0',
      coordinateSpace: 'wizard_normalized',
      referenceFrameAspectRatio: _referenceFrameAspectRatio,
      problemDescription: WizardProblemDescription(
        description: _problemDescriptionDraft.description,
        occurrence: switch (_problemDescriptionDraft.occurrence) {
          NewProjectWizardProblemOccurrence.unknown =>
            WizardProblemOccurrence.unknown,
          NewProjectWizardProblemOccurrence.continuous =>
            WizardProblemOccurrence.continuous,
          NewProjectWizardProblemOccurrence.intermittent =>
            WizardProblemOccurrence.intermittent,
        },
        whenOccurs: _problemDescriptionDraft.whenOccurs,
        symptoms: _problemDescriptionDraft.symptoms,
        attempts: _problemDescriptionDraft.attempts,
      ),
      contour: WizardContour(
        closed: _contourClosed,
        points: <WizardPoint>[
          for (final point in _contourPoints)
            WizardPoint(x: point.dx, y: point.dy),
        ],
      ),
      backgroundPhoto: backgroundPhoto,
      visualCandidates: <WizardVisualCandidate>[
        for (final candidate in _componentCandidates)
          WizardVisualCandidate(
            draftKey: candidate.draftKey,
            position: WizardPoint(
              x: candidate.position.dx,
              y: candidate.position.dy,
            ),
            shape: switch (candidate.shape) {
              _WizardComponentShape.circle => WizardVisualCandidateShape.circle,
              _WizardComponentShape.square => WizardVisualCandidateShape.square,
              _WizardComponentShape.rectangle =>
                WizardVisualCandidateShape.rectangle,
              _WizardComponentShape.roundedRectangle =>
                WizardVisualCandidateShape.roundedRectangle,
            },
            sizeScale: candidate.sizeScale,
            rotationRadians: candidate.rotation,
          ),
      ],
    );

    return ProjectCreationRequest(
      destinationParentPath: _selectedParentPath!,
      projectName: _projectNameController.text,
      deviceName: _deviceNameController.text,
      additionalInfo: _additionalInfoController.text,
      deviceType: _deviceTypeController.text,
      manufacturer: _manufacturerController.text,
      model: _modelController.text,
      revision: _revisionController.text,
      wizardIntake: intake,
      sourcePhotoPath: photoPath,
    );
  }

  String _photoExtension(String path) {
    final separator = path.lastIndexOf('.');
    if (separator < 0 || separator == path.length - 1) {
      throw StateError('Selected photo is missing a supported extension.');
    }
    return path.substring(separator + 1).toLowerCase();
  }

  Future<void> _createProject() async {
    if (_currentStep != 5 ||
        _creationStatus == _WizardCreationStatus.creating ||
        _creationStatus == _WizardCreationStatus.succeeded ||
        !_allCreationGatesAreValid) {
      return;
    }

    setState(() {
      _creationStatus = _WizardCreationStatus.creating;
      _creationError = null;
    });

    ProjectCreationResult result;
    try {
      final createProject =
          widget.createProject ?? ProjectCreator().createProject;
      result = await createProject(_buildCreationRequest());
    } catch (_) {
      if (!mounted) {
        return;
      }
      _recordCreationFailure(
        'Projekti loomine ebaõnnestus. Proovi uuesti.',
      );
      return;
    }

    if (!mounted) {
      return;
    }
    switch (result) {
      case ProjectCreationSuccess(:final projectState):
        if (!_projectHandoffCompleted) {
          _projectHandoffCompleted = true;
          widget.onProjectCreated?.call(projectState);
        }
        if (!mounted) {
          return;
        }
        setState(() {
          _createdProjectState = projectState;
          _creationStatus = _WizardCreationStatus.succeeded;
          _creationError = null;
          _currentStep = 6;
          _visitedSteps.add(6);
        });
      case ProjectCreationMobilePlaceholder():
        _recordCreationFailure(
          'Projekti loomine ei ole mobiilseadmes saadaval.',
        );
      case ProjectCreationCollision():
        _recordCreationFailure(
          'Projekt on juba olemas. Vali uus projekt ja proovi uuesti.',
        );
      case ProjectCreationInvalidDestination():
        _recordCreationFailure('Valitud salvestuskoht ei ole saadaval.');
      case ProjectCreationPythonNotFound():
        _recordCreationFailure('Pythonit ei leitud. Projekti ei loodud.');
      case ProjectCreationMaterializerFailed(:final sanitizedMessage):
        _recordCreationFailure(sanitizedMessage);
      case ProjectCreationPhotoFailed(:final sanitizedMessage):
        _recordCreationFailure(sanitizedMessage);
      case ProjectCreationFailed(:final sanitizedMessage):
        _recordCreationFailure(sanitizedMessage);
    }
  }

  void _recordCreationFailure(String message) {
    setState(() {
      _creationStatus = _WizardCreationStatus.failed;
      _creationError = message;
    });
  }

  Future<void> _pickFolder() async {
    if (_isMobile) {
      _showMessage('Uue projekti loomine tuleb järgmises versioonis.');
      return;
    }
    if (_isPickingFolder) {
      return;
    }

    setState(() {
      _isPickingFolder = true;
    });

    String? path;
    try {
      final picker =
          widget.directoryPicker ?? FilePicker.platform.getDirectoryPath;
      path = await picker();
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isPickingFolder = false;
      });
      _showMessage('Kausta valimine ebaõnnestus.');
      return;
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _isPickingFolder = false;
      if (path != null && path.trim().isNotEmpty) {
        _selectedParentPath = path;
        _draftTouched = true;
      }
    });
  }

  Future<void> _pickPhoto() async {
    if (!_canPickPhoto) {
      _showMessage(
        'Foto valimine on selles versioonis saadaval ainult '
        'töölauarakenduses.',
      );
      return;
    }
    if (_isPickingPhoto) {
      return;
    }

    setState(() {
      _isPickingPhoto = true;
      _photoPickerError = null;
    });

    String? path;
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: const <String>['jpg', 'jpeg', 'png', 'webp'],
        withData: false,
      );
      if (result != null && result.files.isNotEmpty) {
        path = result.files.single.path;
      }
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isPickingPhoto = false;
        _photoPickerError = 'Foto valimine ebaõnnestus.';
      });
      return;
    }

    if (!mounted) {
      return;
    }
    final selectedPath = path?.trim();
    if (selectedPath == null || selectedPath.isEmpty) {
      setState(() {
        _isPickingPhoto = false;
      });
      return;
    }
    final extensionSeparator = selectedPath.lastIndexOf('.');
    final extension = extensionSeparator < 0
        ? ''
        : selectedPath.substring(extensionSeparator + 1).toLowerCase();
    const supportedExtensions = <String>{'jpg', 'jpeg', 'png', 'webp'};
    if (!supportedExtensions.contains(extension)) {
      setState(() {
        _isPickingPhoto = false;
        _photoPickerError = 'Vali JPG-, JPEG-, PNG- või WEBP-vormingus foto.';
      });
      return;
    }

    setState(() {
      _isPickingPhoto = false;
      _photoPickerError = null;
      _photoPath = selectedPath;
      _photoTransform = const NewProjectWizardPhotoTransform();
      _draftTouched = true;
    });
  }

  void _setPhotoTranslation(Offset translation) {
    final current = _photoTransform.translation;
    final next = Offset(
      translation.dx.isFinite ? translation.dx : current.dx,
      translation.dy.isFinite ? translation.dy : current.dy,
    );
    if (next == current) {
      return;
    }
    setState(() {
      _photoTransform = _photoTransform.copyWith(translation: next);
      _draftTouched = true;
    });
  }

  void _setPhotoScale(double scale) {
    if (!scale.isFinite) {
      return;
    }
    final next = scale
        .clamp(
          NewProjectWizardPhotoEditor.minimumScale,
          NewProjectWizardPhotoEditor.maximumScale,
        )
        .toDouble();
    if (next == _photoTransform.scale) {
      return;
    }
    setState(() {
      _photoTransform = _photoTransform.copyWith(scale: next);
      _draftTouched = true;
    });
  }

  double _normalizedPhotoRotation(double rotation) {
    if (!rotation.isFinite) {
      return _photoTransform.rotation;
    }
    const fullTurn = 2 * math.pi;
    final normalized = (rotation + math.pi) % fullTurn - math.pi;
    return normalized == -0.0 ? 0.0 : normalized;
  }

  void _setPhotoRotation(double rotation) {
    final next = _normalizedPhotoRotation(rotation);
    if (next == _photoTransform.rotation) {
      return;
    }
    setState(() {
      _photoTransform = _photoTransform.copyWith(rotation: next);
      _draftTouched = true;
    });
  }

  void _setPhotoOpacity(double opacity) {
    if (!opacity.isFinite) {
      return;
    }
    final next = opacity.clamp(0.0, 1.0).toDouble();
    if (next == _photoTransform.opacity) {
      return;
    }
    setState(() {
      _photoTransform = _photoTransform.copyWith(opacity: next);
      _draftTouched = true;
    });
  }

  void _resetPhotoView() {
    setState(() {
      _photoTransform = NewProjectWizardPhotoTransform(
        opacity: _photoTransform.opacity,
      );
      _draftTouched = true;
    });
  }

  void _removePhoto() {
    if (_photoPath == null) {
      return;
    }
    setState(() {
      _photoPath = null;
      _photoTransform = const NewProjectWizardPhotoTransform();
      _photoPickerError = null;
      _draftTouched = true;
    });
  }

  void _goNext() {
    if (!_canAdvanceFromStep(_currentStep)) {
      return;
    }
    if (_currentStep >= _wizardSteps.length - 1) {
      return;
    }
    setState(() {
      _currentStep += 1;
      _visitedSteps.add(_currentStep);
    });
  }

  void _goBack() {
    if (_currentStep == 0) {
      return;
    }
    setState(() {
      _currentStep -= 1;
      _visitedSteps.add(_currentStep);
    });
  }

  bool _canNavigateToVisitedStep(int targetStep) {
    if (_creationStatus == _WizardCreationStatus.creating ||
        _creationStatus == _WizardCreationStatus.succeeded) {
      return false;
    }
    if (targetStep == _currentStep || !_visitedSteps.contains(targetStep)) {
      return false;
    }
    if (targetStep < _currentStep) {
      return true;
    }
    for (var index = _currentStep; index < targetStep; index += 1) {
      if (!_canAdvanceFromStep(index)) {
        return false;
      }
    }
    return true;
  }

  void _navigateToVisitedStep(int targetStep) {
    if (!_canNavigateToVisitedStep(targetStep)) {
      return;
    }
    setState(() {
      _currentStep = targetStep;
    });
  }

  void _editReviewStep(int targetStep) {
    if (_currentStep != 5 ||
        targetStep < 0 ||
        targetStep > 4 ||
        _creationStatus == _WizardCreationStatus.creating ||
        _creationStatus == _WizardCreationStatus.succeeded) {
      return;
    }
    setState(() {
      _currentStep = targetStep;
    });
  }

  void _openCreatedProject() {
    if (_creationStatus != _WizardCreationStatus.succeeded ||
        _createdProjectState == null) {
      return;
    }
    context.go('/project');
  }

  Rect _referenceFrameRect(Size editorSize) {
    if (editorSize.width <= 0 || editorSize.height <= 0) {
      return Rect.zero;
    }
    final aspect = _referenceFrameAspectRatio;
    if (aspect == null) {
      return Offset.zero & editorSize;
    }
    final editorAspect = editorSize.width / editorSize.height;
    if (editorAspect > aspect) {
      final width = editorSize.height * aspect;
      return Rect.fromLTWH(
        (editorSize.width - width) / 2,
        0,
        width,
        editorSize.height,
      );
    }
    final height = editorSize.width / aspect;
    return Rect.fromLTWH(
      0,
      (editorSize.height - height) / 2,
      editorSize.width,
      height,
    );
  }

  Offset? _normalizedReferenceFramePoint(
    Offset localPosition,
    Size editorSize,
  ) {
    final frame = _referenceFrameRect(editorSize);
    if (frame.isEmpty || !frame.contains(localPosition)) {
      return null;
    }
    return Offset(
      (localPosition.dx - frame.left) / frame.width,
      (localPosition.dy - frame.top) / frame.height,
    );
  }

  Offset _contourPointOnCanvas(Offset point, Size editorSize) {
    final frame = _referenceFrameRect(editorSize);
    return Offset(
      frame.left + (point.dx * frame.width),
      frame.top + (point.dy * frame.height),
    );
  }

  int? _contourPointAt(Offset localPosition, Size editorSize) {
    if (!_referenceFrameRect(editorSize).contains(localPosition)) {
      return null;
    }
    const hitRadius = 26.0;
    int? closestIndex;
    var closestDistance = double.infinity;
    for (var index = 0; index < _contourPoints.length; index += 1) {
      final distance =
          (_contourPointOnCanvas(_contourPoints[index], editorSize) -
                  localPosition)
              .distance;
      if (distance <= hitRadius && distance < closestDistance) {
        closestIndex = index;
        closestDistance = distance;
      }
    }
    return closestIndex;
  }

  void _handleContourTap(TapUpDetails details, Size editorSize) {
    if (!_referenceFrameRect(editorSize).contains(details.localPosition)) {
      return;
    }
    final selectedIndex = _contourPointAt(details.localPosition, editorSize);
    if (selectedIndex != null) {
      setState(() {
        _selectedContourPointIndex = selectedIndex;
      });
      return;
    }

    final normalized =
        _normalizedReferenceFramePoint(details.localPosition, editorSize);
    if (normalized == null) {
      return;
    }
    setState(() {
      _referenceFrameAspectRatio ??= editorSize.width / editorSize.height;
      _contourPoints.add(normalized);
      _selectedContourPointIndex = _contourPoints.length - 1;
      _contourClosed = false;
      _draftTouched = true;
    });
  }

  void _handleContourPointerDown(
    PointerDownEvent details,
    Size editorSize,
  ) {
    if (!_referenceFrameRect(editorSize).contains(details.localPosition)) {
      return;
    }
    final selectedIndex = _contourPointAt(details.localPosition, editorSize);
    setState(() {
      _selectedContourPointIndex = selectedIndex;
      _draggingContourPointIndex = selectedIndex;
      _draggingContourPointer = selectedIndex == null ? null : details.pointer;
    });
  }

  void _handleContourPointerMove(
    PointerMoveEvent details,
    Size editorSize,
  ) {
    if (details.pointer != _draggingContourPointer) {
      return;
    }
    final selectedIndex = _draggingContourPointIndex;
    if (selectedIndex == null ||
        selectedIndex < 0 ||
        selectedIndex >= _contourPoints.length) {
      return;
    }
    final nextPoint =
        _normalizedReferenceFramePoint(details.localPosition, editorSize);
    if (nextPoint == null) {
      return;
    }
    if (_contourPoints[selectedIndex] == nextPoint) {
      return;
    }
    setState(() {
      _contourPoints[selectedIndex] = nextPoint;
      _contourClosed = false;
      _draftTouched = true;
    });
  }

  void _handleContourPointerEnd(PointerEvent details) {
    if (details.pointer != _draggingContourPointer) {
      return;
    }
    _draggingContourPointIndex = null;
    _draggingContourPointer = null;
  }

  void _deleteSelectedContourPoint() {
    final selectedIndex = _selectedContourPointIndex;
    if (selectedIndex == null ||
        selectedIndex < 0 ||
        selectedIndex >= _contourPoints.length) {
      return;
    }
    setState(() {
      _contourPoints.removeAt(selectedIndex);
      _selectedContourPointIndex = null;
      _draggingContourPointIndex = null;
      _draggingContourPointer = null;
      _contourClosed = false;
      _draftTouched = true;
    });
  }

  void _resetContour() {
    if (_contourPoints.isEmpty) {
      return;
    }
    setState(() {
      _contourPoints.clear();
      _selectedContourPointIndex = null;
      _draggingContourPointIndex = null;
      _draggingContourPointer = null;
      _contourClosed = false;
      _draftTouched = true;
    });
  }

  void _closeContour() {
    if (_contourPoints.length < 3 || _contourClosed) {
      return;
    }
    setState(() {
      _contourClosed = true;
      _draftTouched = true;
    });
  }

  Offset? _normalizedComponentPosition(
    Offset localPosition,
    Size editorSize,
  ) {
    return _normalizedReferenceFramePoint(localPosition, editorSize);
  }

  String _componentShapeLabel(_WizardComponentShape shape) {
    return switch (shape) {
      _WizardComponentShape.circle => 'Ümar',
      _WizardComponentShape.square => 'Ruut',
      _WizardComponentShape.rectangle => 'Ristkülik',
      _WizardComponentShape.roundedRectangle => 'Ümardatud ristkülik',
    };
  }

  double _normalizedComponentRotation(double rotation) {
    if (!rotation.isFinite) {
      return _componentCurrentRotation;
    }
    const fullTurn = 2 * math.pi;
    final normalized = (rotation + math.pi) % fullTurn - math.pi;
    return normalized == -0.0 ? 0.0 : normalized;
  }

  void _setComponentShape(_WizardComponentShape shape) {
    if (shape == _componentCurrentShape) {
      return;
    }
    setState(() {
      _componentCurrentShape = shape;
      final selectedIndex = _selectedComponentCandidateIndex;
      if (selectedIndex != null) {
        _componentCandidates[selectedIndex] =
            _componentCandidates[selectedIndex].copyWith(shape: shape);
        _draftTouched = true;
      }
    });
  }

  void _setComponentSizeScale(double sizeScale) {
    if (!sizeScale.isFinite) {
      return;
    }
    final next = sizeScale.clamp(0.5, 2.5).toDouble();
    if (next == _componentCurrentSizeScale) {
      return;
    }
    setState(() {
      _componentCurrentSizeScale = next;
      final selectedIndex = _selectedComponentCandidateIndex;
      if (selectedIndex != null) {
        _componentCandidates[selectedIndex] =
            _componentCandidates[selectedIndex].copyWith(sizeScale: next);
        _draftTouched = true;
      }
    });
  }

  void _setComponentRotation(double rotation) {
    final next = _normalizedComponentRotation(rotation);
    if (next == _componentCurrentRotation) {
      return;
    }
    setState(() {
      _componentCurrentRotation = next;
      final selectedIndex = _selectedComponentCandidateIndex;
      if (selectedIndex != null) {
        _componentCandidates[selectedIndex] =
            _componentCandidates[selectedIndex].copyWith(rotation: next);
        _draftTouched = true;
      }
    });
  }

  int? get _selectedComponentCandidateIndex {
    final selectedKey = _selectedComponentDraftKey;
    if (selectedKey == null) {
      return null;
    }
    final index = _componentCandidates.indexWhere(
      (candidate) => candidate.draftKey == selectedKey,
    );
    return index < 0 ? null : index;
  }

  void _loadComponentCurrentStyle(_WizardComponentCandidate candidate) {
    _componentCurrentShape = candidate.shape;
    _componentCurrentSizeScale = candidate.sizeScale;
    _componentCurrentRotation = candidate.rotation;
  }

  int? _componentCandidateKeyAt(
    Offset localPosition,
    Size editorSize,
  ) {
    final referenceFrame = _referenceFrameRect(editorSize);
    if (!referenceFrame.contains(localPosition)) {
      return null;
    }
    final framePosition = localPosition - referenceFrame.topLeft;
    int? closestKey;
    var closestDistance = double.infinity;
    for (final candidate in _componentCandidates) {
      final geometry = _WizardComponentMarkerGeometry.fromCandidate(
        candidate,
        referenceFrame.size,
      );
      if (!geometry.hitBounds.contains(framePosition)) {
        continue;
      }
      final distance = (geometry.centre - framePosition).distance;
      if (distance < closestDistance) {
        closestKey = candidate.draftKey;
        closestDistance = distance;
      }
    }
    return closestKey;
  }

  void _handleComponentTap(TapUpDetails details, Size editorSize) {
    if (!_referenceFrameRect(editorSize).contains(details.localPosition)) {
      return;
    }
    final selectedKey = _componentCandidateKeyAt(
      details.localPosition,
      editorSize,
    );
    if (selectedKey != null) {
      final selectedCandidate = _componentCandidates.firstWhere(
        (candidate) => candidate.draftKey == selectedKey,
      );
      setState(() {
        _selectedComponentDraftKey = selectedKey;
        _loadComponentCurrentStyle(selectedCandidate);
      });
      return;
    }

    final normalized = _normalizedComponentPosition(
      details.localPosition,
      editorSize,
    );
    if (normalized == null) {
      return;
    }
    setState(() {
      final candidate = _WizardComponentCandidate(
        draftKey: _nextComponentDraftKey,
        position: normalized,
        shape: _componentCurrentShape,
        sizeScale: _componentCurrentSizeScale,
        rotation: _componentCurrentRotation,
      );
      _nextComponentDraftKey += 1;
      _componentCandidates.add(candidate);
      _selectedComponentDraftKey = candidate.draftKey;
      _draftTouched = true;
    });
  }

  void _handleComponentPointerDown(
    PointerDownEvent details,
    Size editorSize,
  ) {
    if (!_referenceFrameRect(editorSize).contains(details.localPosition)) {
      return;
    }
    final selectedKey = _componentCandidateKeyAt(
      details.localPosition,
      editorSize,
    );
    if (selectedKey == null) {
      return;
    }
    final selectedCandidate = _componentCandidates.firstWhere(
      (candidate) => candidate.draftKey == selectedKey,
    );
    setState(() {
      _selectedComponentDraftKey = selectedKey;
      _draggingComponentDraftKey = selectedKey;
      _draggingComponentPointer = details.pointer;
      _loadComponentCurrentStyle(selectedCandidate);
    });
  }

  void _handleComponentPointerMove(
    PointerMoveEvent details,
    Size editorSize,
  ) {
    if (details.pointer != _draggingComponentPointer) {
      return;
    }
    final draggingKey = _draggingComponentDraftKey;
    if (draggingKey == null) {
      return;
    }
    final candidateIndex = _componentCandidates.indexWhere(
      (candidate) => candidate.draftKey == draggingKey,
    );
    if (candidateIndex < 0) {
      return;
    }
    final nextPosition = _normalizedComponentPosition(
      details.localPosition,
      editorSize,
    );
    if (nextPosition == null) {
      return;
    }
    if (_componentCandidates[candidateIndex].position == nextPosition) {
      return;
    }
    setState(() {
      _componentCandidates[candidateIndex] =
          _componentCandidates[candidateIndex].movedTo(nextPosition);
      _draftTouched = true;
    });
  }

  void _handleComponentPointerEnd(PointerEvent details) {
    if (details.pointer != _draggingComponentPointer) {
      return;
    }
    setState(() {
      _draggingComponentDraftKey = null;
      _draggingComponentPointer = null;
    });
  }

  void _deleteSelectedComponentCandidate() {
    final selectedKey = _selectedComponentDraftKey;
    if (selectedKey == null) {
      return;
    }
    final candidateIndex = _componentCandidates.indexWhere(
      (candidate) => candidate.draftKey == selectedKey,
    );
    if (candidateIndex < 0) {
      return;
    }
    setState(() {
      _componentCandidates.removeAt(candidateIndex);
      _selectedComponentDraftKey = null;
      _draggingComponentDraftKey = null;
      _draggingComponentPointer = null;
      _draftTouched = true;
    });
  }

  Future<void> _cancelWizard() async {
    if (_creationStatus == _WizardCreationStatus.creating ||
        _creationStatus == _WizardCreationStatus.succeeded) {
      return;
    }
    if (!_draftTouched) {
      context.go('/');
      return;
    }

    final shouldCancel = await showDialog<bool>(
      context: context,
      barrierColor: const Color(0xCC050505),
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _WizardPalette.panel,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            'Katkestada projekti loomine?',
            style: TextStyle(color: _WizardPalette.cream),
          ),
          content: const Text(
            'Sisestatud andmeid ei salvestata.',
            style: TextStyle(color: _WizardPalette.muted),
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: _WizardPalette.frame),
            borderRadius: BorderRadius.circular(18),
          ),
          actions: <Widget>[
            TextButton(
              key: const ValueKey('wizard-cancel-dialog-continue'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: _WizardPalette.cream,
              ),
              child: const Text('Jätka loomist'),
            ),
            FilledButton(
              key: const ValueKey('wizard-cancel-dialog-confirm'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: _WizardPalette.warning,
                foregroundColor: _WizardPalette.background,
              ),
              child: const Text('Katkesta'),
            ),
          ],
        );
      },
    );

    if (!mounted || shouldCancel != true) {
      return;
    }
    context.go('/');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _deviceNameController.dispose();
    _additionalInfoController.dispose();
    _deviceTypeController.dispose();
    _manufacturerController.dispose();
    _modelController.dispose();
    _revisionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('new-project-wizard-screen'),
      backgroundColor: _WizardPalette.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 1050;
            final padding = constraints.maxWidth < 600 ? 12.0 : 20.0;
            final content = compact
                ? Column(
                    key: const ValueKey('wizard-compact-layout'),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildCompactProgress(),
                      const SizedBox(height: 14),
                      _buildEditorCard(compact: true),
                    ],
                  )
                : Row(
                    key: const ValueKey('wizard-wide-layout'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 296,
                        child: _buildWideProgress(),
                      ),
                      const SizedBox(width: 18),
                      Expanded(child: _buildEditorCard(compact: false)),
                    ],
                  );

            return DecoratedBox(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.75, -0.9),
                  radius: 1.25,
                  colors: <Color>[
                    Color(0xFF211B10),
                    _WizardPalette.background,
                  ],
                  stops: <double>[0, 0.62],
                ),
              ),
              child: SingleChildScrollView(
                physics: _draggingComponentDraftKey == null
                    ? null
                    : const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(padding),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1840),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(),
                        const SizedBox(height: 18),
                        content,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    const brand = Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 8,
      children: <Widget>[
        Icon(
          Icons.memory_outlined,
          color: _WizardPalette.gold,
          size: 31,
        ),
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: 'bench',
                style: TextStyle(color: _WizardPalette.gold),
              ),
              TextSpan(
                text: 'beep',
                style: TextStyle(color: _WizardPalette.cream),
              ),
            ],
          ),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        _WizardPill(label: 'Loo projekt nullist'),
      ],
    );
    final cancel = _creationStatus == _WizardCreationStatus.succeeded
        ? null
        : TextButton.icon(
            key: const ValueKey('wizard-cancel'),
            onPressed: _creationStatus == _WizardCreationStatus.creating
                ? null
                : _cancelWizard,
            icon: const Icon(Icons.close),
            label: const Text('Katkesta'),
            style: TextButton.styleFrom(
              foregroundColor: _WizardPalette.warningBright,
              side: const BorderSide(color: _WizardPalette.warning),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xCC131110),
        border: Border.all(color: _WizardPalette.frame),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 620) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                brand,
                if (cancel != null) ...[
                  const SizedBox(height: 12),
                  Align(alignment: Alignment.centerLeft, child: cancel),
                ],
              ],
            );
          }
          return Row(
            children: <Widget>[
              const Expanded(child: brand),
              const SizedBox(width: 16),
              Text(
                'Samm ${_currentStep + 1} / ${_wizardSteps.length}',
                style: const TextStyle(
                  color: _WizardPalette.faint,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (cancel != null) ...[
                const SizedBox(width: 12),
                cancel,
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildWideProgress() {
    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.panel,
        border: Border.all(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'UUS PROJEKT',
            style: TextStyle(
              color: _WizardPalette.goldDim,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.7,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_wizardSteps.length} sammu',
            style: const TextStyle(
              color: _WizardPalette.cream,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Kasuta Edasi ja Tagasi nuppe või vali juba vaadatud samm. '
            'Mustand püsib ainult selles vaates.',
            style: TextStyle(
              color: _WizardPalette.muted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          for (var index = 0; index < _wizardSteps.length; index += 1) ...[
            _buildProgressTile(index, compact: false),
            if (index < _wizardSteps.length - 1) const SizedBox(height: 9),
          ],
        ],
      ),
    );
  }

  Widget _buildCompactProgress() {
    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.panel,
        border: Border.all(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 91,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: _wizardSteps.length,
          separatorBuilder: (_, __) => const SizedBox(width: 9),
          itemBuilder: (_, index) {
            return SizedBox(
              width: 226,
              child: _buildProgressTile(index, compact: true),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressTile(int index, {required bool compact}) {
    final step = _wizardSteps[index];
    final isCurrent = index == _currentStep;
    final isVisited = _visitedSteps.contains(index);
    final isComplete = !isCurrent &&
        isVisited &&
        _isRequiredStep(index) &&
        _requiredStepIsValid(index);
    final isViewed = !isCurrent && isVisited && !isComplete;
    final canNavigate = _canNavigateToVisitedStep(index);
    final navigate = canNavigate ? () => _navigateToVisitedStep(index) : null;
    final status = isCurrent
        ? 'Praegune samm'
        : isComplete
            ? 'Valmis'
            : isViewed
                ? 'Vaadatud'
                : 'Järgmine samm';
    final statusIcon = isCurrent
        ? Icons.radio_button_checked
        : isComplete
            ? Icons.check_circle
            : isViewed
                ? Icons.visibility_outlined
                : Icons.circle_outlined;
    final accent = isCurrent
        ? _WizardPalette.gold
        : isComplete
            ? _WizardPalette.ready
            : isViewed
                ? _WizardPalette.goldDim
                : _WizardPalette.faint;

    return Semantics(
      key: ValueKey('wizard-progress-step-${index + 1}'),
      label: 'Samm ${index + 1}: ${step.label}. $status.',
      button: canNavigate,
      enabled: canNavigate ? true : null,
      onTap: navigate,
      excludeSemantics: true,
      child: TextButton(
        onPressed: navigate,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color:
                isCurrent ? _WizardPalette.activeFill : _WizardPalette.panel2,
            border: Border.all(
              color: isCurrent
                  ? _WizardPalette.frame
                  : isComplete
                      ? _WizardPalette.ready
                      : isViewed
                          ? _WizardPalette.edgeGold
                          : _WizardPalette.edge,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: compact ? 10 : 11,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 31,
                height: 31,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: accent, width: 1.4),
                  ),
                  child: Center(
                    child: isCurrent || isComplete || isViewed
                        ? Icon(statusIcon, color: accent, size: 17)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      step.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isCurrent
                            ? _WizardPalette.gold
                            : _WizardPalette.cream,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: <Widget>[
                        Icon(statusIcon, color: accent, size: 13),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            status,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditorCard({required bool compact}) {
    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.panel,
        border: Border.all(color: _WizardPalette.frame),
        borderRadius: BorderRadius.circular(17),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x332D240F),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(compact ? 16 : 28),
            child: switch (_currentStep) {
              0 => _buildStepOne(compact: compact),
              1 => _buildPhotoAlignmentStep(compact: compact),
              2 => _buildContourStep(compact: compact),
              3 => _buildComponentPlacementStep(compact: compact),
              4 => _buildProblemDescriptionStep(compact: compact),
              5 => _buildReviewStep(compact: compact),
              6 => _buildCreatedStep(compact: compact),
              _ => const SizedBox.shrink(),
            },
          ),
          _buildActionBar(compact: compact),
        ],
      ),
    );
  }

  Widget _buildStepOne({required bool compact}) {
    final form = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildFieldLabel('Projekti nimi', required: true),
        const SizedBox(height: 8),
        TextField(
          key: const ValueKey('wizard-project-name'),
          controller: _projectNameController,
          onChanged: _handleDraftTextChanged,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: _WizardPalette.cream),
          decoration: _inputDecoration(
            hintText: 'nt Pelle PV20',
          ),
        ),
        const SizedBox(height: 18),
        _buildFieldLabel('Seadme nimetus'),
        const SizedBox(height: 8),
        TextField(
          key: const ValueKey('wizard-device-name'),
          controller: _deviceNameController,
          onChanged: _handleDraftTextChanged,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: _WizardPalette.cream),
          decoration: _inputDecoration(
            hintText: 'nt Põletikontroller REV_0.1',
          ),
        ),
        const SizedBox(height: 18),
        _buildFieldLabel('Salvestuskoht', required: true),
        const SizedBox(height: 8),
        _buildFolderPicker(),
        const SizedBox(height: 18),
        _buildFieldLabel('Lisainfo'),
        const SizedBox(height: 8),
        TextField(
          key: const ValueKey('wizard-additional-info'),
          controller: _additionalInfoController,
          onChanged: _handleDraftTextChanged,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 3,
          maxLines: 5,
          style: const TextStyle(color: _WizardPalette.cream),
          decoration: _inputDecoration(
            hintText: 'Vabatekst — taust, märkused või muu oluline.',
          ),
        ),
        const SizedBox(height: 18),
        _buildAdvancedStepOne(),
      ],
    );
    const safety = _WizardSafetyCard();

    return KeyedSubtree(
      key: const ValueKey('wizard-step-1-editor'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 1 / ${_wizardSteps.length}',
            title: 'Projekti andmed',
            description:
                'Sisesta projekti mustandi põhiandmed. Ainult nimi ja valitud '
                'salvestuskoht avavad järgmise sammu.',
            required: true,
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              if (compact || constraints.maxWidth < 820) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    form,
                    const SizedBox(height: 20),
                    safety,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: form),
                  const SizedBox(width: 24),
                  const SizedBox(width: 310, child: safety),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedStepOne() {
    return Material(
      color: _WizardPalette.panel2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: const ValueKey('wizard-step-one-advanced'),
          initiallyExpanded: _advancedStepOneExpanded,
          maintainState: true,
          onExpansionChanged: (expanded) {
            setState(() {
              _advancedStepOneExpanded = expanded;
            });
          },
          iconColor: _WizardPalette.gold,
          collapsedIconColor: _WizardPalette.goldDim,
          textColor: _WizardPalette.cream,
          collapsedTextColor: _WizardPalette.cream,
          title: const Text(
            'Täpsemalt',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          subtitle: const Text(
            'Valikulised seadme metaandmed',
            style: TextStyle(color: _WizardPalette.muted),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(14, 2, 14, 16),
          children: <Widget>[
            const Text(
              'Tulevane AI võib aidata välju korrastada, kuid selles vaates '
              'ei käivitata AI-, OCR- ega CV-töötlust.',
              style: TextStyle(
                color: _WizardPalette.faint,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 14),
            _buildAdvancedField(
              label: 'Seadme tüüp',
              key: const ValueKey('wizard-device-type'),
              controller: _deviceTypeController,
              hintText: 'nt põletikontroller',
            ),
            const SizedBox(height: 14),
            _buildAdvancedField(
              label: 'Tootja',
              key: const ValueKey('wizard-manufacturer'),
              controller: _manufacturerController,
              hintText: 'nt Pelle',
            ),
            const SizedBox(height: 14),
            _buildAdvancedField(
              label: 'Mudel',
              key: const ValueKey('wizard-model'),
              controller: _modelController,
              hintText: 'nt PV20',
            ),
            const SizedBox(height: 14),
            _buildAdvancedField(
              label: 'Revisjon',
              key: const ValueKey('wizard-revision'),
              controller: _revisionController,
              hintText: 'nt REV_0.1',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedField({
    required String label,
    required Key key,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildFieldLabel(label),
        const SizedBox(height: 7),
        TextField(
          key: key,
          controller: controller,
          onChanged: _handleDraftTextChanged,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: _WizardPalette.cream),
          decoration: _inputDecoration(hintText: hintText),
        ),
      ],
    );
  }

  Widget _buildContourStep({required bool compact}) {
    return KeyedSubtree(
      key: const ValueKey('wizard-contour-editor'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 3 / ${_wizardSteps.length}',
            title: 'Plaadi kontuur',
            description:
                'Lisa vähemalt kolm punkti, liiguta neid vajadusel ja sulge '
                'kontuur eraldi toiminguga.',
            required: true,
          ),
          const SizedBox(height: 22),
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = compact || constraints.maxWidth < 780;
              final canvas = _buildContourCanvas(
                height: stacked ? 300 : 430,
              );
              final controls = _buildContourControls();
              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    canvas,
                    const SizedBox(height: 16),
                    controls,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: canvas),
                  const SizedBox(width: 18),
                  SizedBox(width: 286, child: controls),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: _WizardPalette.activeFill,
              border: Border.all(color: _WizardPalette.edgeGold),
              borderRadius: BorderRadius.circular(13),
            ),
            padding: const EdgeInsets.all(14),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.visibility_outlined,
                  color: _WizardPalette.gold,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'See on inimese loodud visuaalne kandidaat. Sulgemine ei '
                    'kinnita plaadi mõõte, identiteeti, füüsilist kehtivust '
                    'ega elektrilist tähendust.',
                    style: TextStyle(
                      color: _WizardPalette.muted,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContourCanvas({required double height}) {
    final count = _contourPoints.length;
    final status = _contourClosed ? 'suletud' : 'avatud';
    return Semantics(
      container: true,
      label: 'Kontuuriredaktor',
      value: '$count punkti, kontuur $status',
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _WizardPalette.inset,
          border: Border.all(color: _WizardPalette.edgeGold),
          borderRadius: BorderRadius.circular(14),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final editorSize = constraints.biggest;
            final referenceFrame = _referenceFrameRect(editorSize);
            return Listener(
              onPointerDown: (details) =>
                  _handleContourPointerDown(details, editorSize),
              onPointerMove: (details) =>
                  _handleContourPointerMove(details, editorSize),
              onPointerUp: _handleContourPointerEnd,
              onPointerCancel: _handleContourPointerEnd,
              child: GestureDetector(
                key: const ValueKey('wizard-contour-canvas'),
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) => _handleContourTap(details, editorSize),
                child: Stack(
                  key: const ValueKey('wizard-contour-stack'),
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned.fromRect(
                      rect: referenceFrame,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          if (_photoPath != null)
                            Positioned.fill(
                              key: const ValueKey(
                                'wizard-contour-photo-layer',
                              ),
                              child: IgnorePointer(
                                child: NewProjectWizardPhotoLayer(
                                  key: const ValueKey(
                                    'wizard-contour-photo-view',
                                  ),
                                  photoPath: _photoPath!,
                                  transform: _photoTransform,
                                ),
                              ),
                            ),
                          CustomPaint(
                            key: const ValueKey('wizard-contour-painter'),
                            painter: _WizardContourPainter(
                              points: List<Offset>.unmodifiable(_contourPoints),
                              selectedIndex: _selectedContourPointIndex,
                              closed: _contourClosed,
                            ),
                          ),
                          if (_contourPoints.isEmpty)
                            const IgnorePointer(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.touch_app_outlined,
                                        color: _WizardPalette.goldDim,
                                        size: 34,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Puuduta tühja ala, et lisada esimene '
                                        'punkt.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: _WizardPalette.muted,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContourControls() {
    final pointCount = _contourPoints.length;
    final pointCountLabel = pointCount == 1 ? '1 punkt' : '$pointCount punkti';
    final selectedIndex = _selectedContourPointIndex;
    final selectionLabel = selectedIndex == null
        ? 'Ühtegi punkti pole valitud'
        : 'Punkt ${selectedIndex + 1} valitud';

    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.panel2,
        border: Border.all(color: _WizardPalette.edge),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildContourStateRow(
            key: const ValueKey('wizard-contour-point-count'),
            icon: Icons.scatter_plot_outlined,
            label: pointCountLabel,
          ),
          const SizedBox(height: 10),
          _buildContourStateRow(
            key: const ValueKey('wizard-contour-selection'),
            icon: selectedIndex == null
                ? Icons.touch_app_outlined
                : Icons.ads_click_outlined,
            label: selectionLabel,
          ),
          const SizedBox(height: 10),
          _buildContourStateRow(
            key: const ValueKey('wizard-contour-status'),
            icon:
                _contourClosed ? Icons.lock_outline : Icons.lock_open_outlined,
            label: _contourClosed ? 'Kontuur suletud' : 'Kontuur avatud',
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            key: const ValueKey('wizard-contour-close'),
            onPressed:
                pointCount >= 3 && !_contourClosed ? _closeContour : null,
            icon: const Icon(Icons.join_full),
            label: const Text('Sulge kontuur'),
            style: FilledButton.styleFrom(
              backgroundColor: _WizardPalette.goldBright,
              foregroundColor: const Color(0xFF241C0A),
              disabledBackgroundColor: _WizardPalette.edge,
              disabledForegroundColor: _WizardPalette.faint,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            key: const ValueKey('wizard-contour-delete'),
            onPressed:
                selectedIndex == null ? null : _deleteSelectedContourPoint,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Kustuta valitud punkt'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _WizardPalette.warningBright,
              side: const BorderSide(color: _WizardPalette.warning),
              padding: const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            key: const ValueKey('wizard-contour-reset'),
            onPressed: pointCount == 0 ? null : _resetContour,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Nulli kontuur'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _WizardPalette.cream,
              side: const BorderSide(color: _WizardPalette.edgeGold),
              padding: const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Punkti valimiseks puuduta seda. Liigutamiseks lohista valitud '
            'punkti. Muudatus avab suletud kontuuri uuesti.',
            style: TextStyle(
              color: _WizardPalette.faint,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContourStateRow({
    required Key key,
    required IconData icon,
    required String label,
  }) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: _WizardPalette.inset,
        border: Border.all(color: _WizardPalette.edge),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(icon, color: _WizardPalette.goldDim, size: 19),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _WizardPalette.cream,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentPlacementStep({required bool compact}) {
    return KeyedSubtree(
      key: const ValueKey('wizard-component-editor'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 4 / ${_wizardSteps.length}',
            title: 'Komponentide asetus',
            description:
                'Lisa käsitsi üldised visuaalsed kandidaadid ning liiguta '
                'neid plaadi kontuuri taustal.',
            required: false,
            dense: true,
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = compact || constraints.maxWidth < 780;
              final canvas = _buildComponentCanvas(
                height: stacked ? 300 : 430,
              );
              final controls = _buildComponentControls();
              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    canvas,
                    const SizedBox(height: 16),
                    controls,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: canvas),
                  const SizedBox(width: 18),
                  SizedBox(width: 286, child: controls),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Container(
            key: const ValueKey('wizard-component-boundary-note'),
            decoration: BoxDecoration(
              color: _WizardPalette.activeFill,
              border: Border.all(color: _WizardPalette.edgeGold),
              borderRadius: BorderRadius.circular(11),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.visibility_outlined,
                  color: _WizardPalette.gold,
                  size: 17,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Kandidaadid on inimese loodud visuaalsed ettepanekud. '
                    'Need ei kinnita komponendi identiteeti, tüüpi, väärtust, '
                    'tähist, korpust, jalajälge, jalgu, kontakte, plaadipoolt, '
                    'ühendusi, võrku, mõõtmist ega diagnoosi ning ei loo '
                    'püsivat ega kanoonilist fakti.',
                    style: TextStyle(
                      color: _WizardPalette.muted,
                      fontSize: 11.5,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentCanvas({required double height}) {
    final count = _componentCandidates.length;
    final countLabel = count == 1 ? '1 kandidaat' : '$count kandidaati';
    final selectedKey = _selectedComponentDraftKey;
    final selection = selectedKey == null
        ? 'ühtegi kandidaati pole valitud'
        : 'kandidaat $selectedKey valitud';
    return Semantics(
      container: true,
      label: 'Komponentide asetuse redaktor',
      value: '$countLabel, $selection',
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _WizardPalette.inset,
          border: Border.all(color: _WizardPalette.edgeGold),
          borderRadius: BorderRadius.circular(14),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final editorSize = constraints.biggest;
            final referenceFrame = _referenceFrameRect(editorSize);
            return Listener(
              onPointerDown: (details) =>
                  _handleComponentPointerDown(details, editorSize),
              onPointerMove: (details) =>
                  _handleComponentPointerMove(details, editorSize),
              onPointerUp: _handleComponentPointerEnd,
              onPointerCancel: _handleComponentPointerEnd,
              child: GestureDetector(
                key: const ValueKey('wizard-component-canvas'),
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) => _handleComponentTap(details, editorSize),
                child: Stack(
                  key: const ValueKey('wizard-component-stack'),
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned.fromRect(
                      rect: referenceFrame,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          if (_photoPath != null)
                            Positioned.fill(
                              key: const ValueKey(
                                'wizard-component-photo-layer',
                              ),
                              child: IgnorePointer(
                                child: NewProjectWizardPhotoLayer(
                                  key: const ValueKey(
                                    'wizard-component-photo-view',
                                  ),
                                  photoPath: _photoPath!,
                                  transform: _photoTransform,
                                ),
                              ),
                            ),
                          CustomPaint(
                            key: const ValueKey('wizard-component-painter'),
                            painter: _WizardComponentPlacementPainter(
                              guideContourPoints:
                                  List<Offset>.unmodifiable(_contourPoints),
                              guideClosed: _contourClosed,
                              candidates:
                                  List<_WizardComponentCandidate>.unmodifiable(
                                      _componentCandidates),
                              selectedDraftKey: _selectedComponentDraftKey,
                            ),
                          ),
                          if (_componentCandidates.isEmpty)
                            const IgnorePointer(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_location_alt_outlined,
                                        color: _WizardPalette.goldDim,
                                        size: 34,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Puuduta tühja ala, et lisada üldine '
                                        'komponent-kandidaat.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: _WizardPalette.muted,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildComponentControls() {
    final candidateCount = _componentCandidates.length;
    final candidateCountLabel = switch (candidateCount) {
      0 => '0 komponent-kandidaati',
      1 => '1 komponent-kandidaat',
      _ => '$candidateCount komponent-kandidaati',
    };
    final selectedKey = _selectedComponentDraftKey;
    final selectionLabel = selectedKey == null
        ? 'Ühtegi kandidaati pole valitud'
        : 'Kandidaat $selectedKey valitud';
    final stylePrefix = selectedKey == null ? 'Järgmine' : 'Valitud';
    final sizePercent = (_componentCurrentSizeScale * 100).round();
    final rotationDegrees = (_componentCurrentRotation * 180 / math.pi).round();
    final styleSummary =
        '$stylePrefix: ${_componentShapeLabel(_componentCurrentShape)} · '
        '$sizePercent% · $rotationDegrees°';
    final signedRotation =
        rotationDegrees > 0 ? '+$rotationDegrees' : '$rotationDegrees';

    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.panel2,
        border: Border.all(color: _WizardPalette.edge),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            key: const ValueKey('wizard-component-status'),
            decoration: BoxDecoration(
              color: _WizardPalette.inset,
              border: Border.all(color: _WizardPalette.edge),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _buildComponentStateRow(
                        key: const ValueKey('wizard-component-count'),
                        icon: Icons.widgets_outlined,
                        label: candidateCountLabel,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildComponentStateRow(
                        key: const ValueKey('wizard-component-selection'),
                        icon: selectedKey == null
                            ? Icons.touch_app_outlined
                            : Icons.ads_click_outlined,
                        label: selectionLabel,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                _buildComponentStateRow(
                  key: const ValueKey('wizard-component-contour-guide'),
                  icon: Icons.visibility_outlined,
                  label: _contourClosed
                      ? 'Suletud kontuur on ainult visuaalne juhis'
                      : 'Kontuur pole suletud',
                ),
                const SizedBox(height: 7),
                Semantics(
                  key: const ValueKey('wizard-component-style-summary'),
                  container: true,
                  label: styleSummary,
                  child: Text(
                    styleSummary,
                    style: const TextStyle(
                      color: _WizardPalette.cream,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Kuju',
            style: TextStyle(
              color: _WizardPalette.goldDim,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Column(
            key: const ValueKey('wizard-component-shape-grid'),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildComponentShapeChoice(
                      key: const ValueKey('wizard-component-shape-circle'),
                      shape: _WizardComponentShape.circle,
                      label: 'Ümar',
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: _buildComponentShapeChoice(
                      key: const ValueKey('wizard-component-shape-square'),
                      shape: _WizardComponentShape.square,
                      label: 'Ruut',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildComponentShapeChoice(
                      key: const ValueKey('wizard-component-shape-rectangle'),
                      shape: _WizardComponentShape.rectangle,
                      label: 'Ristkülik',
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: _buildComponentShapeChoice(
                      key: const ValueKey(
                        'wizard-component-shape-rounded-rectangle',
                      ),
                      shape: _WizardComponentShape.roundedRectangle,
                      label: 'Ümardatud ristkülik',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Suurus · $sizePercent%',
            style: const TextStyle(
              color: _WizardPalette.goldDim,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          Semantics(
            label: 'Markeri suurus',
            value: '$sizePercent%',
            slider: true,
            child: Slider(
              key: const ValueKey('wizard-component-size-slider'),
              value: _componentCurrentSizeScale,
              min: 0.5,
              max: 2.5,
              divisions: 200,
              label: '$sizePercent%',
              semanticFormatterCallback: (value) => '${(value * 100).round()}%',
              onChanged: _setComponentSizeScale,
              activeColor: _WizardPalette.goldBright,
              inactiveColor: _WizardPalette.edge,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Pööre',
            style: TextStyle(
              color: _WizardPalette.goldDim,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              _buildComponentRotationControl(
                key: const ValueKey('wizard-component-rotate-minus'),
                tooltip: 'Pööra markerit 15° vasakule',
                icon: Icons.rotate_left,
                onPressed: () => _setComponentRotation(
                  _componentCurrentRotation - math.pi / 12,
                ),
              ),
              const SizedBox(width: 5),
              _buildComponentRotationControl(
                key: const ValueKey('wizard-component-rotate-plus'),
                tooltip: 'Pööra markerit 15° paremale',
                icon: Icons.rotate_right,
                onPressed: () => _setComponentRotation(
                  _componentCurrentRotation + math.pi / 12,
                ),
              ),
              const SizedBox(width: 5),
              _buildComponentRotationControl(
                key: const ValueKey('wizard-component-rotate-reset'),
                tooltip: 'Nulli markeri pööre 0°',
                icon: Icons.refresh,
                onPressed: () => _setComponentRotation(0),
              ),
              const Spacer(),
              Semantics(
                key: const ValueKey('wizard-component-rotation-value'),
                label: 'Markeri pööre: $signedRotation°',
                excludeSemantics: true,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 48),
                  decoration: BoxDecoration(
                    color: _WizardPalette.inset,
                    border: Border.all(color: _WizardPalette.edgeGold),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  child: Text(
                    '$signedRotation°',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: _WizardPalette.cream,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            key: const ValueKey('wizard-component-delete'),
            onPressed:
                selectedKey == null ? null : _deleteSelectedComponentCandidate,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Kustuta valitud kandidaat'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _WizardPalette.warningBright,
              side: const BorderSide(color: _WizardPalette.warning),
              padding: const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Tühja ala puudutus lisab kandidaadi. Valimiseks puuduta '
            'kandidaati ning liigutamiseks lohista seda. Kontuur ei piira '
            'paigutust.',
            style: TextStyle(
              color: _WizardPalette.faint,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentShapeChoice({
    required Key key,
    required _WizardComponentShape shape,
    required String label,
  }) {
    return ChoiceChip(
      key: key,
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(label),
      ),
      selected: _componentCurrentShape == shape,
      onSelected: (_) => _setComponentShape(shape),
      showCheckmark: false,
      selectedColor: _WizardPalette.activeFill,
      backgroundColor: _WizardPalette.inset,
      side: BorderSide(
        color: _componentCurrentShape == shape
            ? _WizardPalette.gold
            : _WizardPalette.edgeGold,
      ),
      labelStyle: TextStyle(
        color: _componentCurrentShape == shape
            ? _WizardPalette.goldBright
            : _WizardPalette.cream,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildComponentRotationControl({
    required Key key,
    required String tooltip,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Semantics(
      key: key,
      button: true,
      label: tooltip,
      excludeSemantics: true,
      child: IconButton.outlined(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(icon),
        color: _WizardPalette.goldBright,
      ),
    );
  }

  Widget _buildComponentStateRow({
    required Key key,
    required IconData icon,
    required String label,
  }) {
    return Row(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: _WizardPalette.goldDim, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: _WizardPalette.cream,
              fontSize: 11.5,
              height: 1.25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoAlignmentStep({required bool compact}) {
    final path = _photoPath;
    return KeyedSubtree(
      key: const ValueKey('wizard-photo-step'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 2 / ${_wizardSteps.length}',
            title: 'Foto ja joondamine',
            description:
                'Vali üks kohalik foto ja kohanda ainult selle widget-local '
                'vaadet. Samm on valikuline ega kirjuta projekti.',
            required: false,
          ),
          const SizedBox(height: 22),
          if (path == null)
            _buildPhotoEmptyState()
          else ...[
            Container(
              key: const ValueKey('wizard-photo-selected-path'),
              decoration: BoxDecoration(
                color: _WizardPalette.inset,
                border: Border.all(color: _WizardPalette.edgeGold),
                borderRadius: BorderRadius.circular(11),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 10,
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.photo_outlined,
                    color: _WizardPalette.goldDim,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      path,
                      style: const TextStyle(
                        color: _WizardPalette.cream,
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13),
            NewProjectWizardPhotoEditor(
              key: const ValueKey('wizard-photo-editor'),
              photoPath: path,
              transform: _photoTransform,
              onTranslationChanged: _setPhotoTranslation,
              onScaleChanged: _setPhotoScale,
              onRotationChanged: _setPhotoRotation,
              onOpacityChanged: _setPhotoOpacity,
              onReset: _resetPhotoView,
              onReplace: _pickPhoto,
              onRemove: _removePhoto,
              compact: compact,
            ),
          ],
          if (_photoPickerError != null) ...[
            const SizedBox(height: 12),
            Container(
              key: const ValueKey('wizard-photo-picker-error'),
              decoration: BoxDecoration(
                color: _WizardPalette.panel2,
                border: Border.all(color: _WizardPalette.warning),
                borderRadius: BorderRadius.circular(11),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: _WizardPalette.warningBright,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      _photoPickerError!,
                      style: const TextStyle(
                        color: _WizardPalette.cream,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 18),
          Container(
            key: const ValueKey('wizard-photo-boundary-note'),
            decoration: BoxDecoration(
              color: _WizardPalette.activeFill,
              border: Border.all(color: _WizardPalette.edgeGold),
              borderRadius: BorderRadius.circular(13),
            ),
            padding: const EdgeInsets.all(14),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.lock_outline,
                  color: _WizardPalette.gold,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'UI_LOCAL · ZERO_WRITE. Foto tee ja vaade püsivad ainult '
                    'selles Wizardi mustandis. Joondamine ei loo kinnitatud '
                    'fotofakti, koordinaati, sündmust ega projektifaili.',
                    style: TextStyle(
                      color: _WizardPalette.muted,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoEmptyState() {
    final supported = _canPickPhoto;
    return Container(
      key: const ValueKey('wizard-photo-empty'),
      constraints: const BoxConstraints(minHeight: 300),
      decoration: BoxDecoration(
        color: _WizardPalette.inset,
        border: Border.all(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.add_photo_alternate_outlined,
            color: _WizardPalette.goldDim,
            size: 42,
          ),
          const SizedBox(height: 13),
          const Text(
            'Foto pole valitud',
            style: TextStyle(
              color: _WizardPalette.cream,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            supported
                ? 'Toetatud vormingud: JPG, JPEG, PNG ja WEBP.'
                : 'Foto valimine pole selles v1 versioonis mobiilis ega '
                    'veebis saadaval.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _WizardPalette.muted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            key: const ValueKey('wizard-photo-pick'),
            onPressed: _isPickingPhoto ? null : _pickPhoto,
            icon: const Icon(Icons.folder_open_outlined),
            label: Text(_isPickingPhoto ? 'Valin…' : 'Vali foto'),
            style: FilledButton.styleFrom(
              backgroundColor: _WizardPalette.goldBright,
              foregroundColor: const Color(0xFF241C0A),
              disabledBackgroundColor: _WizardPalette.edge,
              disabledForegroundColor: _WizardPalette.faint,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemDescriptionStep({required bool compact}) {
    return KeyedSubtree(
      key: const ValueKey('wizard-problem-step'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 5 / ${_wizardSteps.length}',
            title: 'Probleemi kirjeldus',
            description: 'Kirjelda oma sõnadega ainult tähelepanekuid, '
                'mida ise tead. See samm ei paku diagnoosi ega loo '
                'projektiandmeid.',
            required: true,
          ),
          const SizedBox(height: 24),
          NewProjectWizardProblemDescription(
            value: _problemDescriptionDraft,
            onChanged: _handleProblemDescriptionChanged,
            compact: compact,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep({required bool compact}) {
    final photoPath = _photoPath;
    final candidateCount = _componentCandidates.length;
    final candidateCountLabel = switch (candidateCount) {
      1 => '1 visuaalne kandidaat',
      _ => '$candidateCount visuaalset kandidaati',
    };
    final contourCount = _contourPoints.length;
    final contourCountLabel =
        contourCount == 1 ? '1 punkt' : '$contourCount punkti';

    return KeyedSubtree(
      key: const ValueKey('wizard-review-summary'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 6 / ${_wizardSteps.length}',
            title: 'Kontroll ja kinnitus',
            description:
                'Kontrolli kõiki sisestatud väärtusi. Projekt luuakse alles '
                'pärast nupu „Loo projekt” vajutamist.',
            required: true,
          ),
          const SizedBox(height: 22),
          _buildReviewSection(
            title: 'Projekti andmed',
            editStep: 1,
            children: <Widget>[
              _buildReviewValue('Projekti nimi', _projectNameController.text),
              _buildReviewValue('Seadme nimetus', _deviceNameController.text),
              _buildReviewValue('Salvestuskoht', _selectedParentPath ?? ''),
              _buildReviewValue('Lisainfo', _additionalInfoController.text),
              _buildReviewValue('Seadme tüüp', _deviceTypeController.text),
              _buildReviewValue('Tootja', _manufacturerController.text),
              _buildReviewValue('Mudel', _modelController.text),
              _buildReviewValue('Revisjon', _revisionController.text),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Projekt luuakse valitud asukohta eraldi tehnilise '
                  'prj_XXXXXXXX nimega alamkaustana.',
                  style: TextStyle(
                    color: _WizardPalette.faint,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildReviewSection(
            title: 'Foto ja joondamine',
            editStep: 2,
            children: <Widget>[
              _buildReviewValue(
                'Olek',
                photoPath == null ? 'Foto pole valitud' : 'Foto valitud',
              ),
              _buildReviewValue('Lähtefail', photoPath ?? ''),
              _buildReviewValue(
                'Nihe',
                photoPath == null
                    ? ''
                    : 'x ${_formatReviewNumber(_photoTransform.translation.dx)}, '
                        'y ${_formatReviewNumber(_photoTransform.translation.dy)}',
              ),
              _buildReviewValue(
                'Skaala',
                photoPath == null
                    ? ''
                    : '${_formatReviewNumber(_photoTransform.scale)}×',
              ),
              _buildReviewValue(
                'Pööre',
                photoPath == null
                    ? ''
                    : '${_formatReviewNumber(_photoTransform.rotation)} rad',
              ),
              _buildReviewValue(
                'Läbipaistmatus',
                photoPath == null
                    ? ''
                    : '${(_photoTransform.opacity * 100).round()}%',
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildReviewSection(
            title: 'Plaadi kontuur',
            editStep: 3,
            children: <Widget>[
              _buildReviewValue(
                'Olek',
                _contourClosed ? 'Kontuur suletud' : 'Kontuur avatud',
              ),
              _buildReviewValue('Punktid', contourCountLabel),
            ],
          ),
          const SizedBox(height: 14),
          _buildReviewSection(
            title: 'Visuaalsed kandidaadid',
            editStep: 4,
            children: <Widget>[
              _buildReviewValue('Kokku', candidateCountLabel),
              for (final candidate in _componentCandidates)
                _buildReviewValue(
                  'Kandidaat #${candidate.draftKey}',
                  '${_componentShapeLabel(candidate.shape)} · '
                      '${(candidate.sizeScale * 100).round()}% · '
                      '${_formatReviewNumber(candidate.rotation)} rad',
                ),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Kandidaadid on inimese loodud visuaalsed ettepanekud. '
                  'Need ei kinnita komponendi identiteeti, tüüpi, väärtust, '
                  'tähist, korpust, jalajälge, jalgu, kontakte, plaadipoolt, '
                  'ühendusi, võrku, mõõtmist ega diagnoosi ning ei loo '
                  'püsivat ega kanoonilist fakti.',
                  style: TextStyle(
                    color: _WizardPalette.faint,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildReviewSection(
            title: 'Probleemi kirjeldus',
            editStep: 5,
            children: <Widget>[
              _buildReviewValue(
                'Kirjeldus',
                _problemDescriptionDraft.description,
              ),
              _buildReviewValue(
                'Esinemine',
                _problemOccurrenceLabel(_problemDescriptionDraft.occurrence),
              ),
              _buildReviewValue(
                'Millal esineb',
                _problemDescriptionDraft.whenOccurs,
              ),
              _buildReviewValue(
                'Sümptomid',
                _problemDescriptionDraft.symptoms,
              ),
              _buildReviewValue(
                'Proovitud toimingud',
                _problemDescriptionDraft.attempts,
              ),
            ],
          ),
          if (_creationStatus == _WizardCreationStatus.creating) ...[
            const SizedBox(height: 18),
            const _WizardCreationProgress(),
          ],
          if (_creationError != null) ...[
            const SizedBox(height: 18),
            _WizardCreationError(message: _creationError!),
          ],
          if (compact) const SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildReviewSection({
    required String title,
    required int editStep,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.panel2,
        border: Border.all(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _WizardPalette.gold,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                key: ValueKey('wizard-review-edit-step-$editStep'),
                onPressed: _creationStatus == _WizardCreationStatus.creating
                    ? null
                    : () => _editReviewStep(editStep - 1),
                icon: const Icon(Icons.edit_outlined, size: 17),
                label: const Text('Muuda'),
                style: TextButton.styleFrom(
                  foregroundColor: _WizardPalette.gold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildReviewValue(String label, String value) {
    final displayValue = value.trim().isEmpty ? '—' : value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final labelWidget = Text(
            label,
            style: const TextStyle(
              color: _WizardPalette.muted,
              fontWeight: FontWeight.w600,
            ),
          );
          final valueWidget = Text(
            displayValue,
            style: const TextStyle(
              color: _WizardPalette.cream,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          );
          if (constraints.maxWidth < 520) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                labelWidget,
                const SizedBox(height: 3),
                valueWidget,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 170, child: labelWidget),
              const SizedBox(width: 12),
              Expanded(child: valueWidget),
            ],
          );
        },
      ),
    );
  }

  String _formatReviewNumber(double value) {
    final fixed = value.toStringAsFixed(3);
    return fixed.replaceFirst(RegExp(r'\.?0+$'), '');
  }

  String _problemOccurrenceLabel(
    NewProjectWizardProblemOccurrence occurrence,
  ) {
    return switch (occurrence) {
      NewProjectWizardProblemOccurrence.unknown => 'Teadmata',
      NewProjectWizardProblemOccurrence.continuous => 'Pidev',
      NewProjectWizardProblemOccurrence.intermittent => 'Vahelduv',
    };
  }

  Widget _buildCreatedStep({required bool compact}) {
    final projectState = _createdProjectState;
    if (projectState == null) {
      return const SizedBox.shrink();
    }
    final projectName = projectState.manifest.projectName ?? '';
    final projectId = projectState.manifest.projectId;
    final projectDirectory = projectState.projectDirectory ?? '';

    return KeyedSubtree(
      key: const ValueKey('wizard-created-success'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 7 / ${_wizardSteps.length}',
            title: 'Projekt loodud',
            description:
                'Projekt on edukalt loodud. Ava see eraldi toiminguga, kui '
                'oled valmis töölauale minema.',
            required: true,
          ),
          const SizedBox(height: 26),
          Container(
            decoration: BoxDecoration(
              color: _WizardPalette.activeFill,
              border: Border.all(color: _WizardPalette.ready, width: 1.4),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(compact ? 18 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: _WizardPalette.ready,
                  size: 48,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Projekt on valmis',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _WizardPalette.cream,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 22),
                _buildCreatedValue(
                  key: const ValueKey('wizard-created-project-name'),
                  label: 'Projekti nimi',
                  value: projectName,
                ),
                const SizedBox(height: 10),
                _buildCreatedValue(
                  key: const ValueKey('wizard-created-project-id'),
                  label: 'Tehniline projekti ID',
                  value: projectId,
                ),
                const SizedBox(height: 10),
                _buildCreatedValue(
                  key: const ValueKey('wizard-created-project-location'),
                  label: 'Projekti asukoht',
                  value: projectDirectory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatedValue({
    required Key key,
    required String label,
    required String value,
  }) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: _WizardPalette.inset,
        border: Border.all(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(11),
      ),
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: _WizardPalette.muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.trim().isEmpty ? '—' : value,
            style: const TextStyle(
              color: _WizardPalette.cream,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepHeading({
    required String eyebrow,
    required String title,
    required String description,
    required bool required,
    bool dense = false,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final copy = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              eyebrow,
              style: const TextStyle(
                color: _WizardPalette.gold,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: dense ? 5 : 8),
            Text(
              title,
              key: const ValueKey('wizard-step-title'),
              style: TextStyle(
                color: _WizardPalette.cream,
                fontSize: dense ? 25 : 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: dense ? 5 : 8),
            Text(
              description,
              style: TextStyle(
                color: _WizardPalette.muted,
                fontSize: dense ? 13.5 : 14.5,
                height: dense ? 1.35 : 1.5,
              ),
            ),
          ],
        );
        final badge = _WizardPill(
          label: required ? 'Kohustuslik' : 'Valikuline',
        );
        if (constraints.maxWidth < 560) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              copy,
              SizedBox(height: dense ? 8 : 12),
              badge,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: copy),
            const SizedBox(width: 16),
            badge,
          ],
        );
      },
    );
  }

  Widget _buildFieldLabel(String label, {bool required = false}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 5,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _WizardPalette.cream,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (required)
          const Text(
            '* nõutav',
            style: TextStyle(
              color: _WizardPalette.gold,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        else
          const _WizardPill(label: 'valikuline', compact: true),
      ],
    );
  }

  Widget _buildFolderPicker() {
    final path = _selectedParentPath;
    final pathDisplay = Container(
      key: const ValueKey('wizard-selected-parent-path'),
      constraints: const BoxConstraints(minHeight: 52),
      decoration: BoxDecoration(
        color: _WizardPalette.inset,
        border: Border.all(
          color: path == null ? _WizardPalette.edge : _WizardPalette.edgeGold,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(
        children: <Widget>[
          Icon(
            path == null ? Icons.folder_outlined : Icons.folder_open_outlined,
            color: path == null ? _WizardPalette.faint : _WizardPalette.goldDim,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              path ?? 'Asukoht valimata',
              style: TextStyle(
                color:
                    path == null ? _WizardPalette.faint : _WizardPalette.cream,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
    final pickerButton = OutlinedButton.icon(
      key: const ValueKey('wizard-pick-folder'),
      onPressed: _isPickingFolder ? null : _pickFolder,
      icon: const Icon(Icons.create_new_folder_outlined),
      label: Text(_isPickingFolder ? 'Valin…' : 'Vali kaust'),
      style: OutlinedButton.styleFrom(
        foregroundColor: _WizardPalette.gold,
        side: const BorderSide(color: _WizardPalette.edgeGold),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 560) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  pathDisplay,
                  const SizedBox(height: 10),
                  pickerButton,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: pathDisplay),
                const SizedBox(width: 10),
                pickerButton,
              ],
            );
          },
        ),
        if (path != null) ...[
          const SizedBox(height: 8),
          const Text(
            'Valitud tee on valideerimata widget-local mustand.',
            style: TextStyle(
              color: _WizardPalette.faint,
              fontSize: 12.5,
            ),
          ),
        ],
      ],
    );
  }

  InputDecoration _inputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: _WizardPalette.faint),
      filled: true,
      fillColor: _WizardPalette.inset,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(11),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: _WizardPalette.gold,
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
    );
  }

  Widget _buildActionBar({required bool compact}) {
    final canGoNext = switch (_currentStep) {
      0 => _canAdvanceFromStepOne,
      2 => _canAdvanceFromContour,
      4 => _canAdvanceFromProblemDescription,
      _ => _currentStep >= 0 && _currentStep < 5,
    };
    final back = _currentStep == 0 || _currentStep == 6
        ? null
        : OutlinedButton.icon(
            key: const ValueKey('wizard-back'),
            onPressed: _creationStatus == _WizardCreationStatus.creating
                ? null
                : _goBack,
            icon: const Icon(Icons.chevron_left),
            label: const Text('Tagasi'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _WizardPalette.cream,
              side: const BorderSide(color: _WizardPalette.edgeGold),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
            ),
          );
    final next = _currentStep >= 5
        ? null
        : FilledButton.icon(
            key: const ValueKey('wizard-next'),
            onPressed: canGoNext ? _goNext : null,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.chevron_right),
            label: const Text('Edasi'),
            style: FilledButton.styleFrom(
              backgroundColor: _WizardPalette.goldBright,
              foregroundColor: const Color(0xFF241C0A),
              disabledBackgroundColor: _WizardPalette.edge,
              disabledForegroundColor: _WizardPalette.faint,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w800),
            ),
          );
    final create = _currentStep == 5
        ? FilledButton.icon(
            key: const ValueKey('wizard-create-project-button'),
            onPressed: _creationStatus == _WizardCreationStatus.creating ||
                    !_allCreationGatesAreValid
                ? null
                : _createProject,
            icon: _creationStatus == _WizardCreationStatus.creating
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.create_new_folder_outlined),
            label: Text(
              _creationStatus == _WizardCreationStatus.creating
                  ? 'Loon projekti…'
                  : 'Loo projekt',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: _WizardPalette.goldBright,
              foregroundColor: const Color(0xFF241C0A),
              disabledBackgroundColor: _WizardPalette.edge,
              disabledForegroundColor: _WizardPalette.faint,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w800),
            ),
          )
        : null;
    final openProject = _currentStep == 6
        ? FilledButton.icon(
            key: const ValueKey('wizard-open-project-button'),
            onPressed: _openCreatedProject,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Ava projekt'),
            style: FilledButton.styleFrom(
              backgroundColor: _WizardPalette.goldBright,
              foregroundColor: const Color(0xFF241C0A),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w800),
            ),
          )
        : null;
    final primaryAction = next ?? create ?? openProject;

    return Container(
      decoration: const BoxDecoration(
        color: _WizardPalette.panel2,
        border: Border(
          top: BorderSide(color: _WizardPalette.edge),
        ),
      ),
      padding: EdgeInsets.all(compact ? 14 : 18),
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (back != null) back,
                if (back != null && primaryAction != null)
                  const SizedBox(height: 10),
                if (primaryAction != null) primaryAction,
              ],
            )
          : Row(
              children: <Widget>[
                if (back != null) back,
                const Spacer(),
                if (primaryAction != null) primaryAction,
              ],
            ),
    );
  }
}

class _WizardContourPainter extends CustomPainter {
  const _WizardContourPainter({
    required this.points,
    required this.selectedIndex,
    required this.closed,
  });

  final List<Offset> points;
  final int? selectedIndex;
  final bool closed;

  Offset _onCanvas(Offset point, Size size) {
    return Offset(point.dx * size.width, point.dy * size.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = _WizardPalette.edge.withValues(alpha: 0.42)
      ..strokeWidth = 1;
    for (var division = 1; division < 10; division += 1) {
      final x = size.width * division / 10;
      final y = size.height * division / 10;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    if (points.length >= 2) {
      final path = Path()
        ..moveTo(
          _onCanvas(points.first, size).dx,
          _onCanvas(points.first, size).dy,
        );
      for (final point in points.skip(1)) {
        final canvasPoint = _onCanvas(point, size);
        path.lineTo(canvasPoint.dx, canvasPoint.dy);
      }
      if (closed && points.length >= 3) {
        path.close();
        canvas.drawPath(
          path,
          Paint()
            ..color = _WizardPalette.gold.withValues(alpha: 0.12)
            ..style = PaintingStyle.fill,
        );
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = closed ? _WizardPalette.ready : _WizardPalette.goldBright
          ..style = PaintingStyle.stroke
          ..strokeWidth = closed ? 3 : 2.4
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round,
      );
    }

    for (var index = 0; index < points.length; index += 1) {
      final canvasPoint = _onCanvas(points[index], size);
      final selected = selectedIndex == index;
      if (selected) {
        canvas.drawCircle(
          canvasPoint,
          13,
          Paint()
            ..color = _WizardPalette.gold.withValues(alpha: 0.22)
            ..style = PaintingStyle.fill,
        );
        canvas.drawCircle(
          canvasPoint,
          12,
          Paint()
            ..color = _WizardPalette.gold
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      }
      canvas.drawCircle(
        canvasPoint,
        8,
        Paint()
          ..color = selected ? _WizardPalette.goldBright : _WizardPalette.cream
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        canvasPoint,
        8,
        Paint()
          ..color = _WizardPalette.background
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );

      final label = TextPainter(
        text: TextSpan(
          text: '${index + 1}',
          style: const TextStyle(
            color: _WizardPalette.background,
            fontSize: 9,
            fontWeight: FontWeight.w900,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(
        canvas,
        canvasPoint - Offset(label.width / 2, label.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WizardContourPainter oldDelegate) {
    if (oldDelegate.closed != closed ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.points.length != points.length) {
      return true;
    }
    for (var index = 0; index < points.length; index += 1) {
      if (oldDelegate.points[index] != points[index]) {
        return true;
      }
    }
    return false;
  }
}

enum _WizardComponentShape {
  circle,
  square,
  rectangle,
  roundedRectangle,
}

class _WizardComponentCandidate {
  factory _WizardComponentCandidate({
    required int draftKey,
    required Offset position,
    _WizardComponentShape shape = _WizardComponentShape.circle,
    double sizeScale = 1.0,
    double rotation = 0.0,
  }) {
    return _WizardComponentCandidate._(
      draftKey: draftKey,
      position: position,
      shape: shape,
      sizeScale: _normalizedSizeScale(sizeScale, fallback: 1.0),
      rotation: _normalizedRotation(rotation, fallback: 0.0),
    );
  }

  const _WizardComponentCandidate._({
    required this.draftKey,
    required this.position,
    required this.shape,
    required this.sizeScale,
    required this.rotation,
  });

  final int draftKey;
  final Offset position;
  final _WizardComponentShape shape;
  final double sizeScale;
  final double rotation;

  static double _normalizedSizeScale(
    double value, {
    required double fallback,
  }) {
    if (!value.isFinite) {
      return fallback;
    }
    return value.clamp(0.5, 2.5).toDouble();
  }

  static double _normalizedRotation(
    double value, {
    required double fallback,
  }) {
    if (!value.isFinite) {
      return fallback;
    }
    const fullTurn = 2 * math.pi;
    final normalized = (value + math.pi) % fullTurn - math.pi;
    return normalized == -0.0 ? 0.0 : normalized;
  }

  _WizardComponentCandidate copyWith({
    Offset? position,
    _WizardComponentShape? shape,
    double? sizeScale,
    double? rotation,
  }) {
    return _WizardComponentCandidate._(
      draftKey: draftKey,
      position: position ?? this.position,
      shape: shape ?? this.shape,
      sizeScale: sizeScale == null
          ? this.sizeScale
          : _normalizedSizeScale(sizeScale, fallback: this.sizeScale),
      rotation: rotation == null
          ? this.rotation
          : _normalizedRotation(rotation, fallback: this.rotation),
    );
  }

  _WizardComponentCandidate movedTo(Offset nextPosition) {
    return copyWith(position: nextPosition);
  }
}

class _WizardComponentPlacementPainter extends CustomPainter {
  const _WizardComponentPlacementPainter({
    required this.guideContourPoints,
    required this.guideClosed,
    required this.candidates,
    required this.selectedDraftKey,
  });

  final List<Offset> guideContourPoints;
  final bool guideClosed;
  final List<_WizardComponentCandidate> candidates;
  final int? selectedDraftKey;

  Offset _onCanvas(Offset point, Size size) {
    return Offset(point.dx * size.width, point.dy * size.height);
  }

  Iterable<_WizardComponentMarkerGeometry> markerGeometries(Size size) sync* {
    for (final candidate in candidates) {
      yield _WizardComponentMarkerGeometry.fromCandidate(candidate, size);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (guideClosed && guideContourPoints.length >= 3) {
      final path = Path();
      final first = _onCanvas(guideContourPoints.first, size);
      path.moveTo(first.dx, first.dy);
      for (final point in guideContourPoints.skip(1)) {
        final canvasPoint = _onCanvas(point, size);
        path.lineTo(canvasPoint.dx, canvasPoint.dy);
      }
      path.close();
      canvas.drawPath(
        path,
        Paint()
          ..color = _WizardPalette.gold.withValues(alpha: 0.07)
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = _WizardPalette.goldDim.withValues(alpha: 0.72)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round,
      );
    }

    for (final geometry in markerGeometries(size)) {
      final selected = geometry.draftKey == selectedDraftKey;
      canvas.save();
      canvas.translate(geometry.centre.dx, geometry.centre.dy);
      canvas.rotate(geometry.effectiveRotation);
      if (selected) {
        canvas.drawPath(
          geometry.localPath,
          Paint()
            ..color = _WizardPalette.gold.withValues(alpha: 0.72)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5
            ..strokeJoin = StrokeJoin.round,
        );
      }
      canvas.drawPath(
        geometry.localPath,
        Paint()
          ..color = selected ? _WizardPalette.goldBright : _WizardPalette.cream
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        geometry.localPath,
        Paint()
          ..color = _WizardPalette.background
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..strokeJoin = StrokeJoin.round,
      );
      final markerArm = math.max(2.0, geometry.minorDimension * 0.28);
      final markerPaint = Paint()
        ..color = _WizardPalette.background
        ..strokeWidth = math.max(1.2, geometry.minorDimension * 0.1)
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset(-markerArm, 0),
        Offset(markerArm, 0),
        markerPaint,
      );
      canvas.drawLine(
        Offset(0, -markerArm),
        Offset(0, markerArm),
        markerPaint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _WizardComponentPlacementPainter oldDelegate) {
    if (oldDelegate.guideClosed != guideClosed ||
        oldDelegate.selectedDraftKey != selectedDraftKey ||
        oldDelegate.guideContourPoints.length != guideContourPoints.length ||
        oldDelegate.candidates.length != candidates.length) {
      return true;
    }
    for (var index = 0; index < guideContourPoints.length; index += 1) {
      if (oldDelegate.guideContourPoints[index] != guideContourPoints[index]) {
        return true;
      }
    }
    for (var index = 0; index < candidates.length; index += 1) {
      final candidate = candidates[index];
      final oldCandidate = oldDelegate.candidates[index];
      if (oldCandidate.draftKey != candidate.draftKey ||
          oldCandidate.position != candidate.position ||
          oldCandidate.shape != candidate.shape ||
          oldCandidate.sizeScale != candidate.sizeScale ||
          oldCandidate.rotation != candidate.rotation) {
        return true;
      }
    }
    return false;
  }
}

class _WizardComponentMarkerGeometry {
  const _WizardComponentMarkerGeometry._({
    required this.draftKey,
    required this.centre,
    required this.minorDimension,
    required this.markerSize,
    required this.effectiveRotation,
    required this.localPath,
    required this.rotatedBounds,
    required this.hitBounds,
  });

  factory _WizardComponentMarkerGeometry.fromCandidate(
    _WizardComponentCandidate candidate,
    Size canvasSize,
  ) {
    final shortestSide = canvasSize.shortestSide;
    final relativeMinor = shortestSide.isFinite
        ? shortestSide * 0.035 * candidate.sizeScale
        : 0.0;
    final minorDimension = math.max(8.0, relativeMinor);
    final aspectRatio = switch (candidate.shape) {
      _WizardComponentShape.circle => 1.0,
      _WizardComponentShape.square => 1.0,
      _WizardComponentShape.rectangle => 1.8,
      _WizardComponentShape.roundedRectangle => 2.2,
    };
    final markerSize = Size(minorDimension * aspectRatio, minorDimension);
    final localRect = Rect.fromCenter(
      center: Offset.zero,
      width: markerSize.width,
      height: markerSize.height,
    );
    final localPath = switch (candidate.shape) {
      _WizardComponentShape.circle => Path()..addOval(localRect),
      _WizardComponentShape.square || _WizardComponentShape.rectangle => Path()
        ..addRect(localRect),
      _WizardComponentShape.roundedRectangle => Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            localRect,
            Radius.circular(minorDimension * 0.32),
          ),
        ),
    };
    final effectiveRotation = candidate.shape == _WizardComponentShape.circle
        ? 0.0
        : candidate.rotation;
    final cosine = math.cos(effectiveRotation).abs();
    final sine = math.sin(effectiveRotation).abs();
    final rotatedWidth = markerSize.width * cosine + markerSize.height * sine;
    final rotatedHeight = markerSize.width * sine + markerSize.height * cosine;
    final centre = Offset(
      candidate.position.dx * canvasSize.width,
      candidate.position.dy * canvasSize.height,
    );
    final rotatedBounds = Rect.fromCenter(
      center: centre,
      width: rotatedWidth,
      height: rotatedHeight,
    );
    final hitBounds = Rect.fromCenter(
      center: centre,
      width: math.max(56.0, rotatedWidth),
      height: math.max(56.0, rotatedHeight),
    );
    return _WizardComponentMarkerGeometry._(
      draftKey: candidate.draftKey,
      centre: centre,
      minorDimension: minorDimension,
      markerSize: markerSize,
      effectiveRotation: effectiveRotation,
      localPath: localPath,
      rotatedBounds: rotatedBounds,
      hitBounds: hitBounds,
    );
  }

  final int draftKey;
  final Offset centre;
  final double minorDimension;
  final Size markerSize;
  final double effectiveRotation;
  final Path localPath;
  final Rect rotatedBounds;
  final Rect hitBounds;
}

class _WizardCreationProgress extends StatelessWidget {
  const _WizardCreationProgress();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: const ValueKey('wizard-creation-progress'),
      container: true,
      liveRegion: true,
      label: 'Projekti loomine on pooleli.',
      child: Container(
        decoration: BoxDecoration(
          color: _WizardPalette.activeFill,
          border: Border.all(color: _WizardPalette.edgeGold),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(14),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LinearProgressIndicator(
              color: _WizardPalette.goldBright,
              backgroundColor: _WizardPalette.edge,
            ),
            SizedBox(height: 10),
            Text(
              'Loon projekti…',
              style: TextStyle(
                color: _WizardPalette.cream,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WizardCreationError extends StatelessWidget {
  const _WizardCreationError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: const ValueKey('wizard-creation-error'),
      container: true,
      liveRegion: true,
      label: message,
      child: Container(
        decoration: BoxDecoration(
          color: _WizardPalette.warning.withValues(alpha: 0.12),
          border: Border.all(color: _WizardPalette.warning),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(
              Icons.error_outline,
              color: _WizardPalette.warningBright,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: _WizardPalette.cream,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WizardSafetyCard extends StatelessWidget {
  const _WizardSafetyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.activeFill,
        border: Border.all(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(18),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.lock_outline,
                color: _WizardPalette.gold,
                size: 20,
              ),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Turvaline loomine',
                  style: TextStyle(
                    color: _WizardPalette.gold,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Projekt luuakse alles pärast andmete kontrollimist ja kinnitamist.',
            style: TextStyle(
              color: _WizardPalette.cream,
              fontWeight: FontWeight.w700,
              height: 1.45,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Salvestuskoha valimine ei loo kausta ega faili.',
            style: TextStyle(
              color: _WizardPalette.muted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _WizardPill extends StatelessWidget {
  const _WizardPill({
    required this.label,
    this.compact = false,
  });

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.activeFill,
        border: Border.all(color: _WizardPalette.edgeGold),
        borderRadius: BorderRadius.circular(999),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 11,
        vertical: compact ? 3 : 6,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _WizardPalette.goldDim,
          fontSize: compact ? 10.5 : 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _WizardStepDefinition {
  const _WizardStepDefinition({
    required this.label,
    required this.detail,
    required this.icon,
  });

  final String label;
  final String detail;
  final IconData icon;
}

abstract final class _WizardPalette {
  static const Color background = Color(0xFF0C0C0C);
  static const Color panel = Color(0xFF1A1916);
  static const Color panel2 = Color(0xFF141310);
  static const Color inset = Color(0xFF0A0A0A);
  static const Color edge = Color(0xFF332E22);
  static const Color edgeGold = Color(0xFF6B5A30);
  static const Color frame = Color(0xFF8A7338);
  static const Color gold = Color(0xFFE7C25A);
  static const Color goldBright = Color(0xFFF0CF6A);
  static const Color goldDim = Color(0xFFCDA64C);
  static const Color cream = Color(0xFFF3ECDC);
  static const Color muted = Color(0xFFA89F8C);
  static const Color faint = Color(0xFF7E776A);
  static const Color ready = Color(0xFF6FCF97);
  static const Color warning = Color(0xFFE08A55);
  static const Color warningBright = Color(0xFFF0A268);
  static const Color activeFill = Color(0x17E7C25A);
}
