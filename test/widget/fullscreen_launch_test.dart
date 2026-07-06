import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pubspec declares window manager dependency', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final lockfile = File('pubspec.lock').readAsStringSync();

    expect(
      pubspec,
      matches(RegExp(r'^\s*window_manager:\s*\^?0\.5\.2\s*$', multiLine: true)),
    );
    expect(lockfile, contains('window_manager:'));
    expect(lockfile, contains('version: "0.5.2"'));
  });

  test('main requests fullscreen before rendering TraceBenchApp', () {
    final source = File('lib/main.dart').readAsStringSync();

    expect(source,
        contains("import 'package:window_manager/window_manager.dart';"));
    expect(source, contains('Future<void> configureFullscreenLaunch() async'));
    expect(source, contains('windowManager.ensureInitialized()'));
    expect(source, contains('windowManager.setFullScreen(true)'));
    expect(source,
        contains('runApp(const ProviderScope(child: TraceBenchApp()))'));

    final bindingIndex =
        source.indexOf('WidgetsFlutterBinding.ensureInitialized()');
    final helperAwaitIndex =
        source.indexOf('await configureFullscreenLaunch()');
    final runAppIndex = source.indexOf('runApp(');
    final windowEnsureIndex =
        source.indexOf('windowManager.ensureInitialized()');
    final fullscreenIndex = source.indexOf('windowManager.setFullScreen(true)');

    expect(bindingIndex, isNonNegative);
    expect(helperAwaitIndex, isNonNegative);
    expect(runAppIndex, isNonNegative);
    expect(windowEnsureIndex, isNonNegative);
    expect(fullscreenIndex, isNonNegative);
    expect(windowEnsureIndex, lessThan(fullscreenIndex));
    expect(bindingIndex, lessThan(helperAwaitIndex));
    expect(helperAwaitIndex, lessThan(runAppIndex));
    expect(fullscreenIndex, lessThan(runAppIndex));
  });

  test('main stays app-shell only', () {
    final source = File('lib/main.dart').readAsStringSync();

    expect(source, isNot(contains('SystemChrome.setEnabledSystemUIMode')));
    expect(source, isNot(contains('go_router')));
    expect(source, isNot(contains('/fullscreen')));
    expect(source, isNot(contains('/splash')));
    expect(source, isNot(contains('home_screen')));
    expect(source, isNot(contains('board_canvas')));
    expect(source, isNot(contains('windows/')));
    expect(source, isNot(contains('Win32Window')));
    expect(source, isNot(contains('_incoming')));
    expect(source, isNot(contains('events.jsonl')));
    expect(source, isNot(contains('known_facts.json')));
  });
}
