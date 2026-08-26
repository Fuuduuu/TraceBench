import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/photos/services/photo_event_writer.dart';
import 'package:trace_bench_viewer/features/photos/services/photo_import_service.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';

class _FakePhotoEventWriter implements PhotoEventWriter {
  _FakePhotoEventWriter(this.handler);

  final Future<PhotoEventWriteResult> Function(
    ProjectState projectState,
    PhotoEventWriteRequest request,
  ) handler;
  final List<PhotoEventWriteRequest> requests = <PhotoEventWriteRequest>[];

  @override
  Future<PhotoEventWriteResult> writePhotoAdded({
    required ProjectState projectState,
    required PhotoEventWriteRequest request,
  }) async {
    requests.add(request);
    return handler(projectState, request);
  }
}

ProjectState _projectState(
  Directory directory, {
  String? projectDirectory,
  List<TraceBenchEvent> events = const <TraceBenchEvent>[],
}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'prj_photo_import',
      schemaVersion: '1.0',
      createdAt: '2026-08-26T09:00:00Z',
      deviceType: 'board',
      model: 'test',
      symptom: 'test',
    ),
    knownFacts: KnownFacts.fromJson(<String, dynamic>{
      'project_id': 'prj_photo_import',
      'components': const <dynamic>[],
      'pins': const <dynamic>[],
      'measurements': const <dynamic>[],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: events,
    customerReport: '',
    projectDirectory: projectDirectory ?? directory.path,
  );
}

Map<String, dynamic> _durableEvent(PhotoEventWriteRequest request) {
  return <String, dynamic>{
    'schema_version': '1.0',
    'event_id': 'evt_000001',
    'project_id': 'prj_photo_import',
    'sequence': 1,
    'created_at': '2026-08-26T10:00:00Z',
    'actor': const <String, dynamic>{
      'type': 'user',
      'id': 'local_operator',
    },
    'event_type': 'photo_added',
    'status': 'accepted',
    'payload': <String, dynamic>{
      'photo_id': request.photoId,
      'mode': request.mode,
      'path': request.path,
      'sha256': request.sha256,
      if (request.layer != null) 'layer': request.layer,
    },
  };
}

PhotoEventWriteResult _success(PhotoEventWriteRequest request) {
  return PhotoEventWriteResult(
    status: PhotoEventWriteStatus.appended,
    durability: PhotoEventDurability.durable,
    event: _durableEvent(request),
  );
}

File _sourceFile(Directory parent, String name, List<int> bytes) {
  return File('${parent.path}${Platform.pathSeparator}$name')
    ..writeAsBytesSync(bytes, flush: true);
}

List<String> _queuedIds(Iterable<String> values) => List<String>.of(values);

