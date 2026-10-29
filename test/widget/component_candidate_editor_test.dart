import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/component_candidates/models/component_candidate_draft.dart';
import 'package:trace_bench_viewer/features/component_candidates/widgets/component_candidate_editor.dart';
import 'package:trace_bench_viewer/shared/models/wizard_intake.dart';
import 'package:trace_bench_viewer/shared/theme/app_theme.dart';

void main() {
  ComponentCandidateEditorController controller() =>
      ComponentCandidateEditorController(
        ComponentCandidateDocument.seed(projectId: 'editor-test'),
      );

  Widget harness(ComponentCandidateEditorController editor, Rect frame,
          {bool allowAdd = true, VoidCallback? onCompleted}) =>
      MaterialApp(
        theme: buildWorkbenchTheme(),
        home: Scaffold(
          body: Column(children: [
            SizedBox(
              width: 600,
              height: 300,
              child: ComponentCandidateEditor.surface(
                controller: editor,
                referenceRect: frame,
                allowAdd: allowAdd,
                onEditCompleted: onCompleted,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ComponentCandidateEditor.controls(
                  controller: editor,
                  onEditCompleted: onCompleted,
                ),
              ),
            ),
          ]),
        ),
      );

  testWidgets('one surface adds, selects, drags and uses the same controls',
      (tester) async {
    final editor = controller();
    addTearDown(editor.dispose);
    var completions = 0;
    const frame = Rect.fromLTWH(0, 0, 600, 300);
    await tester
        .pumpWidget(harness(editor, frame, onCompleted: () => completions++));
    final surface = find.byKey(const ValueKey('candidate-canvas'));
    final origin = tester.getTopLeft(surface);
    await tester.tapAt(origin + const Offset(120, 120));
    await tester.pump();
    expect(editor.document.candidates.single.draftKey, 1);
    expect(editor.selectedDraftKey, 1);
    await tester.tap(find.byKey(const ValueKey('candidate-shape-rectangle')));
    await tester.pump();
    await tester
        .ensureVisible(find.byKey(const ValueKey('candidate-rotate-plus')));
    await tester.tap(find.byKey(const ValueKey('candidate-rotate-plus')));
    await tester.pump();
    expect(editor.document.candidates.single.shape,
        WizardVisualCandidateShape.rectangle);
    expect(editor.document.candidates.single.rotationRadians,
        closeTo(math.pi / 12, 1e-9));
    await tester.dragFrom(
        origin + const Offset(120, 120), const Offset(180, 30));
    await tester.pump();
    expect(editor.document.candidates.single.position.dx, closeTo(.5, .001));
    expect(editor.document.candidates.single.position.dy, closeTo(.5, .001));
    expect(editor.document.candidates.length, 1);
    expect(completions, greaterThanOrEqualTo(4));
    expect(tester.takeException(), isNull);
  });

  testWidgets('overlap chooses nearest center, topmost on equal centers',
      (tester) async {
    final editor = controller();
    addTearDown(editor.dispose);
    editor.addAt(const Offset(.5, .5));
    editor.addAt(const Offset(.5, .5));
    await tester.pumpWidget(
        harness(editor, const Rect.fromLTWH(0, 0, 600, 300), allowAdd: false));
    await tester.tapAt(
        tester.getCenter(find.byKey(const ValueKey('candidate-canvas'))));
    await tester.pump();
    expect(editor.selectedDraftKey, 2);
    expect(editor.document.candidates.length, 2);
  });

  for (final aspect in [.5, 1.0, 2.0]) {
    testWidgets(
        'reference $aspect preserves pose on resize and ignores margins',
        (tester) async {
      final editor = controller();
      addTearDown(editor.dispose);
      final frame = Rect.fromCenter(
          center: const Offset(300, 150),
          width: aspect < 1 ? 150 : 300,
          height: aspect < 1 ? 300 : 300 / aspect);
      await tester.pumpWidget(harness(editor, frame));
      final origin =
          tester.getTopLeft(find.byKey(const ValueKey('candidate-canvas')));
      await tester.tapAt(origin + const Offset(1, 1));
      await tester.pump();
      expect(editor.document.candidates, isEmpty);
      await tester.tapAt(origin + frame.center);
      await tester.pump();
      final before = editor.document.candidates.single;
      editor.setSizeScale(2);
      editor.setRotation(math.pi / 3);
      final geometry =
          editor.geometryFor(editor.document.candidates.single, frame);
      expect(geometry.center, frame.center);
      expect(
          geometry.minorDimension, math.max(8, frame.shortestSide * .035 * 2));
      await tester.pumpWidget(harness(editor, frame.deflate(15)));
      expect(editor.document.candidates.single.position, before.position);
      expect(editor.document.candidates.single.draftKey, before.draftKey);
      expect(tester.takeException(), isNull);
    });
  }
}
