import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';

class MeasureSheetScreen extends ConsumerWidget {
  const MeasureSheetScreen({super.key});

  static const _forbiddenSurfaceCopy = 'renderer writes: none';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(
        body: Center(child: Text('No project loaded')),
      );
    }

    final selection = _MeasureSheetSelection.fromProject(projectState);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Measure Sheet'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 760;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SafetyBanner(selection: selection),
                  const SizedBox(height: 16),
                  if (isNarrow) ...[
                    _NarrowBoardContext(selection: selection),
                    const SizedBox(height: 16),
                    _MeasureSheetPanel(selection: selection),
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _BoardContextPanel(selection: selection)),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 430,
                          child: _MeasureSheetPanel(selection: selection),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  _ReferenceValuesPanel(selection: selection),
                  const SizedBox(height: 16),
                  _GuidedMeasurementPanel(selection: selection),
                  const SizedBox(height: 16),
                  const Text(
                    _forbiddenSurfaceCopy,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MeasureSheetSelection {
  const _MeasureSheetSelection({
    required this.componentLabel,
    required this.pinLabel,
    required this.measurementLabel,
    required this.measurementKind,
    required this.hasRecordedReading,
    required this.projectLabel,
  });

  final String componentLabel;
  final String pinLabel;
  final String measurementLabel;
  final String measurementKind;
  final bool hasRecordedReading;
  final String projectLabel;

  String get kohtLabel => '$componentLabel · $pinLabel';

  factory _MeasureSheetSelection.fromProject(ProjectState projectState) {
    final components = projectState.knownFacts.components;
    final component = components.isEmpty ? null : components.first;
    final componentLabel = component == null
        ? 'Koht puudub'
        : (component.designator?.isNotEmpty == true
            ? component.designator!
            : component.componentId);
    final pinLabel = _firstPinLabel(projectState.knownFacts, component);
    final measurement = _firstRelatedMeasurement(
      projectState.knownFacts,
      component,
      pinLabel,
    );

    return _MeasureSheetSelection(
      componentLabel: componentLabel,
      pinLabel: pinLabel,
      measurementLabel: _measurementLabel(measurement),
      measurementKind: _measurementKind(measurement),
      hasRecordedReading: measurement != null,
      projectLabel:
          '${projectState.manifest.deviceType} · ${projectState.manifest.model}',
    );
  }

  static String _firstPinLabel(KnownFacts knownFacts, ComponentFact? component) {
    if (component == null) {
      return 'jalg valimata';
    }
    final indexedPins = knownFacts.componentPinIndex[component.componentId];
    if (indexedPins != null && indexedPins.isNotEmpty) {
      return indexedPins.first;
    }
    for (final pin in knownFacts.pins) {
      if (pin.componentId == component.componentId) {
        return pin.pinId;
      }
    }
    return 'jalg valimata';
  }

  static MeasurementFact? _firstRelatedMeasurement(
    KnownFacts knownFacts,
    ComponentFact? component,
    String pinLabel,
  ) {
    if (component == null) {
      return null;
    }
    for (final measurement in knownFacts.measurements) {
      if (_targetMatches(measurement.from, component.componentId, pinLabel) ||
          _targetMatches(measurement.to, component.componentId, pinLabel)) {
        return measurement;
      }
    }
    return null;
  }

  static bool _targetMatches(String target, String componentId, String pinLabel) {
    return target == componentId || target == pinLabel || target.startsWith('$componentId.');
  }

  static String _measurementLabel(MeasurementFact? measurement) {
    if (measurement == null) {
      return 'sisesta mõõdetud väärtus';
    }
    if (measurement.value != null && measurement.unit != null) {
      return '${measurement.value} ${measurement.unit}';
    }
    return measurement.reading;
  }

  static String _measurementKind(MeasurementFact? measurement) {
    if (measurement == null) {
      return 'mõõtmine käsil';
    }
    return 'salvestatud lugem';
  }
}

class _SafetyBanner extends StatelessWidget {
  const _SafetyBanner({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Technician-first Measure Sheet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Project: ${selection.projectLabel}'),
            const SizedBox(height: 8),
            const Text('Human is the sensor. AI is the graph engine.'),
            const Text(
              'Read-only display shell: no project data is changed from this screen.',
            ),
          ],
        ),
      ),
    );
  }
}

