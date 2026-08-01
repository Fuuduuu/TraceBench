import 'package:flutter/material.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: _ProblemEditorPalette.cream,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                required ? '* nõutav' : 'valikuline',
                style: TextStyle(
                  color: required
                      ? _ProblemEditorPalette.gold
                      : _ProblemEditorPalette.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            key: ValueKey<String>(keyName),
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: required ? 4 : 3,
            maxLines: required ? 7 : 5,
            style: const TextStyle(color: _ProblemEditorPalette.cream),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: _ProblemEditorPalette.faint),
              filled: true,
              fillColor: _ProblemEditorPalette.inset,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 13,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(
                  color: _ProblemEditorPalette.edge,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(
                  color: _ProblemEditorPalette.gold,
                  width: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccurrence() {
    const choices = <(
      NewProjectWizardProblemOccurrence,
      String,
      String,
    )>[
      (
        NewProjectWizardProblemOccurrence.continuous,
        'Pidev',
        'wizard-problem-occurrence-continuous',
      ),
      (
        NewProjectWizardProblemOccurrence.intermittent,
        'Vahelduv',
        'wizard-problem-occurrence-intermittent',
      ),
      (
        NewProjectWizardProblemOccurrence.unknown,
        'Teadmata',
        'wizard-problem-occurrence-unknown',
      ),
    ];
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: 'Esinemine',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ExcludeSemantics(
            child: Text(
              'Esinemine',
              style: TextStyle(
                color: _ProblemEditorPalette.cream,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 9,
            runSpacing: 9,
            children: <Widget>[
              for (final choice in choices)
                Semantics(
                  label: 'Esinemine: ${choice.$2}',
                  button: true,
                  selected: widget.value.occurrence == choice.$1,
                  child: ChoiceChip(
                    key: ValueKey<String>(choice.$3),
                    label: Text(choice.$2),
                    selected: widget.value.occurrence == choice.$1,
                    onSelected: (_) => _changeOccurrence(choice.$1),
                    selectedColor: _ProblemEditorPalette.activeFill,
                    backgroundColor: _ProblemEditorPalette.panel2,
                    side: BorderSide(
                      color: widget.value.occurrence == choice.$1
                          ? _ProblemEditorPalette.gold
                          : _ProblemEditorPalette.edge,
                    ),
                    labelStyle: TextStyle(
                      color: widget.value.occurrence == choice.$1
                          ? _ProblemEditorPalette.gold
                          : _ProblemEditorPalette.cream,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoundaryNote() {
    const copy = 'Sisesta ainult enda teada olevaid tähelepanekuid. '
        'See redaktor ei diagnoosi põhjust ega tuvasta komponente või '
        'elektrilisi seoseid. Andmed jäävad ainult selle Wizardi lokaalsesse '
        'mustandisse.';
    return Semantics(
      key: const ValueKey('wizard-problem-boundary-note'),
      container: true,
      label: copy,
      child: Container(
        decoration: BoxDecoration(
          color: _ProblemEditorPalette.noteFill,
          border: Border.all(color: _ProblemEditorPalette.edgeGold),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(14),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.info_outline,
              color: _ProblemEditorPalette.gold,
              size: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                copy,
                style: TextStyle(
                  color: _ProblemEditorPalette.muted,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
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

abstract final class _ProblemEditorPalette {
  static const Color panel2 = Color(0xFF1B1915);
  static const Color inset = Color(0xFF0A0A0A);
  static const Color edge = Color(0xFF332E22);
  static const Color edgeGold = Color(0xFF6B5A30);
  static const Color gold = Color(0xFFE7C25A);
  static const Color cream = Color(0xFFF3ECDC);
  static const Color muted = Color(0xFFA89F8C);
  static const Color faint = Color(0xFF766F61);
  static const Color activeFill = Color(0xFF332A17);
  static const Color noteFill = Color(0xFF17140E);
}
