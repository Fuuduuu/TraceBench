import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/board_graph/models/board_graph_model.dart';
import 'package:trace_bench_viewer/features/board_graph/services/board_graph_projector.dart';
import 'package:trace_bench_viewer/features/board_graph/services/graph_layout.dart';
import 'package:trace_bench_viewer/features/board_graph/widgets/board_graph_canvas.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

class BoardGraphScreen extends ConsumerStatefulWidget {
  const BoardGraphScreen({super.key});

  @override
  ConsumerState<BoardGraphScreen> createState() => _BoardGraphScreenState();
}

class _BoardGraphScreenState extends ConsumerState<BoardGraphScreen> {
  String? _focusComponent;
  bool _showVisualTraces = false;
  bool _showHistory = false;

  @override
  Widget build(BuildContext context) {
    final isBeginnerMode = ref.watch(beginnerModeProvider);
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    final knownFacts = projectState.knownFacts;
    final baseProjection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final filter = _buildFilter(
      isBeginnerMode: isBeginnerMode,
    );
    final activeProjection = _focusComponent == null
        ? baseProjection.filter(filter)
        : baseProjection.focus(
            componentId: _focusComponent!,
            depth: 1,
            filter: filter,
          );

    final layout = GraphLayoutEngine.layout(activeProjection);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Board graph'),
        actions: [
          IconButton(
            tooltip: 'toggle mode',
            onPressed: () => ref.read(beginnerModeProvider.notifier).state =
                !ref.read(beginnerModeProvider),
            icon: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProjectionStaleBanner(
                isStale: projectState.isProjectionStale,
                contextLabel: 'Board graph',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _SummaryChip(
                        label: 'components',
                        value: knownFacts.components.length),
                    _SummaryChip(label: 'pins', value: knownFacts.pins.length),
                    _SummaryChip(
                      label: 'measured nets',
                      value: knownFacts.nets.length,
                    ),
                    _SummaryChip(
                      label: 'measurements',
                      value: knownFacts.measurements.length,
                    ),
                    _SummaryChip(
                      label: 'not populated',
                      value: knownFacts.excludedFromFaultCandidates.length,
                    ),
                  ],
                ),
              ),
              if (!isBeginnerMode) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('Show visual traces'),
                        selected: _showVisualTraces,
                        onSelected: (value) => setState(() {
                          _showVisualTraces = value;
                        }),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Audit/history'),
                        selected: _showHistory,
                        onSelected: (value) => setState(() {
                          _showHistory = value;
                        }),
                      ),
                    ],
                  ),
                ),
              ],
              if (knownFacts.components.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('No focus'),
                    value: _focusComponent,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('No focus'),
                      ),
                      ...knownFacts.components
                          .map(
                            (component) => DropdownMenuItem<String>(
                              value: component.componentId,
                              child: Text(component.componentId),
                            ),
                          )
                          .toList(),
                    ],
                    onChanged: (value) => setState(() {
                      _focusComponent = value;
                    }),
                  ),
                ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Text(
                  'Advanced mode: ${!isBeginnerMode}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BoardGraphCanvas(
                  projection: activeProjection,
                  nodePositions: layout.nodePositions,
                  showAdvancedDetails: !isBeginnerMode,
                ),
              ),
              const Divider(height: 1),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                children: [
                  for (final node in activeProjection.nodes.take(30))
                    Text(
                      '${node.type.name}: ${node.id}',
                      key: ValueKey('board-graph-list-${node.id}'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  LayerFilter _buildFilter({required bool isBeginnerMode}) {
    if (isBeginnerMode) {
      return const LayerFilter.beginner();
    }

    final activeLayers = <LayerTag>{
      LayerTag.component,
      LayerTag.pin,
      LayerTag.electricalNet,
      LayerTag.measurement,
      LayerTag.notPopulated,
      LayerTag.footprint,
    };

    if (_showVisualTraces) {
      activeLayers.add(LayerTag.visualTrace);
    }
    if (_showHistory) {
      activeLayers
        ..add(LayerTag.damage)
        ..add(LayerTag.suspect)
        ..add(LayerTag.repairHistory);
    }

    return LayerFilter(
      activeLayers: activeLayers.toSet(),
      minimumEvidence: EvidenceLevel.unknown,
      includeValidity: _showHistory
          ? IncludeValidity.includeStale
          : IncludeValidity.activeOnly,
      showNotPopulated: true,
      showRepairHistory: _showHistory,
      beginnerMode: false,
      includeVisualTraces: _showVisualTraces,
      includeDamageAndSuspect: _showHistory,
      includeRawIds: true,
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text('$label: $value'));
  }
}