class _BoardContextPanel extends StatelessWidget {
  const _BoardContextPanel({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Board context',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('valitud Koht: ${selection.kohtLabel}'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ContextChip(label: selection.componentLabel),
                        _ContextChip(label: selection.pinLabel),
                        const _ContextChip(label: 'kasutaja valik'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Board context is display-only. It keeps selected Koht visible while measurement entry remains the primary flow.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NarrowBoardContext extends StatelessWidget {
  const _NarrowBoardContext({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Board context hidden on narrow width'),
            const SizedBox(height: 8),
            Text('Selected Koht: ${selection.kohtLabel}'),
          ],
        ),
      ),
    );
  }
}

class _MeasureSheetPanel extends StatelessWidget {
  const _MeasureSheetPanel({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Koht -> Väärtus -> Ühik -> Salvesta',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _FlowField(
              label: 'Koht',
              helper: 'kasutaja valik',
              value: selection.kohtLabel,
            ),
            _FlowField(
              label: 'Väärtus',
              helper: selection.measurementKind,
              value: selection.measurementLabel,
              leading: _RecordedReadingDot(
                hasRecordedReading: selection.hasRecordedReading,
              ),
            ),
            const _UnitDisplay(),
            const SizedBox(height: 12),
            const ElevatedButton(
              key: ValueKey('measure-sheet-disabled-save-button'),
              onPressed: null,
              child: Text('Salvesta (välja lülitatud — ei kirjuta)'),
            ),
            const SizedBox(height: 8),
            const Text('Näidisnupp on mitteaktiivne ja ei muuda projekti.'),
            const Text('recorded reading marker means only that a reading exists.'),
          ],
        ),
      ),
    );
  }
}

class _FlowField extends StatelessWidget {
  const _FlowField({
    required this.label,
    required this.helper,
    required this.value,
    this.leading,
  });

  final String label;
  final String helper;
  final String value;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        label: '$label, $helper, $value',
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 4),
                      Text(helper),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecordedReadingDot extends StatelessWidget {
  const _RecordedReadingDot({required this.hasRecordedReading});

  final bool hasRecordedReading;

  @override
  Widget build(BuildContext context) {
    final color = hasRecordedReading ? Colors.amber.shade700 : Colors.grey;
    final label = hasRecordedReading ? 'lugem olemas' : 'mõõtmine käsil';
    return Semantics(
      label: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: const SizedBox(width: 10, height: 10),
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _UnitDisplay extends StatelessWidget {
  const _UnitDisplay();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ühik', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ContextChip(label: 'V'),
                  _ContextChip(label: 'Ω'),
                  _ContextChip(label: 'Diode'),
                  _ContextChip(label: 'Beep'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferenceValuesPanel extends StatelessWidget {
  const _ReferenceValuesPanel({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reference Values Panel',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            const Text(
              'Display only: reads the current projection and writes nothing.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _HierarchyTile(
                  label: 'Mõõdetud',
                  value: selection.hasRecordedReading
                      ? selection.measurementLabel
                      : 'mõõdetud väärtus puudub',
                  body: 'human reading, visually dominant',
                  emphasis: true,
                ),
                const _HierarchyTile(
                  label: 'Viide / Allikas',
                  value: 'viiteväärtus puudub',
                  body: 'secondary context; not a measurement; non-canonical',
                ),
                const _HierarchyTile(
                  label: 'Kandidaat',
                  value: 'kandidaati pole',
                  body: 'tentative context only; not proof',
                ),
                const _HierarchyTile(
                  label: 'Märkus',
                  value: 'märkus puudub',
                  body: 'context only; does not create facts',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Reference/source, candidate, and note rows are context only and are not promoted to measured values.',
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidedMeasurementPanel extends StatelessWidget {
  const _GuidedMeasurementPanel({required this.selection});

  final _MeasureSheetSelection selection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guided Measurement Helper',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            const Text(
              'Read-only helper: suggests neutral next checks and writes nothing.',
            ),
            const SizedBox(height: 4),
            const Text('Human technician measures and decides.'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _GuidedPromptTile(
                  label: 'Next measurement',
                  value:
                      'Mõõda järgmisena ${selection.kohtLabel} seotud ots või testpunkt.',
                  body: 'suggestion only; technician must measure',
                ),
                const _GuidedPromptTile(
                  label: 'Missing reading',
                  value: 'Lugem puudub? Mõõda enne järeldust.',
                  body: 'prompt only; no conclusion',
                ),
                const _GuidedPromptTile(
                  label: 'Gap / conflict',
                  value: 'Kaks lugemit erinevad? Kontrolli uuesti enne järeldust.',
                  body: 'surface the gap; technician decides',
                ),
                const _GuidedPromptTile(
                  label: 'Source context',
                  value: 'Viide / Allikas on kontekst, mitte mõõtmine.',
                  body: 'context may guide a check but is not measured',
                ),
                const _GuidedPromptTile(
                  label: 'Candidate context',
                  value: 'Kandidaat on oletuslik kontekst, mitte tõend.',
                  body: 'context only; not a project fact',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Helper does not create canonical facts or change project data.',
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidedPromptTile extends StatelessWidget {
  const _GuidedPromptTile({
    required this.label,
    required this.value,
    required this.body,
  });

  final String label;
  final String value;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 6),
              Text(value),
              const SizedBox(height: 6),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}

class _HierarchyTile extends StatelessWidget {
  const _HierarchyTile({
    required this.label,
    required this.value,
    required this.body,
    this.emphasis = false,
  });

  final String label;
  final String value;
  final String body;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: emphasis ? Colors.amber.shade700 : Theme.of(context).dividerColor,
            width: emphasis ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 6),
              Text(
                value,
                style: emphasis
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 6),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContextChip extends StatelessWidget {
  const _ContextChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
