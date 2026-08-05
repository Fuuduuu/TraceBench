import 'package:flutter/material.dart';

import 'wizard_compact_tokens.dart';
import 'wizard_compact_widgets.dart';

enum NewProjectWizardProblemOccurrence {
  unknown,
  continuous,
  intermittent,
}

@immutable
class NewProjectWizardProblemDescriptionDraft {
  const NewProjectWizardProblemDescriptionDraft({
    this.description = '',
    this.occurrence = NewProjectWizardProblemOccurrence.unknown,
    this.whenOccurs = '',
    this.symptoms = '',
    this.attempts = '',
  });

  final String description;
  final NewProjectWizardProblemOccurrence occurrence;
  final String whenOccurs;
  final String symptoms;
  final String attempts;

  NewProjectWizardProblemDescriptionDraft copyWith({
    String? description,
    NewProjectWizardProblemOccurrence? occurrence,
    String? whenOccurs,
    String? symptoms,
    String? attempts,
  }) {
    final nextDescription = description ?? this.description;
    final nextOccurrence = occurrence ?? this.occurrence;
    final nextWhenOccurs = whenOccurs ?? this.whenOccurs;
    final nextSymptoms = symptoms ?? this.symptoms;
    final nextAttempts = attempts ?? this.attempts;
    if (nextDescription == this.description &&
        nextOccurrence == this.occurrence &&
        nextWhenOccurs == this.whenOccurs &&
        nextSymptoms == this.symptoms &&
        nextAttempts == this.attempts) {
      return this;
    }
    return NewProjectWizardProblemDescriptionDraft(
      description: nextDescription,
      occurrence: nextOccurrence,
      whenOccurs: nextWhenOccurs,
      symptoms: nextSymptoms,
      attempts: nextAttempts,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NewProjectWizardProblemDescriptionDraft &&
            description == other.description &&
            occurrence == other.occurrence &&
            whenOccurs == other.whenOccurs &&
            symptoms == other.symptoms &&
            attempts == other.attempts;
  }

  @override
  int get hashCode => Object.hash(
        description,
        occurrence,
        whenOccurs,
        symptoms,
        attempts,
      );
}

class NewProjectWizardProblemDescription extends StatefulWidget {
  const NewProjectWizardProblemDescription({
    super.key,
    required this.value,
    required this.onChanged,
    required this.compact,
  });

  final NewProjectWizardProblemDescriptionDraft value;
  final ValueChanged<NewProjectWizardProblemDescriptionDraft> onChanged;
  final bool compact;

