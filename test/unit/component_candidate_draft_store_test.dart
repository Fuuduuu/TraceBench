import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/component_candidates/models/component_candidate_draft.dart';
import 'package:trace_bench_viewer/features/component_candidates/services/component_candidate_draft_store.dart';

import 'component_candidate_draft_test.dart' as fixtures;

void main() {
  late Directory project;
  late ComponentCandidateDocument seed;
  const store = ComponentCandidateDraftStore();
  File sidecar() =>
      File('${project.path}/.tracebench_local/component_candidates.json');

  setUp(() async {
    project = await Directory.systemTemp.createTemp('candidate-draft-test-');
    seed = ComponentCandidateDocument.seed(
        projectId: 'board-a', intake: fixtures.intake());
  });
  tearDown(() async {
    if (await project.exists()) await project.delete(recursive: true);
  });

  test('missing load returns seed and never creates local folder', () async {
    final snapshot = await store.load(project.path, seed);
    expect(snapshot.document, same(seed));
    expect(snapshot.revision, isNull);
    expect(await project.list().toList(), isEmpty);
  });

  test('save reload retains deleted keys and revision hashes actual bytes',
      () async {
    final first = await store.save(project.path, seed, expectedRevision: null);
    expect(first.revision,
        sha256.convert(await sidecar().readAsBytes()).toString());
    final deleted = seed.copyWith(candidates: [], nextDraftKey: 41);
    await store.save(project.path, deleted, expectedRevision: first.revision);
    final reopened = await store.load(project.path, seed);
    expect(reopened.document.nextDraftKey, 41);
    expect(reopened.document.candidates, isEmpty);
    expect((await sidecar().parent.list().toList()).length, 1);
  });

  test('foreign project intake and frame cannot load or overwrite', () async {
    final snapshot =
        await store.save(project.path, seed, expectedRevision: null);
    final bytes = await sidecar().readAsBytes();
    final frameJson = seed.toJson()..['reference_frame_aspect_ratio'] = 2.0;
    final foreign = [
      ComponentCandidateDocument.seed(
          projectId: 'board-b', intake: fixtures.intake()),
      ComponentCandidateDocument.seed(
          projectId: 'board-a',
          intake: fixtures.intake(description: 'Changed')),
      ComponentCandidateDocument.fromJson(frameJson),
    ];
    for (final document in foreign) {
      await expectLater(
          store.load(project.path, document), throwsFormatException);
      await expectLater(
          store.save(project.path, document,
              expectedRevision: snapshot.revision),
          throwsFormatException);
      expect(await sidecar().readAsBytes(), bytes);
    }
  });

  test('corrupt file never overwritten even with its exact revision', () async {
    await sidecar().parent.create();
    final bytes = utf8.encode('{broken');
    await sidecar().writeAsBytes(bytes);
    await expectLater(store.load(project.path, seed), throwsFormatException);
    await expectLater(
        store.save(project.path, seed,
            expectedRevision: sha256.convert(bytes).toString()),
        throwsFormatException);
    expect(await sidecar().readAsBytes(), bytes);
  });

  test('stale revision and lowering saved high water are rejected', () async {
    final first = await store.save(project.path, seed, expectedRevision: null);
    final second = await store.save(
        project.path, seed.copyWith(candidates: [], nextDraftKey: 60),
        expectedRevision: first.revision);
    final bytes = await sidecar().readAsBytes();
    await expectLater(store.save(project.path, seed, expectedRevision: null),
        throwsFormatException);
    await expectLater(
        store.save(project.path, seed, expectedRevision: first.revision),
        throwsFormatException);
    await expectLater(
        store.save(project.path, seed, expectedRevision: second.revision),
        throwsFormatException);
    expect(await sidecar().readAsBytes(), bytes);
  });

  test('load rejects a high water below original imported keys', () async {
    await sidecar().parent.create();
    final json = seed.copyWith(candidates: []).toJson()..['next_draft_key'] = 1;
    await sidecar().writeAsString(jsonEncode(json));
    await expectLater(store.load(project.path, seed), throwsFormatException);
  });

  test('concurrent saves with one expected revision produce exactly one winner',
      () async {
    final outcomes = await Future.wait(List.generate(2, (_) async {
      try {
        await store.save(project.path, seed, expectedRevision: null);
        return true;
      } on FormatException {
        return false;
      }
    }));
    expect(outcomes.where((won) => won).length, 1);
    expect((await store.load(project.path, seed)).document.nextDraftKey, 18);
  });

  test('foreign lock preserved and valid bytes survive failed save', () async {
    final first = await store.save(project.path, seed, expectedRevision: null);
    final bytes = await sidecar().readAsBytes();
    final lock = File('${sidecar().parent.path}/component_candidates.lock');
    await lock.writeAsString('another process');
    await expectLater(
        store.save(project.path, seed, expectedRevision: first.revision),
        throwsFormatException);
    expect(await lock.readAsString(), 'another process');
    expect(await sidecar().readAsBytes(), bytes);
  });

  test('navigation paths rejected before any folder writes', () async {
    final badPath = '${project.path}/child/..';
    await expectLater(store.save(badPath, seed, expectedRevision: null),
        throwsFormatException);
    expect(await project.list().toList(), isEmpty);
  });

  for (final failWriting in [false, true]) {
    test(
        'failed atomic ${failWriting ? 'write' : 'rename'} preserves valid bytes and removes owned temporary resources',
        () async {
      final first =
          await store.save(project.path, seed, expectedRevision: null);
      final bytes = await sidecar().readAsBytes();
      await IOOverrides.runWithIOOverrides(() async {
        await expectLater(
            store.save(project.path, seed.copyWith(candidates: []),
                expectedRevision: first.revision),
            throwsA(isA<FileSystemException>()));
      }, _FailingTemporaryOverrides(failWriting));
      expect(await sidecar().readAsBytes(), bytes);
      expect((await sidecar().parent.list().toList()).length, 1);
      expect(
          (await store.load(project.path, seed))
              .document
              .candidates
              .single
              .draftKey,
          17);
    });
  }

  test(
      'failure writing an owned lock cleans it up without touching saved bytes',
      () async {
    final first = await store.save(project.path, seed, expectedRevision: null);
    final bytes = await sidecar().readAsBytes();
    await IOOverrides.runWithIOOverrides(() async {
      await expectLater(
          store.save(project.path, seed, expectedRevision: first.revision),
          throwsA(isA<FileSystemException>()));
    }, _FailingTemporaryOverrides(false, failLock: true));
    expect(await sidecar().readAsBytes(), bytes);
    expect((await sidecar().parent.list().toList()).length, 1);
  });

  test('linked local folder and linked sidecar rejected if links supported',
      () async {
    final outside = await Directory.systemTemp.createTemp('candidate-outside-');
    final link = Link('${project.path}/.tracebench_local');
    try {
      try {
        await link.create(outside.path);
      } on FileSystemException {
        markTestSkipped(
            'Symbolic-link creation is unavailable in this Windows environment.');
        return; // Windows environments may not grant symbolic-link privileges.
      }
      await expectLater(store.load(project.path, seed), throwsFormatException);
      await expectLater(store.save(project.path, seed, expectedRevision: null),
          throwsFormatException);
      expect(await outside.list().toList(), isEmpty);
      await link.delete();
      await sidecar().parent.create();
      final externalFile = File('${outside.path}/draft.json');
      await externalFile.writeAsString('untouched');
      final fileLink = Link(sidecar().path);
      await fileLink.create(externalFile.path);
      await expectLater(store.save(project.path, seed, expectedRevision: null),
          throwsFormatException);
      expect(await externalFile.readAsString(), 'untouched');
      await fileLink.delete();
    } finally {
      if (await link.exists()) await link.delete();
      await outside.delete(recursive: true);
    }
  });
}

