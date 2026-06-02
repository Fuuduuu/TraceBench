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

class _FakeReferenceImageSidecarService extends ReferenceImageSidecarService {
  const _FakeReferenceImageSidecarService(this.ledger);

  final ReferenceImageLedger ledger;

  @override
  Future<ReferenceImageLedger> loadLedger({
    required String projectDirectory,
    required String projectId,
  }) async {
    return ledger;
  }

  @override
  Future<ImportReferenceImageResult> importFromLocalFile({
    required String projectDirectory,
    required String projectId,
    required String sourceFilePath,
  }) async {
    return ImportReferenceImageResult.failure('Import failed.');
  }
}

class _FakeReferenceImageSidecarServiceForImportError
    extends ReferenceImageSidecarService {
  const _FakeReferenceImageSidecarServiceForImportError({
    required this.ledger,
    required this.result,
  });

  final ReferenceImageLedger ledger;
  final ImportReferenceImageResult result;

  @override
  Future<ReferenceImageLedger> loadLedger({
    required String projectDirectory,
    required String projectId,
  }) async {
    return ledger;
  }

  @override
  Future<ImportReferenceImageResult> importFromLocalFile({
    required String projectDirectory,
    required String projectId,
    required String sourceFilePath,
  }) async {
    return result;
  }
}

class _FakeReferenceImageSidecarServiceForMissingFile
    extends _FakeReferenceImageSidecarService {
  const _FakeReferenceImageSidecarServiceForMissingFile(this.ledger) : super(ledger);

  final ReferenceImageLedger ledger;

  @override
  Future<ReferenceImageLedger> loadLedger({
    required String projectDirectory,
    required String projectId,
  }) async {
    return ledger;
  }

  @override
  File? resolveStoredImageFile({
    required String projectDirectory,
    required ReferenceImageRecord record,
  }) {
    return null;
  }
}