  @override
  State<NewProjectWizardProblemDescription> createState() =>
      _NewProjectWizardProblemDescriptionState();
}

class _NewProjectWizardProblemDescriptionState
    extends State<NewProjectWizardProblemDescription> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _whenController;
  late final TextEditingController _symptomsController;
  late final TextEditingController _attemptsController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(
      text: widget.value.description,
    );
    _whenController = TextEditingController(text: widget.value.whenOccurs);
    _symptomsController = TextEditingController(text: widget.value.symptoms);
    _attemptsController = TextEditingController(text: widget.value.attempts);
  }

  @override
  void didUpdateWidget(covariant NewProjectWizardProblemDescription oldWidget) {
    super.didUpdateWidget(oldWidget);
    _synchronizeController(_descriptionController, widget.value.description);
    _synchronizeController(_whenController, widget.value.whenOccurs);
    _synchronizeController(_symptomsController, widget.value.symptoms);
    _synchronizeController(_attemptsController, widget.value.attempts);
  }

  void _synchronizeController(
    TextEditingController controller,
    String incoming,
  ) {
    if (controller.text == incoming) {
      return;
    }
    controller.value = TextEditingValue(
      text: incoming,
      selection: TextSelection.collapsed(offset: incoming.length),
    );
  }

  void _changeDescription(String description) {
    if (description == widget.value.description) {
      return;
    }
    widget.onChanged(widget.value.copyWith(description: description));
  }

  void _changeWhenOccurs(String whenOccurs) {
    if (whenOccurs == widget.value.whenOccurs) {
      return;
    }
    widget.onChanged(widget.value.copyWith(whenOccurs: whenOccurs));
  }

  void _changeSymptoms(String symptoms) {
    if (symptoms == widget.value.symptoms) {
      return;
    }
    widget.onChanged(widget.value.copyWith(symptoms: symptoms));
  }

  void _changeAttempts(String attempts) {
    if (attempts == widget.value.attempts) {
      return;
    }
    widget.onChanged(widget.value.copyWith(attempts: attempts));
  }

  void _changeOccurrence(NewProjectWizardProblemOccurrence occurrence) {
    if (occurrence == widget.value.occurrence) {
      return;
    }
    widget.onChanged(widget.value.copyWith(occurrence: occurrence));
  }

  Widget _buildField({
    required String label,
    required String semanticsLabel,
    required String keyName,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required bool required,
    String? hintText,
  }) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: semanticsLabel,
      textField: true,
      child: WizardCompactFieldSection(
        label: label,
        requiredField: required,
        child: TextField(
          key: ValueKey<String>(keyName),
          controller: controller,
          onChanged: onChanged,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: required ? 4 : 3,
          maxLines: required ? 7 : 5,
          style: WizardCompactTokens.bodyStyle(),
          decoration: WizardCompactTokens.inputDecoration(
            hintText: hintText,
          ),
        ),
      ),
    );
  }

  Widget _buildOccurrence() {
    return WizardCompactTileSelector<NewProjectWizardProblemOccurrence>(
      key: const ValueKey('wizard-problem-occurrence-grid'),
      label: 'Esinemine',
      value: widget.value.occurrence,
      onChanged: _changeOccurrence,
      tiles: const <WizardCompactTile<NewProjectWizardProblemOccurrence>>[
        WizardCompactTile<NewProjectWizardProblemOccurrence>(
          value: NewProjectWizardProblemOccurrence.continuous,
          label: 'Pidev',
          semanticsLabel: 'Esinemine: Pidev',
          icon: Icons.all_inclusive,
          key: ValueKey('wizard-problem-occurrence-continuous'),
        ),
        WizardCompactTile<NewProjectWizardProblemOccurrence>(
          value: NewProjectWizardProblemOccurrence.intermittent,
          label: 'Vahelduv',
          semanticsLabel: 'Esinemine: Vahelduv',
          icon: Icons.swap_horiz,
          key: ValueKey('wizard-problem-occurrence-intermittent'),
        ),
        WizardCompactTile<NewProjectWizardProblemOccurrence>(
          value: NewProjectWizardProblemOccurrence.unknown,
          label: 'Teadmata',
          semanticsLabel: 'Esinemine: Teadmata',
          icon: Icons.help_outline,
          key: ValueKey('wizard-problem-occurrence-unknown'),
        ),
      ],
    );
  }

  Widget _buildBoundaryNote() {
    const copy = 'Sisesta ainult enda teada olevaid tähelepanekuid. '
        'See redaktor ei diagnoosi põhjust ega tuvasta komponente või '
        'elektrilisi seoseid. Andmed jäävad ainult selle Wizardi lokaalsesse '
        'mustandisse.';
    return const WizardCompactInlineNotice(
      semanticsKey: ValueKey('wizard-problem-boundary-note'),
      message: copy,
    );
  }

  Widget _buildPrimaryColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildField(
          label: 'Probleemi põhikirjeldus',
          semanticsLabel: 'Probleemi põhikirjeldus, nõutav',
          keyName: 'wizard-problem-description',
          controller: _descriptionController,
          onChanged: _changeDescription,
          required: true,
          hintText: 'Kirjelda oma sõnadega, mida seade teeb või ei tee.',
        ),
        const SizedBox(height: 18),
        _buildOccurrence(),
      ],
    );
  }

  Widget _buildOptionalColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildField(
          label: 'Millal probleem ilmneb?',
          semanticsLabel: 'Millal probleem ilmneb?, valikuline',
          keyName: 'wizard-problem-when',
          controller: _whenController,
          onChanged: _changeWhenOccurs,
          required: false,
        ),
        const SizedBox(height: 18),
        _buildField(
          label: 'Nähtavad või kuuldavad sümptomid',
          semanticsLabel: 'Nähtavad või kuuldavad sümptomid, valikuline',
          keyName: 'wizard-problem-symptoms',
          controller: _symptomsController,
          onChanged: _changeSymptoms,
          required: false,
        ),
        const SizedBox(height: 18),
        _buildField(
          label: 'Mida on juba proovitud?',
          semanticsLabel: 'Mida on juba proovitud?, valikuline',
          keyName: 'wizard-problem-attempts',
          controller: _attemptsController,
          onChanged: _changeAttempts,
          required: false,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _whenController.dispose();
    _symptomsController.dispose();
    _attemptsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fields = widget.compact
        ? Column(
            key: const ValueKey('wizard-problem-compact-layout'),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildPrimaryColumn(),
              const SizedBox(height: 18),
              _buildOptionalColumn(),
            ],
          )
        : Row(
            key: const ValueKey('wizard-problem-wide-layout'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _buildPrimaryColumn()),
              const SizedBox(width: 22),
              Expanded(child: _buildOptionalColumn()),
            ],
          );
    return Semantics(
      key: const ValueKey('wizard-problem-editor'),
      container: true,
      explicitChildNodes: true,
      label: 'Probleemi kirjelduse redaktor',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          fields,
          const SizedBox(height: 18),
          _buildBoundaryNote(),
        ],
      ),
    );
  }
}