void main() {
  group('LocalPhotoImportService', () {
    test('streams, hashes, atomically finalizes, then writes canonical event',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final sourceBytes = utf8.encode('photo bytes streamed once');
      final source = _sourceFile(sources, 'BOARD.JPEG', sourceBytes);
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      var observedSameDirectoryTemp = false;
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => 'photo_streamed_001',
        atomicFinalizer: (temporaryFile, finalFile) async {
          expect(await temporaryFile.exists(), isTrue);
          expect(temporaryFile.parent.path, finalFile.parent.path);
          expect(await finalFile.exists(), isFalse);
          observedSameDirectoryTemp = true;
          await temporaryFile.rename(finalFile.path);
        },
      );

      final result = await service.importPhoto(
        projectState: _projectState(project),
        request: PhotoImportRequest(
          sourcePath: source.path,
          mode: 'macro',
          layer: 'detail',
        ),
      );

      expect(observedSameDirectoryTemp, isTrue);
      expect(result.photoId, 'photo_streamed_001');
      expect(result.path, 'photos/photo_streamed_001.jpeg');
      expect(result.sha256, sha256.convert(sourceBytes).toString());
      expect(result.event, _durableEvent(writer.requests.single));
      expect(await File(result.absolutePath).readAsBytes(), sourceBytes);
      expect(await source.readAsBytes(), sourceBytes);
      expect(writer.requests.single.mode, 'macro');
      expect(writer.requests.single.layer, 'detail');
      expect(writer.requests.single.path, result.path);
      expect(
        await Directory('${project.path}${Platform.pathSeparator}photos')
            .list()
            .where((entity) => entity.path.contains('.tracebench-photo-'))
            .isEmpty,
        isTrue,
      );
    });

    test('rejects missing, unsupported, and non-file sources without writes',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final unsupported = _sourceFile(sources, 'board.gif', <int>[1, 2, 3]);
      final sourceDirectory =
          await Directory('${sources.path}${Platform.pathSeparator}board.png')
              .create();
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => 'photo_should_not_write',
      );

      for (final sourcePath in <String>[
        '${sources.path}${Platform.pathSeparator}missing.jpg',
        unsupported.path,
        sourceDirectory.path,
      ]) {
        await expectLater(
          service.importPhoto(
            projectState: _projectState(project),
            request: PhotoImportRequest(
              sourcePath: sourcePath,
              mode: 'normal',
            ),
          ),
          throwsA(isA<PhotoImportException>()),
        );
      }

      expect(writer.requests, isEmpty);
      expect(
        await Directory('${project.path}${Platform.pathSeparator}photos')
            .exists(),
        isFalse,
      );
    });

    test('requires directory backing and a real contained photos directory',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final source = _sourceFile(sources, 'board.jpg', <int>[1, 2, 3]);
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => 'photo_directory_guard',
      );

      await expectLater(
        service.importPhoto(
          projectState: _projectState(project, projectDirectory: ''),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>().having(
            (error) => error.kind,
            'kind',
            PhotoImportFailureKind.noProjectDirectory,
          ),
        ),
      );

      _sourceFile(project, 'photos', <int>[9]);
      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>().having(
            (error) => error.kind,
            'kind',
            PhotoImportFailureKind.invalidPhotosDirectory,
          ),
        ),
      );
      expect(writer.requests, isEmpty);
      expect(await source.readAsBytes(), <int>[1, 2, 3]);
    });

    test('allocates collision-safe pairs and preserves pre-existing files',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final source = _sourceFile(sources, 'board.JPG', <int>[7, 8, 9]);
      final ids = _queuedIds(<String>[
        'photo_repeat',
        'photo_repeat',
        'photo_repeat_2',
      ]);
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => ids.removeAt(0),
      );

      final first = await service.importPhoto(
        projectState: _projectState(project),
        request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
      );
      final second = await service.importPhoto(
        projectState: _projectState(project),
        request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
      );

      expect(first.path, 'photos/photo_repeat.jpg');
      expect(second.path, 'photos/photo_repeat_2.jpg');
      expect(first.path, isNot(second.path));
      expect(await File(first.absolutePath).readAsBytes(), <int>[7, 8, 9]);
      expect(await File(second.absolutePath).readAsBytes(), <int>[7, 8, 9]);
    });

    test('existing event photo ID and Wizard background force distinct copy',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      addTearDown(() => project.delete(recursive: true));
      final photos = await Directory(
        '${project.path}${Platform.pathSeparator}photos',
      ).create();
      final wizard = _sourceFile(
        photos,
        'wizard_background.PNG',
        <int>[10, 20, 30, 40],
      );
      const existingPhotoEvent = TraceBenchEvent(
        schemaVersion: '1.0',
        eventId: 'evt_000001',
        projectId: 'prj_photo_import',
        sequence: 1,
        createdAt: '2026-08-26T09:00:00Z',
        actor: <String, dynamic>{'type': 'user', 'id': 'tester'},
        eventType: 'photo_added',
        status: 'accepted',
        payload: <String, dynamic>{
          'photo_id': 'photo_existing',
          'mode': 'normal',
          'path': 'photos/existing.png',
        },
      );
      final ids = _queuedIds(<String>['photo_existing', 'photo_wizard_copy']);
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => ids.removeAt(0),
      );

      final result = await service.importPhoto(
        projectState: _projectState(
          project,
          events: <TraceBenchEvent>[existingPhotoEvent],
        ),
        request: PhotoImportRequest(
          sourcePath: wizard.path,
          mode: 'normal',
          layer: 'top',
        ),
      );

      expect(result.photoId, 'photo_wizard_copy');
      expect(result.absolutePath, isNot(wizard.path));
      expect(result.path, 'photos/photo_wizard_copy.png');
      expect(
          await File(result.absolutePath).readAsBytes(), <int>[10, 20, 30, 40]);
      expect(await wizard.readAsBytes(), <int>[10, 20, 30, 40]);
    });

    test(
        'rejects project traversal and an escaping photos symlink when supported',
        () async {
      final root =
          await Directory.systemTemp.createTemp('tracebench-photo-root-');
      final project = await Directory(
        '${root.path}${Platform.pathSeparator}project',
      ).create();
      final outside = await Directory(
        '${root.path}${Platform.pathSeparator}outside',
      ).create();
      final source = _sourceFile(root, 'board.png', <int>[1, 2, 3]);
      addTearDown(() => root.delete(recursive: true));
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => 'photo_escape',
      );

      await expectLater(
        service.importPhoto(
          projectState: _projectState(
            project,
            projectDirectory:
                '${project.path}${Platform.pathSeparator}child${Platform.pathSeparator}..',
          ),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>().having(
            (error) => error.kind,
            'kind',
            PhotoImportFailureKind.invalidProjectDirectory,
          ),
        ),
      );

      final photosLink = Link(
        '${project.path}${Platform.pathSeparator}photos',
      );
      try {
        await photosLink.create(outside.path);
      } on FileSystemException {
        return;
      }
      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>().having(
            (error) => error.kind,
            'kind',
            PhotoImportFailureKind.invalidPhotosDirectory,
          ),
        ),
      );
      expect(await outside.list().isEmpty, isTrue);
      expect(writer.requests, isEmpty);
    });

    test('cleans final only for proven no-event and preserves uncertain copy',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final source = _sourceFile(sources, 'board.webp', <int>[5, 4, 3, 2, 1]);
      final ids = _queuedIds(<String>[
        'photo_no_event',
        'photo_uncertain',
        'photo_durable',
      ]);
      var durability = PhotoEventDurability.provenNoEvent;
      final writer = _FakePhotoEventWriter((projectState, request) async {
        throw PhotoEventWriteException(
          PhotoEventWriteFailureKind.append,
          'writer failed',
          durability: durability,
        );
      });
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => ids.removeAt(0),
      );

      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>()
              .having(
                (error) => error.kind,
                'kind',
                PhotoImportFailureKind.writerRejected,
              )
              .having((error) => error.copyPreserved, 'copy', isFalse),
        ),
      );
      expect(
        await File(
          '${project.path}${Platform.pathSeparator}photos${Platform.pathSeparator}photo_no_event.webp',
        ).exists(),
        isFalse,
      );

      durability = PhotoEventDurability.uncertain;
      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>()
              .having(
                (error) => error.kind,
                'kind',
                PhotoImportFailureKind.writerUncertain,
              )
              .having((error) => error.copyPreserved, 'copy', isTrue),
        ),
      );
      expect(
        await File(
          '${project.path}${Platform.pathSeparator}photos${Platform.pathSeparator}photo_uncertain.webp',
        ).readAsBytes(),
        <int>[5, 4, 3, 2, 1],
      );

      durability = PhotoEventDurability.durable;
      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>()
              .having(
                (error) => error.kind,
                'kind',
                PhotoImportFailureKind.writerUncertain,
              )
              .having((error) => error.copyPreserved, 'copy', isTrue),
        ),
      );
      expect(
        await File(
          '${project.path}${Platform.pathSeparator}photos${Platform.pathSeparator}photo_durable.webp',
        ).readAsBytes(),
        <int>[5, 4, 3, 2, 1],
      );
    });

    test('copy failure cleans invocation temp and creates no event', () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final source = _sourceFile(sources, 'board.png', <int>[6, 7, 8]);
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () {
          source.deleteSync();
          return 'photo_copy_failure';
        },
      );

      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>().having(
            (error) => error.kind,
            'kind',
            PhotoImportFailureKind.copyFailed,
          ),
        ),
      );
      expect(writer.requests, isEmpty);
      final photos = Directory(
        '${project.path}${Platform.pathSeparator}photos',
      );
      expect(await photos.list().isEmpty, isTrue);
    });

    test('surfaces cleanup failure and never deletes outside exact owned file',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final source = _sourceFile(sources, 'board.jpg', <int>[9, 9, 9]);
      final unrelated = _sourceFile(project, 'unrelated.txt', <int>[1]);
      final writer = _FakePhotoEventWriter((projectState, request) async {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.validation,
          'candidate rejected',
          durability: PhotoEventDurability.provenNoEvent,
        );
      });
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => 'photo_cleanup_failure',
        ownedFileDeleter: (file) async {
          throw FileSystemException('simulated cleanup failure', file.path);
        },
      );

      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>()
              .having(
                (error) => error.kind,
                'kind',
                PhotoImportFailureKind.cleanupFailed,
              )
              .having((error) => error.copyPreserved, 'copy', isTrue),
        ),
      );
      expect(await unrelated.readAsBytes(), <int>[1]);
      expect(
        await File(
          '${project.path}${Platform.pathSeparator}photos${Platform.pathSeparator}photo_cleanup_failure.jpg',
        ).exists(),
        isTrue,
      );
    });

    test('finalization failure cleans only invocation temporary state',
        () async {
      final project =
          await Directory.systemTemp.createTemp('tracebench-photo-project-');
      final sources =
          await Directory.systemTemp.createTemp('tracebench-photo-source-');
      addTearDown(() => project.delete(recursive: true));
      addTearDown(() => sources.delete(recursive: true));
      final source = _sourceFile(sources, 'board.png', <int>[1, 3, 5, 7]);
      final writer = _FakePhotoEventWriter(
        (projectState, request) async => _success(request),
      );
      final service = LocalPhotoImportService(
        eventWriter: writer,
        photoIdGenerator: () => 'photo_finalize_failure',
        atomicFinalizer: (temporaryFile, finalFile) async {
          throw const FileSystemException('simulated finalization failure');
        },
      );

      await expectLater(
        service.importPhoto(
          projectState: _projectState(project),
          request: PhotoImportRequest(sourcePath: source.path, mode: 'normal'),
        ),
        throwsA(
          isA<PhotoImportException>().having(
            (error) => error.kind,
            'kind',
            PhotoImportFailureKind.finalizationFailed,
          ),
        ),
      );
      expect(writer.requests, isEmpty);
      final photos = Directory(
        '${project.path}${Platform.pathSeparator}photos',
      );
      expect(await photos.list().isEmpty, isTrue);
      expect(await source.readAsBytes(), <int>[1, 3, 5, 7]);
    });
  });
}