Future<void> _pumpReferenceImagesScreen(
  WidgetTester tester, {
  required ReferenceImageSidecarService service,
  String projectDirectory = 'C:/tracebench_fake_project',
  Future<String?> Function()? pickReferenceImageFile,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        projectStateProvider.overrideWith(
          (_) => _projectState(projectDirectory: projectDirectory),
        ),
      ],
      child: MaterialApp(
        home: ReferenceImagesScreen(
          service: service,
          pickReferenceImageFile: pickReferenceImageFile,
        ),
      ),
    ),
  );
  for (var i = 0; i < 3; i++) {
    await tester.pump(const Duration(milliseconds: 1));
  }
}

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
  testWidgets(
    'shows required safety copy for empty no-image state',
    (tester) async {
      const fakeProjectDirectory = 'C:/tracebench_fake_project';
      await _pumpReferenceImagesScreen(
        tester,
        service: const _FakeReferenceImageSidecarService(
          ReferenceImageLedger(
            projectId: 'prj_ref_test_001',
            images: [],
          ),
        ),
        projectDirectory: fakeProjectDirectory,
      );

      expect(find.text('Reference Images'), findsOneWidget);
      expect(find.text('Reference images (local sidecar)'), findsOneWidget);
      expect(find.text('reference only'), findsOneWidget);
      expect(find.text('not evidence'), findsOneWidget);
      expect(find.text('not included in Project ZIP'), findsOneWidget);
      expect(find.text('not used by AI'), findsOneWidget);
      expect(find.text('renderer writes: none'), findsOneWidget);
      expect(find.text('personal reference only'), findsOneWidget);
      expect(find.text('Import from this computer'), findsOneWidget);
      expect(find.text('No reference images yet.'), findsOneWidget);
      expect(find.text('Select a reference image to preview.'), findsOneWidget);

      const forbiddenWords = <String>[
        'confirmed',
        'detected',
        'measured',
        'fault',
        'suspect',
        'probability',
        'net',
        'trace proof',
        'AI found',
        'verified',
        'identified',
        'proven',
        'match found',
        'candidate',
      ];
      for (final word in forbiddenWords) {
        expect(find.textContaining(word), findsNothing);
      }
    },
  );

  testWidgets('shows missing local file state', (tester) async {
    const fakeProjectDirectory = 'C:/tracebench_fake_project';
    const ledger = ReferenceImageLedger(
      projectId: 'prj_ref_test_001',
      images: [
        ReferenceImageRecord(
          referenceImageId: 'refimg_001',
          originalFilenameDisplay: 'smoke_reference.png',
          storedRelativePath: '.tracebench_local/reference_images/refimg_missing.png',
          mimeType: 'image/png',
          fileSizeBytes: 1234,
          importedAt: '2026-06-01T00:00:00Z',
          source: 'local_file_picker',
          projectId: 'prj_ref_test_001',
        ),
      ],
    );

    await _pumpReferenceImagesScreen(
      tester,
      service: const _FakeReferenceImageSidecarServiceForMissingFile(ledger),
      projectDirectory: fakeProjectDirectory,
    );
    await tester.pump();
    await tester.pump();
    await tester.scrollUntilVisible(
      find.text('File not found at its stored path.'),
      100,
      scrollable: find.byType(Scrollable).at(1),
    );

    expect(find.text('File not found at its stored path.'), findsOneWidget);
    expect(
      find.text(
        'Reference images are local-sidecar only and must stay on disk.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows import unsupported format error', (tester) async {
    const fakeProjectDirectory = 'C:/tracebench_fake_project';
    const ledger = ReferenceImageLedger(projectId: 'prj_ref_test_001', images: []);

    await _pumpReferenceImagesScreen(
      tester,
      service: const _FakeReferenceImageSidecarServiceForImportError(
        ledger: ledger,
        result: ImportReferenceImageResult.failure(
          'Unsupported file type. Use png, jpg, jpeg, or webp.',
        ),
      ),
      projectDirectory: fakeProjectDirectory,
      pickReferenceImageFile: () async => 'C:/tracebench_fake_project/sample.png',
    );
    await tester.tap(find.byKey(const ValueKey('reference-images-import-button')));
    await tester.pump();

    expect(
      find.text('Unsupported format. Supported: png, jpg, jpeg, webp.'),
      findsOneWidget,
    );
  });

  testWidgets('shows import too-large file message', (tester) async {
    const fakeProjectDirectory = 'C:/tracebench_fake_project';
    const ledger = ReferenceImageLedger(projectId: 'prj_ref_test_001', images: []);

    await _pumpReferenceImagesScreen(
      tester,
      service: const _FakeReferenceImageSidecarServiceForImportError(
        ledger: ledger,
        result: ImportReferenceImageResult.failure(
          'File is too large. Max size is 20 MB.',
        ),
      ),
      projectDirectory: fakeProjectDirectory,
      pickReferenceImageFile: () async => 'C:/tracebench_fake_project/sample.png',
    );
    await tester.tap(find.byKey(const ValueKey('reference-images-import-button')));
    await tester.pump();

    expect(
      find.text('File is too large. Maximum import size is 20 MB.'),
      findsOneWidget,
    );
  });

  testWidgets('shows import max count reached message', (tester) async {
    const fakeProjectDirectory = 'C:/tracebench_fake_project';
    const ledger = ReferenceImageLedger(projectId: 'prj_ref_test_001', images: []);

    await _pumpReferenceImagesScreen(
      tester,
      service: const _FakeReferenceImageSidecarServiceForImportError(
        ledger: ledger,
        result: ImportReferenceImageResult.failure(
          'Reference image limit reached (50).',
        ),
      ),
      projectDirectory: fakeProjectDirectory,
      pickReferenceImageFile: () async => 'C:/tracebench_fake_project/sample.png',
    );
    await tester.tap(find.byKey(const ValueKey('reference-images-import-button')));
    await tester.pump();

    expect(find.text('Maximum reference image count reached.'), findsOneWidget);
  });

  testWidgets('shows import missing source file message', (tester) async {
    const fakeProjectDirectory = 'C:/tracebench_fake_project';
    const ledger = ReferenceImageLedger(projectId: 'prj_ref_test_001', images: []);

    await _pumpReferenceImagesScreen(
      tester,
      service: const _FakeReferenceImageSidecarServiceForImportError(
        ledger: ledger,
        result: ImportReferenceImageResult.failure(
          'Selected file was not found.',
        ),
      ),
      projectDirectory: fakeProjectDirectory,
      pickReferenceImageFile: () async => 'C:/tracebench_fake_project/sample.png',
    );
    await tester.tap(find.byKey(const ValueKey('reference-images-import-button')));
    await tester.pump();

    expect(find.text('The selected file is no longer available.'), findsOneWidget);
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

  test('service clamps ledger preview paths to sidecar image directory', () async {
    final tempRoot = await Directory.systemTemp.createTemp('tracebench_ref_clamp_');
    try {
      final projectDir = Directory('${tempRoot.path}${Platform.pathSeparator}project');
      await projectDir.create(recursive: true);

      const service = ReferenceImageSidecarService();
      ReferenceImageRecord recordWithPath(String path) {
        return ReferenceImageRecord(
          referenceImageId: 'refimg_test',
          originalFilenameDisplay: 'x.png',
          storedRelativePath: path,
          mimeType: 'image/png',
          fileSizeBytes: 1,
          importedAt: '2026-06-01T00:00:00Z',
          source: 'local_file_picker',
          projectId: 'prj_ref_test_001',
        );
      }

      final valid = service.resolveStoredImageFile(
        projectDirectory: projectDir.path,
        record: recordWithPath('.tracebench_local/reference_images/refimg_valid.png'),
      );
      expect(valid, isNotNull);

      final rootPath =
          '${projectDir.path}${Platform.pathSeparator}.tracebench_local${Platform.pathSeparator}reference_images';
      String normalize(String value) {
        var out = value.replaceAll('\\', '/');
        while (out.endsWith('/')) {
          out = out.substring(0, out.length - 1);
        }
        return Platform.isWindows ? out.toLowerCase() : out;
      }

      final normalizedRoot = normalize(rootPath);
      final normalizedValid = normalize(valid!.path);
      expect(normalizedValid.startsWith('$normalizedRoot/'), isTrue);

      const escapingPaths = <String>[
        r'C:\Windows\win.ini',
        '/etc/passwd',
        '.tracebench_local/reference_images/../outside.png',
        '.tracebench_local/reference_images/../../outside.png',
        '../.tracebench_local/reference_images/outside.png',
        '.tracebench_local/other_images/file.png',
      ];

      for (final storedRelativePath in escapingPaths) {
        final rejected = service.resolveStoredImageFile(
          projectDirectory: projectDir.path,
          record: recordWithPath(storedRelativePath),
        );
        expect(
          rejected,
          isNull,
          reason: 'Expected path to be rejected: $storedRelativePath',
        );
      }
    } finally {
      if (await tempRoot.exists()) {
        await tempRoot.delete(recursive: true);
      }
    }
  });
}
