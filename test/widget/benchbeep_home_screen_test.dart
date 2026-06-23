import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:trace_bench_viewer/app/app.dart';

class _FakeFilePicker extends FilePicker {
  _FakeFilePicker(this.result);

  final FilePickerResult? result;
  var pickCount = 0;
  FileType? requestedType;
  List<String>? requestedExtensions;
  bool? requestedWithData;
  bool? requestedAllowMultiple;

  @override
  Future<FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    bool allowCompression = true,
    int compressionQuality = 30,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    bool readSequential = false,
  }) async {
    pickCount += 1;
    requestedType = type;
    requestedExtensions = allowedExtensions;
    requestedWithData = withData;
    requestedAllowMultiple = allowMultiple;
    return result;
  }
}

void main() {
  testWidgets('BenchBeep Home is a board-selection launcher', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(find.byKey(const ValueKey('benchbeep_home_title')), findsOneWidget);
    expect(find.text('BenchBeep'), findsAtLeastNWidgets(1));
    expect(find.text('Bench instrument launcher'), findsOneWidget);
    expect(find.text('TraceBench platform'), findsOneWidget);
    expect(find.text('TraceBench Viewer'), findsOneWidget);
    expect(find.byKey(const ValueKey('benchbeep_app_menu_bar')), findsOneWidget);
    expect(find.byKey(const ValueKey('benchbeep_menu_home_item')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('benchbeep_menu_workbench_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_menu_import_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_menu_new_project_deferred')),
      findsOneWidget,
    );
    final deferredNewProject = tester.widget<OutlinedButton>(
      find.byKey(const ValueKey('benchbeep_menu_new_project_deferred')),
    );
    expect(deferredNewProject.onPressed, isNull);
    expect(find.byKey(const ValueKey('benchbeep_home_board_card')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('benchbeep_home_open_workbench_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_home_import_project_button')),
      findsOneWidget,
    );
    expect(find.text('Import project'), findsOneWidget);
    expect(find.text('existing ZIP flow'), findsOneWidget);
    expect(find.text('Ava näidisprojekt'), findsOneWidget);
    expect(find.text('Ava projekt'), findsNothing);
    expect(find.byKey(const ValueKey('benchbeep_home_safety_strip')), findsNothing);
    expect(find.text('Load sample'), findsNothing);
    expect(find.textContaining('Launcher only'), findsNothing);

    expect(find.textContaining('marketing'), findsNothing);
    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('launcher preserves bundled sample project handoff', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester.tap(find.text('Ava näidisprojekt'));
    await tester.pumpAndSettle();

    expect(find.text('Ava projekt'), findsOneWidget);

    await tester.tap(find.text('Ava projekt'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsNothing);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')), findsOneWidget);
    expect(find.text('Project overview'), findsOneWidget);
  });

  testWidgets('launcher opens the existing Workbench router', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester.tap(
      find.byKey(const ValueKey('benchbeep_home_open_workbench_button')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsNothing);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')), findsOneWidget);

    final workbenchApp = tester.widget<MaterialApp>(
      find.byKey(const ValueKey('benchbeep_workbench_router')),
    );
    (workbenchApp.routerConfig! as GoRouter).go('/');
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(find.text('BenchBeep'), findsOneWidget);
    expect(find.text('Import Project ZIP'), findsNothing);
    expect(find.text('Read-only Project ZIP Viewer'), findsNothing);

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('launcher menu workbench affordance opens existing router', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester.tap(
      find.byKey(const ValueKey('benchbeep_menu_workbench_button')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsNothing);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')), findsOneWidget);
    expect(find.text('Board Canvas'), findsAtLeastNWidgets(1));

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('launcher import project invokes existing ZIP flow directly', (
    tester,
  ) async {
    FilePicker? originalPicker;
    try {
      originalPicker = FilePicker.platform;
    } catch (_) {
      originalPicker = null;
    }
    final fakePicker = _FakeFilePicker(null);
    FilePicker.platform = fakePicker;
    addTearDown(() {
      final pickerToRestore = originalPicker;
      if (pickerToRestore != null) {
        FilePicker.platform = pickerToRestore;
      }
    });

    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester.tap(
      find.byKey(const ValueKey('benchbeep_home_import_project_button')),
    );
    await tester.pumpAndSettle();

    expect(fakePicker.pickCount, 1);
    expect(fakePicker.requestedType, FileType.custom);
    expect(fakePicker.requestedExtensions, const ['zip']);
    expect(fakePicker.requestedWithData, isTrue);
    expect(fakePicker.requestedAllowMultiple, isFalse);
    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')), findsNothing);
    expect(find.text('Import Project ZIP'), findsNothing);
    expect(find.text('Read-only Project ZIP Viewer'), findsNothing);
    expect(find.text('existing ZIP flow'), findsOneWidget);

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('launcher menu import invokes existing ZIP flow directly', (
    tester,
  ) async {
    FilePicker? originalPicker;
    try {
      originalPicker = FilePicker.platform;
    } catch (_) {
      originalPicker = null;
    }
    final fakePicker = _FakeFilePicker(null);
    FilePicker.platform = fakePicker;
    addTearDown(() {
      final pickerToRestore = originalPicker;
      if (pickerToRestore != null) {
        FilePicker.platform = pickerToRestore;
      }
    });

    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester.tap(find.byKey(const ValueKey('benchbeep_menu_import_button')));
    await tester.pumpAndSettle();

    expect(fakePicker.pickCount, 1);
    expect(fakePicker.requestedType, FileType.custom);
    expect(fakePicker.requestedExtensions, const ['zip']);
    expect(fakePicker.requestedWithData, isTrue);
    expect(fakePicker.requestedAllowMultiple, isFalse);
    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')), findsNothing);
    expect(find.text('Import Project ZIP'), findsNothing);
    expect(find.text('Read-only Project ZIP Viewer'), findsNothing);

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });
}
