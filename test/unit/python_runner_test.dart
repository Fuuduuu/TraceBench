import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';

class _RunCall {
  const _RunCall({
    required this.command,
    required this.workingDirectory,
  });

  final List<String> command;
  final String workingDirectory;
}

class _FakeProcessRunner extends ProcessRunner {
  _FakeProcessRunner(this._handler);

  final ProcessResult Function(
    List<String> command,
    String workingDirectory,
    Duration timeout,
  ) _handler;

  final List<_RunCall> calls = <_RunCall>[];

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    calls.add(
      _RunCall(
        command: List<String>.from(command),
        workingDirectory: workingDirectory,
      ),
    );
    return _handler(command, workingDirectory, timeout);
  }
}

ProcessResult _success([String stdout = 'ok']) =>
    ProcessResult(0, 0, stdout, '');
ProcessResult _failure([String stderr = 'failed']) =>
    ProcessResult(0, 1, '', stderr);

void main() {
  group('PythonRunner', () {
    test('discovery tries py -3 before python3/python', () async {
      final runner = _FakeProcessRunner((command, _, __) {
        if (command.first == 'py' && command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _failure();
      });
      final pythonRunner = PythonRunner(
        processRunner: runner,
        repoRootPath: Directory.systemTemp.path,
      );

      final command = await pythonRunner.discoverPythonCommand();

      expect(command, equals(<String>['py', '-3']));
      expect(runner.calls.first.command,
          equals(<String>['py', '-3', '--version']));
      expect(
        runner.calls.any((call) => call.command.first == 'python3'),
        isFalse,
      );
      expect(
        runner.calls.any((call) => call.command.first == 'python'),
        isFalse,
      );
    });

    test('falls back to python3 when py -3 is unavailable', () async {
      final runner = _FakeProcessRunner((command, _, __) {
        if (command.first == 'py') {
          return _failure('missing');
        }
        if (command.first == 'python3') {
          return _success('Python 3.11');
        }
        return _failure();
      });
      final pythonRunner = PythonRunner(
        processRunner: runner,
        repoRootPath: Directory.systemTemp.path,
      );

      final command = await pythonRunner.discoverPythonCommand();

      expect(command, equals(<String>['python3']));
      expect(
        runner.calls.map((call) => call.command.join(' ')),
        containsAllInOrder(
          <String>['py -3 --version', 'python3 --version'],
        ),
      );
    });

    test('falls back to python when py -3 and python3 are unavailable',
        () async {
      final runner = _FakeProcessRunner((command, _, __) {
        if (command.first == 'python') {
          return _success('Python 3.10');
        }
        return _failure();
      });
      final pythonRunner = PythonRunner(
        processRunner: runner,
        repoRootPath: Directory.systemTemp.path,
      );

      final command = await pythonRunner.discoverPythonCommand();

      expect(command, equals(<String>['python']));
      expect(
        runner.calls.map((call) => call.command.join(' ')),
        containsAllInOrder(
          <String>['py -3 --version', 'python3 --version', 'python --version'],
        ),
      );
    });

    test('returns null when no python candidate is available', () async {
      final runner = _FakeProcessRunner((_, __, ___) => _failure('no python'));
      final pythonRunner = PythonRunner(
        processRunner: runner,
        repoRootPath: Directory.systemTemp.path,
      );

      final command = await pythonRunner.discoverPythonCommand();

      expect(command, isNull);
    });

    test('run passes script and args correctly', () async {
      final runner = _FakeProcessRunner((command, workingDirectory, _) {
        expect(
            command, equals(<String>['python3', 'tools/script.py', 'a', 'b']));
        expect(workingDirectory, equals('C:/repo'));
        return _success();
      });
      final pythonRunner = PythonRunner(
        processRunner: runner,
        repoRootPath: 'C:/repo',
      );

      final result = await pythonRunner.run(
        command: const <String>['python3', 'tools/script.py', 'a', 'b'],
      );

      expect(result.exitCode, 0);
    });

    test('run executes through process runner', () async {
      final runner = _FakeProcessRunner((_, __, ___) => _success());
      final pythonRunner = PythonRunner(
        processRunner: runner,
        repoRootPath: Directory.systemTemp.path,
      );

      await pythonRunner.run(
        command: const <String>['python', '--version'],
      );

      expect(
          runner.calls.single.command, equals(<String>['python', '--version']));
    });
  });
}