final class _FailingTemporaryOverrides extends IOOverrides {
  _FailingTemporaryOverrides(this.failWriting, {this.failLock = false});
  final bool failWriting;
  final bool failLock;

  @override
  File createFile(String path) {
    final file = super.createFile(path);
    return path.endsWith('.tmp') || failLock && path.endsWith('.lock')
        ? _FailingTemporaryFile(file, failWriting, failLock: failLock)
        : file;
  }
}

class _FailingTemporaryFile implements File {
  _FailingTemporaryFile(this.file, this.failWriting, {this.failLock = false});
  final File file;
  final bool failWriting;
  final bool failLock;

  @override
  String get path => file.path;
  @override
  Future<String> readAsString({Encoding encoding = utf8}) =>
      file.readAsString(encoding: encoding);
  @override
  Future<File> writeAsString(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    if (failLock) {
      throw const FileSystemException('injected owned lock write failure');
    }
    return file.writeAsString(contents,
        mode: mode, encoding: encoding, flush: flush);
  }

  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) =>
      file.create(recursive: recursive, exclusive: exclusive);
  @override
  Future<File> writeAsBytes(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    if (failWriting) {
      throw const FileSystemException('injected temporary write failure');
    }
    return file.writeAsBytes(bytes, mode: mode, flush: flush);
  }

  @override
  Future<File> rename(String newPath) =>
      throw const FileSystemException('injected atomic rename failure');
  @override
  Future<bool> exists() => file.exists();
  @override
  Future<FileSystemEntity> delete({bool recursive = false}) =>
      file.delete(recursive: recursive);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
