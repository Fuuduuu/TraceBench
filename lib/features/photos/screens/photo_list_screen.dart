import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/session/beginner_mode_provider.dart';
import '../../../shared/session/project_session.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/widgets/projection_stale_banner.dart';
import '../../../shared/widgets/workbench_page.dart';
import '../../../shared/theme/app_theme.dart';

class PhotoListScreen extends ConsumerWidget {
  const PhotoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final isBeginnerMode = ref.watch(beginnerModeProvider);
    if (projectState == null) {
      return WorkbenchPage(
        builder: (_) => const Center(child: Text('No project loaded')),
      );
    }
    return WorkbenchPage(
      builder: (_) => CustomScrollView(
        primary: false,
        slivers: [
          SliverToBoxAdapter(
              child: ProjectionStaleBanner(
            freshness: projectState.projectionFreshness,
            contextLabel: 'Photo evidence',
          )),
          if (projectState.knownFacts.photos.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('Fotosid ei leitud')),
            )
          else
            SliverList.separated(
              itemCount: projectState.knownFacts.photos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => _PhotoCard(
                photo: projectState.knownFacts.photos[index],
                knownFacts: projectState.knownFacts,
                isBeginnerMode: isBeginnerMode,
              ),
            ),
        ],
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({
    required this.photo,
    required this.knownFacts,
    required this.isBeginnerMode,
  });

  final PhotoFact photo;
  final KnownFacts knownFacts;
  final bool isBeginnerMode;

  @override
  Widget build(BuildContext context) {
    final damageRegions = knownFacts.damageRegions
        .where((region) => region.photoId == photo.photoId)
        .toList(growable: false);
    final suspectRegions = knownFacts.suspectRegions
        .where((region) => region.photoId == photo.photoId)
        .toList(growable: false);
    final visualTraces = knownFacts.visualTraces
        .where((trace) => trace.photoId == photo.photoId)
        .toList(growable: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBeginnerMode) ...[
              Text('Režiim: ${photo.mode}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: WorkbenchColors.signal,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(
                  photo.path.isNotEmpty ? 'Fail: ${photo.path}' : 'Fail puudub',
                  style: const TextStyle(color: WorkbenchColors.muted)),
              const SizedBox(height: 12),
              Wrap(
                key: ValueKey('photo-summary-${photo.photoId}'),
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final label in [
                    'Kahjustuse piirkondi: ${damageRegions.length}',
                    'Kahtlaste piirkondi: ${suspectRegions.length}',
                    'Visuaalseid jälgi: ${visualTraces.length}',
                  ])
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: WorkbenchColors.raised,
                        border: Border.all(color: WorkbenchColors.rule),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Text(label,
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ),
                ],
              ),
            ] else ...[
              Text('Foto ID: ${photo.photoId}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: WorkbenchColors.signal,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text('Fail: ${photo.path.isNotEmpty ? photo.path : 'Puudub'}',
                  style: const TextStyle(color: WorkbenchColors.muted)),
              Text('Režiim: ${photo.mode}'),
              if (photo.layer != null) Text('Kiht: ${photo.layer}'),
              if (photo.sourceDevice != null)
                Text('Allikas: ${photo.sourceDevice}'),
              Wrap(
                key: ValueKey('photo-summary-${photo.photoId}'),
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final label in [
                    'Kahjustuse piirkondi: ${damageRegions.length}',
                    'Kahtlasi piirkondi: ${suspectRegions.length}',
                    'Visuaalseid jälgi: ${visualTraces.length}',
                  ])
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: WorkbenchColors.raised,
                        border: Border.all(color: WorkbenchColors.rule),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Text(label,
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ),
                ],
              ),
              if (damageRegions.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Kahjustused:',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: WorkbenchColors.signal),
                ),
                for (final region in damageRegions) ...[
                  Text(
                    '${region.regionId}: ${region.damageType} · '
                    'x=${region.x}, y=${region.y}, w=${region.width}, h=${region.height}',
                  ),
                  if (region.notes != null) Text('  Märkus: ${region.notes}'),
                  if (region.affectsComponents != null)
                    Text(
                        '  Mõjutatud komponendid: ${region.affectsComponents!.join(', ')}'),
                ],
              ],
              if (suspectRegions.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Kahtlused:',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: WorkbenchColors.signal),
                ),
                for (final region in suspectRegions) ...[
                  Text(
                    '${region.regionId}: ${region.reason} · '
                    'x=${region.x}, y=${region.y}, w=${region.width}, h=${region.height}',
                  ),
                  if (region.notes != null) Text('  Märkus: ${region.notes}'),
                  if (region.affectsComponents != null)
                    Text(
                        '  Mõjutatud komponendid: ${region.affectsComponents!.join(', ')}'),
                  if (region.priority != null)
                    Text('  Prioriteet: ${region.priority}'),
                ],
              ],
              if (visualTraces.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Visuaalsed tõendid (visual evidence only):',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: WorkbenchColors.signal),
                ),
                for (final trace in visualTraces)
                  Text(
                    '${trace.traceId}: ${trace.evidenceType}',
                  ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
