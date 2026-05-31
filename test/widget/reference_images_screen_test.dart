import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/reference_images/screens/reference_images_screen.dart';
import 'package:trace_bench_viewer/features/reference_images/services/reference_image_sidecar_service.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';

ProjectState _projectState({String? projectDirectory}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'prj_ref_test_001',
      schemaVersion: '1.0',
      createdAt: '2026-06-01T00:00:00Z',
      deviceType: 'board',
      model: 'test-model',
      symptom: 'not_provided',
    ),
    knownFacts: const KnownFacts(
      projectId: 'prj_ref_test_001',
      components: [],
      pins: [],
      measurements: [],
      nets: [],
      excludedFromFaultCandidates: [],
      componentPinIndex: {},
      photos: [],
      damageRegions: [],
      suspectRegions: [],
      visualTraces: [],
      componentVisualPlacements: [],
      photoToBoardAlignments: [],
    ),
    events: const [],
    customerReport: '',
    projectDirectory: projectDirectory,
  );
}

void main() {
  testWidgets('shows safety copy and local-directory requirement', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => _projectState()),
        ],
        child: const MaterialApp(home: ReferenceImagesScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Reference Images'), findsOneWidget);
    expect(find.text('reference only'), findsOneWidget);
    expect(find.text('not evidence'), findsOneWidget);
    expect(find.text('not included in Project ZIP'), findsOneWidget);
    expect(find.text('not used by AI'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(
      find.text('Local project directory is required for sidecar storage.'),
      findsOneWidget,
    );
  });

  test('service imports local reference image into sidecar and writes metadata',
      () async {
    final tempRoot = await Directory.systemTemp.createTemp('tracebench_ref_test_');
    try {
      final projectDir = Directory('${tempRoot.path}${Platform.pathSeparator}project');
      await projectDir.create(recursive: true);

      final sourceFile = File('${tempRoot.path}${Platform.pathSeparator}source.png');
      await sourceFile.writeAsBytes(const [
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
        0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
        0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
        0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
        0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41,
        0x54, 0x78, 0x9C, 0x63, 0xF8, 0xCF, 0xC0, 0x00,
        0x00, 0x03, 0x01, 0x01, 0x00, 0x18, 0xDD, 0x8D,
        0x18, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E,
        0x44, 0xAE, 0x42, 0x60, 0x82,
      ]);

      const service = ReferenceImageSidecarService();
      final result = await service.importFromLocalFile(
        projectDirectory: projectDir.path,
        projectId: 'prj_ref_test_001',
        sourceFilePath: sourceFile.path,
      );

      expect(result.isSuccess, isTrue);
      final record = result.record;
      expect(record, isNotNull);
      expect(record!.originalFilenameDisplay, 'source.png');
      expect(record.mimeType, 'image/png');
      expect(record.source, 'local_file_picker');
      expect(record.projectId, 'prj_ref_test_001');

      final sidecarDir =
          Directory('${projectDir.path}${Platform.pathSeparator}.tracebench_local');
      final imagesDir = Directory(
        '${sidecarDir.path}${Platform.pathSeparator}reference_images',
      );
      final ledgerFile = File(
        '${sidecarDir.path}${Platform.pathSeparator}reference_images.json',
      );

      expect(await sidecarDir.exists(), isTrue);
      expect(await imagesDir.exists(), isTrue);
      expect(await ledgerFile.exists(), isTrue);

      final imageFiles =
          imagesDir.listSync().whereType<File>().toList(growable: false);
      expect(imageFiles.length, 1);

      final ledger = jsonDecode(await ledgerFile.readAsString())
          as Map<String, dynamic>;
      expect(ledger['project_id'], 'prj_ref_test_001');
      final images = (ledger['images'] as List).cast<Map<String, dynamic>>();
      expect(images.length, 1);
      final item = images.first;

      expect(item['reference_image_id'], isA<String>());
      expect(item['original_filename_display'], 'source.png');
      expect(item['stored_relative_path'], isA<String>());
      expect(item['mime_type'], 'image/png');
      expect(item['file_size_bytes'], 69);
      expect(item['imported_at'], isA<String>());
      expect(item['source'], 'local_file_picker');
      expect(item['project_id'], 'prj_ref_test_001');

      const forbiddenFields = [
        'component_id',
        'net_id',
        'measurement_id',
        'fault_type',
        'confidence',
        'ai_label',
        'detected_part',
        'alignment_id',
        'board_side',
        'coordinate_space',
        'bbox',
        'trace_id',
      ];
      for (final field in forbiddenFields) {
        expect(item.containsKey(field), isFalse);
      }
    } finally {
      if (await tempRoot.exists()) {
        await tempRoot.delete(recursive: true);
      }
    }
  });
}
