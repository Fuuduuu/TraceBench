import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/widgets/projection_stale_banner.dart';

class PhotoListScreen extends ConsumerWidget {
  const PhotoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final isBeginnerMode = ref.watch(beginnerModeProvider);
    if (projectState == null) {
      return const Scaffold(
        body: Center(child: Text('No project loaded')),
      );
    }

    if (projectState.knownFacts.photos.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Foto tõendid')),
        body: Column(
          children: [
            ProjectionStaleBanner(
              isStale: projectState.isProjectionStale,
              contextLabel: 'Photo evidence',
            ),
            const Expanded(child: Center(child: Text('Fotosid ei leitud'))),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Foto tõendid')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: projectState.knownFacts.photos.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, index) {
          if (index == 0) {
            return ProjectionStaleBanner(
              isStale: projectState.isProjectionStale,
              contextLabel: 'Photo evidence',
            );
          }

          final photo = projectState.knownFacts.photos[index - 1];
          return _PhotoCard(
            photo: photo,
            knownFacts: projectState.knownFacts,
            isBeginnerMode: isBeginnerMode,
          );
        },
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBeginnerMode) ...[
              Text('Režiim: ${photo.mode}',
                  style: const TextStyle(fontSize: 16)),
              Text(photo.path.isNotEmpty
                  ? 'Fail: ${photo.path}'
                  : 'Fail puudub'),
              Text('Kahjustuse piirkondi: ${damageRegions.length}'),
              Text('Kahtlaste piirkondi: ${suspectRegions.length}'),
              Text('Visuaalseid jälgi: ${visualTraces.length}'),
            ] else ...[
              Text('Foto ID: ${photo.photoId}'),
              Text('Fail: ${photo.path.isNotEmpty ? photo.path : 'Puudub'}'),
              Text('Režiim: ${photo.mode}'),
              if (photo.layer != null) Text('Kiht: ${photo.layer}'),
              if (photo.sourceDevice != null)
                Text('Allikas: ${photo.sourceDevice}'),
              Text('Kahjustuse piirkondi: ${damageRegions.length}'),
              Text('Kahtlasi piirkondi: ${suspectRegions.length}'),
              Text('Visuaalseid jälgi: ${visualTraces.length}'),
              if (damageRegions.isNotEmpty) ...[
                const SizedBox(height: 4),
                const Text(
                  'Kahjustused:',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                const SizedBox(height: 4),
                const Text(
                  'Kahtlused:',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                const SizedBox(height: 4),
                const Text(
                  'Visuaalsed tõendid (visual evidence only):',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
