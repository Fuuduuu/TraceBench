import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/python_runner.dart';

const List<_WizardStepDefinition> _wizardSteps = <_WizardStepDefinition>[
  _WizardStepDefinition(
    label: 'Projekti andmed',
    detail: 'nimi ja salvestuskoht',
    icon: Icons.description_outlined,
  ),
  _WizardStepDefinition(
    label: 'Plaadi kontuur',
    detail: 'nähtav, funktsioon tulekul',
    icon: Icons.gesture_outlined,
  ),
  _WizardStepDefinition(
    label: 'Komponentide asetus',
    detail: 'nähtav, funktsioon tulekul',
    icon: Icons.location_on_outlined,
  ),
  _WizardStepDefinition(
    label: 'Probleemi kirjeldus',
    detail: 'nähtav, funktsioon tulekul',
    icon: Icons.notes_outlined,
  ),
  _WizardStepDefinition(
    label: 'Kontroll ja kinnitus',
    detail: 'nähtav, funktsioon tulekul',
    icon: Icons.verified_user_outlined,
  ),
  _WizardStepDefinition(
    label: 'Kokkuvõte',
    detail: 'loomine pole selles passis',
    icon: Icons.fact_check_outlined,
  ),
];

class NewProjectWizardScreen extends StatefulWidget {
  const NewProjectWizardScreen({
    super.key,
    this.directoryPicker,
    this.platformInfo,
  });

  final Future<String?> Function()? directoryPicker;
  final PlatformInfo? platformInfo;

  @override
  State<NewProjectWizardScreen> createState() => _NewProjectWizardScreenState();
}

class _NewProjectWizardScreenState extends State<NewProjectWizardScreen> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  String? _selectedParentPath;
  int _currentStep = 0;
  bool _draftTouched = false;
  bool _isPickingFolder = false;

  bool get _isMobile {
    final info = widget.platformInfo ?? const DefaultPlatformInfo();
    return info.isMobile;
  }

  bool get _canAdvanceFromStepOne {
    return _projectNameController.text.trim().isNotEmpty &&
        (_selectedParentPath?.trim().isNotEmpty ?? false);
  }

  void _handleDraftTextChanged(String _) {
    setState(() {
      _draftTouched = true;
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

  void _goNext() {
    if (_currentStep == 0 && !_canAdvanceFromStepOne) {
      return;
    }
    if (_currentStep >= _wizardSteps.length - 1) {
      return;
    }
    setState(() {
      _currentStep += 1;
    });
  }

  void _goBack() {
    if (_currentStep == 0) {
      return;
    }
    setState(() {
      _currentStep -= 1;
    });
  }

  Future<void> _cancelWizard() async {
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
    final cancel = TextButton.icon(
      key: const ValueKey('wizard-cancel'),
      onPressed: _cancelWizard,
      icon: const Icon(Icons.close),
      label: const Text('Katkesta'),
      style: TextButton.styleFrom(
        foregroundColor: _WizardPalette.warningBright,
        side: const BorderSide(color: _WizardPalette.warning),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerLeft, child: cancel),
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
              const SizedBox(width: 12),
              cancel,
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
          const Text(
            'Kuus sammu',
            style: TextStyle(
              color: _WizardPalette.cream,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Navigeeri Edasi ja Tagasi nuppudega. Mustand püsib ainult '
            'selles vaates.',
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
    final isComplete = index == 0 && index < _currentStep;
    final isViewed = index > 0 && index < _currentStep;
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
      label: 'Samm ${index + 1}: ${step.label}. $status.',
      child: Container(
        key: ValueKey('wizard-progress-step-${index + 1}'),
        decoration: BoxDecoration(
          color: isCurrent ? _WizardPalette.activeFill : _WizardPalette.panel2,
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
            child: _currentStep == 0
                ? _buildStepOne(compact: compact)
                : _buildPlaceholder(_currentStep),
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
      ],
    );
    const safety = _WizardSafetyCard();

    return KeyedSubtree(
      key: const ValueKey('wizard-step-1-editor'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm 1 / 6',
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

  Widget _buildPlaceholder(int index) {
    final step = _wizardSteps[index];
    final isSummary = index == _wizardSteps.length - 1;
    final description = isSummary
        ? 'Selles vundamendis puudub projekti loomise toiming. '
            'Ühtegi kausta, faili ega projekti olekut ei kirjutata.'
        : 'See samm on shellis nähtav, kuid selle funktsionaalne sisu ei '
            'kuulu sellesse vundamendipassi.';

    return Container(
      key: ValueKey('wizard-placeholder-${index + 1}'),
      constraints: const BoxConstraints(minHeight: 430),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildStepHeading(
            eyebrow: 'Samm ${index + 1} / ${_wizardSteps.length}',
            title: step.label,
            description: step.detail,
            required: index == 1 || index >= 4,
          ),
          const SizedBox(height: 32),
          _WizardPlaceholder(
            icon: step.icon,
            description: description,
            summary: isSummary,
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
            const SizedBox(height: 8),
            Text(
              title,
              key: const ValueKey('wizard-step-title'),
              style: const TextStyle(
                color: _WizardPalette.cream,
                fontSize: 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: _WizardPalette.muted,
                fontSize: 14.5,
                height: 1.5,
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
              const SizedBox(height: 12),
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
    final canGoNext =
        _currentStep == 0 ? _canAdvanceFromStepOne : _currentStep < 5;
    final back = _currentStep == 0
        ? null
        : OutlinedButton.icon(
            key: const ValueKey('wizard-back'),
            onPressed: _goBack,
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
    final next = _currentStep >= _wizardSteps.length - 1
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
    final finalCopy = _currentStep == _wizardSteps.length - 1
        ? const Text(
            'Lõplik loomine vajab hilisemat eraldi integratsioonipassi.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _WizardPalette.faint,
              fontSize: 12.5,
            ),
          )
        : null;

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
                if (back != null && (next != null || finalCopy != null))
                  const SizedBox(height: 10),
                if (next != null) next,
                if (finalCopy != null) finalCopy,
              ],
            )
          : Row(
              children: <Widget>[
                if (back != null) back,
                const Spacer(),
                if (finalCopy != null) ...[
                  Flexible(child: finalCopy),
                  const SizedBox(width: 16),
                ],
                if (next != null) next,
              ],
            ),
    );
  }
}

class _WizardPlaceholder extends StatelessWidget {
  const _WizardPlaceholder({
    required this.icon,
    required this.description,
    required this.summary,
  });

  final IconData icon;
  final String description;
  final bool summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WizardPalette.inset,
        border: Border.all(
          color: _WizardPalette.edgeGold,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: _WizardPalette.activeFill,
              border: Border.all(color: _WizardPalette.edgeGold),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: _WizardPalette.gold, size: 34),
          ),
          const SizedBox(height: 20),
          const _WizardPill(label: 'Tulekul'),
          const SizedBox(height: 18),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _WizardPalette.muted,
              fontSize: 15,
              height: 1.55,
            ),
          ),
          if (summary) ...[
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.lock_outline,
                  color: _WizardPalette.faint,
                  size: 17,
                ),
                SizedBox(width: 7),
                Flexible(
                  child: Text(
                    'ZERO_WRITE · ainult widget-local mustand',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _WizardPalette.faint,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
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
                  'Turvaline mustand',
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
            'Lõplik projekti loomine ei ole selles wizardis veel rakendatud.',
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
