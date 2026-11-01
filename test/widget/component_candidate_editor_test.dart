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

  group('candidate pointer transaction', () {
    testWidgets('click and sub-threshold wobble select without editing',
        (tester) async {
      final editor = controller()..addAt(const Offset(.5, .5));
      addTearDown(editor.dispose);
      editor.select(null);
      final before = editor.document;
      var completions = 0;
      await tester.pumpWidget(harness(
          editor, const Rect.fromLTWH(0, 0, 600, 300),
          onCompleted: () => completions++));
      final center =
          tester.getTopLeft(find.byKey(const ValueKey('candidate-canvas'))) +
              const Offset(300, 150);
      await tester.tapAt(center);
      final gesture = await tester.startGesture(center);
      await gesture.moveBy(const Offset(3, 2));
      await gesture.up();
      await tester.pump();
      expect(editor.selectedDraftKey, 1);
      expect(editor.document, same(before));
      expect(completions, 0);
      expect(editor.isDragging, isFalse);
    });

    testWidgets('BB-02 frame reflow cannot turn wobble into an edit',
        (tester) async {
      final editor = controller()..addAt(const Offset(.3, .5));
      addTearDown(editor.dispose);
      final before = editor.document;
      var completions = 0;
      var narrow = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: StatefulBuilder(builder: (context, setState) {
          return Stack(children: [
            Positioned(
              left: narrow ? 120 : 0,
              top: 0,
              width: narrow ? 300 : 600,
              height: 300,
              child: ComponentCandidateEditor.surface(
                controller: editor,
                referenceRect: Rect.fromLTWH(0, 0, narrow ? 300 : 600, 300),
                onSelectionChanged: () => setState(() => narrow = true),
                onEditCompleted: () => completions++,
              ),
            ),
          ]);
        })),
      ));
      final gesture = await tester.startGesture(const Offset(180, 150));
      await tester.pump();
      expect(
          tester.getSize(find.byKey(const ValueKey('candidate-canvas'))).width,
          300);
      await gesture.moveBy(const Offset(3, 2));
      await gesture.up();
      await tester.pump();
      expect(editor.document.candidates.single.position, const Offset(.3, .5));
      expect(editor.document, same(before));
      expect(completions, 0);
    });

    testWidgets('BB-14 drag retains the grab offset and commits once on up',
        (tester) async {
      final editor = controller()..addAt(const Offset(.5, .5));
      addTearDown(editor.dispose);
      var completions = 0;
      await tester.pumpWidget(harness(
          editor, const Rect.fromLTWH(0, 0, 600, 300),
          onCompleted: () => completions++));
      final origin =
          tester.getTopLeft(find.byKey(const ValueKey('candidate-canvas')));
      final gesture =
          await tester.startGesture(origin + const Offset(310, 155));
      await gesture.moveBy(const Offset(30, 15));
      await tester.pump();
      expect(completions, 0);
      await gesture.up();
      await tester.pump();
      expect(
          editor.document.candidates.single.position, const Offset(.55, .55));
      expect(completions, 1);
    });

    testWidgets(
        'cancelled drag discards its preview without completing an edit',
        (tester) async {
      final editor = controller()..addAt(const Offset(.5, .5));
      addTearDown(editor.dispose);
      final before = editor.document;
      var completions = 0;
      await tester.pumpWidget(harness(
          editor, const Rect.fromLTWH(0, 0, 600, 300),
          onCompleted: () => completions++));
      final start =
          tester.getTopLeft(find.byKey(const ValueKey('candidate-canvas'))) +
              const Offset(300, 150);
      final gesture = await tester.startGesture(start);
      await gesture.moveBy(const Offset(60, 30));
      await tester.pump();
      await gesture.cancel();
      await tester.pump();
      expect(editor.document, same(before));
      expect(completions, 0);
      expect(editor.isDragging, isFalse);
    });

    testWidgets('intentional drag survives a changed frame and surface origin',
        (tester) async {
      final editor = controller()..addAt(const Offset(.3, .5));
      addTearDown(editor.dispose);
      final before = editor.document;
      var narrow = false;
      var completions = 0;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: StatefulBuilder(builder: (context, setState) {
          return Stack(children: [
            Positioned(
              left: narrow ? 120 : 0,
              top: 0,
              width: narrow ? 300 : 600,
              height: 300,
              child: ComponentCandidateEditor.surface(
                controller: editor,
                referenceRect: Rect.fromLTWH(0, 0, narrow ? 300 : 600, 300),
                onSelectionChanged: () => setState(() => narrow = true),
                onEditCompleted: () => completions++,
              ),
            ),
          ]);
        })),
      ));
      final gesture = await tester.startGesture(const Offset(190, 155));
      await tester.pump();
      await gesture.moveBy(const Offset(30, 30));
      await tester.pump();
      expect(editor.document, same(before));
      final preview = tester
          .widget<CustomPaint>(find.byKey(const ValueKey('candidate-painter')))
          .painter! as ComponentCandidatePainter;
      expect(preview.candidates.single.position, const Offset(.4, .6));
      await gesture.up();
      await tester.pump();
      expect(editor.document.candidates.single.position, const Offset(.4, .6));
      expect(completions, 1);
    });

    testWidgets(
        'scaled surface measures slop globally and displacement locally',
        (tester) async {
      final editor = controller()..addAt(const Offset(.5, .5));
      addTearDown(editor.dispose);
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: Align(
        alignment: Alignment.topLeft,
        child: Transform.scale(
          scale: 2,
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 300,
            height: 150,
            child: ComponentCandidateEditor.surface(
                controller: editor,
                referenceRect: const Rect.fromLTWH(0, 0, 300, 150)),
          ),
        ),
      ))));
      final gesture = await tester.startGesture(const Offset(310, 160));
      await gesture.moveBy(const Offset(60, 30));
      await gesture.up();
      await tester.pump();
      expect(editor.document.candidates.single.position, const Offset(.6, .6));
    });

    testWidgets('another pointer cannot complete or retarget a held drag',
        (tester) async {
      final editor = controller()..addAt(const Offset(.5, .5));
      addTearDown(editor.dispose);
      final before = editor.document;
      var completions = 0;
      await tester.pumpWidget(harness(
          editor, const Rect.fromLTWH(0, 0, 600, 300),
          onCompleted: () => completions++));
      final origin =
          tester.getTopLeft(find.byKey(const ValueKey('candidate-canvas')));
      final owner = await tester.startGesture(origin + const Offset(300, 150),
          pointer: 7);
      await owner.moveBy(const Offset(60, 30));
      final other = await tester.startGesture(origin + const Offset(420, 180),
          pointer: 8);
      await other.moveBy(const Offset(30, 15));
      await other.up();
      await tester.pump();
      expect(editor.document, same(before));
      expect(completions, 0);
      await owner.up();
      await tester.pump();
      expect(editor.document.candidates.single.position, const Offset(.6, .6));
      expect(editor.document.candidates.length, 1);
      expect(completions, 1);
    });

    for (final interruption in ['disabled', 'replaced', 'deselected']) {
      testWidgets('$interruption transaction cannot commit on pointer-up',
          (tester) async {
        final editor = controller()..addAt(const Offset(.5, .5));
        addTearDown(editor.dispose);
        var enabled = true;
        var completions = 0;
        late StateSetter rebuild;
        await tester
            .pumpWidget(MaterialApp(home: Scaffold(body: StatefulBuilder(
          builder: (context, setState) {
            rebuild = setState;
            return SizedBox(
                width: 600,
                height: 300,
                child: ComponentCandidateEditor.surface(
                    controller: editor,
                    enabled: enabled,
                    referenceRect: const Rect.fromLTWH(0, 0, 600, 300),
                    onEditCompleted: () => completions++));
          },
        ))));
        final gesture = await tester.startGesture(const Offset(300, 150));
        await gesture.moveBy(const Offset(60, 30));
        await tester.pump();
        if (interruption == 'disabled') {
          rebuild(() => enabled = false);
        } else if (interruption == 'replaced') {
          editor.replaceDocument(
              ComponentCandidateDocument.seed(projectId: 'new-context'));
        } else {
          editor.select(null);
        }
        final expected = editor.document;
        await tester.pump();
        await gesture.up();
        await tester.pump();
        expect(editor.document, same(expected));
        expect(completions, 0);
        expect(editor.isDragging, isFalse);
        if (interruption == 'deselected') {
          expect(editor.selectedDraftKey, isNull);
        }
      });
    }
  });
}
