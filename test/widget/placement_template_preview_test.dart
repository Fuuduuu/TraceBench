import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/board_canvas/theme/board_canvas_palette.dart';
import 'package:trace_bench_viewer/features/board_canvas/widgets/placement_template_preview.dart';

Widget _harness(Widget child, {double width = 320}) => MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
              child: SizedBox(width: width, child: child))),
    );

PlacementTemplatePreviewPainter _painter(PlacementTemplateDefinition template,
        {int top = 0, int right = 0, int bottom = 0, int left = 0}) =>
    PlacementTemplatePreviewPainter(
        template: template,
        topContactMarkers: top,
        rightContactMarkers: right,
        bottomContactMarkers: bottom,
        leftContactMarkers: left);

void main() {
  test(
      'preview module imports independently without host, workflow or candidate dependencies',
      () {
    final source = File(
            'lib/features/board_canvas/widgets/placement_template_preview.dart')
        .readAsStringSync();
    for (final forbidden in [
      'board_canvas_screen.dart',
      'board_canvas_placement_panel.dart',
      'project_session.dart',
      'v2_placement_writer.dart',
      'component_candidates/',
      'part of '
    ]) {
      expect(source, isNot(contains(forbidden)), reason: forbidden);
    }
  });

  test(
      'catalogue retains all seven IDs, ordering, labels, proportions and marker defaults',
      () {
    expect(starterPlacementTemplates.map((t) => t.id), [
      'template_family_rect_2_top_bottom',
      'template_family_rect_4_perimeter',
      'template_family_rect_6_edge_balance',
      'template_family_small_3_side_package',
      'template_family_connector_strip',
      'template_family_radial_round',
      'template_family_generic_blank',
    ]);
    expect(starterPlacementTemplates.map((t) => t.templateFamily), [
      'Rectangular chip',
      'Dual-row package',
      'Quad-row package',
      'Small 3-side package',
      'Connector strip',
      'Radial / round',
      'Generic blank',
    ]);
    expect(starterPlacementTemplates.map((t) => t.bodyAspectRatio),
        [2.4, 1.65, 1.2, 1.35, 4, 1, 2]);
    expect(
        starterPlacementTemplates.map((t) => (
              t.topContactMarkers,
              t.rightContactMarkers,
              t.bottomContactMarkers,
              t.leftContactMarkers
            )),
        [
          (1, 0, 1, 0),
          (0, 4, 0, 4),
          (2, 2, 2, 2),
          (1, 1, 1, 0),
          (4, 0, 0, 0),
          (1, 0, 1, 0),
          (0, 0, 0, 0),
        ]);
    expect(starterPlacementTemplates.map((t) => t.bodyShape), [
      PlacementTemplateBodyShape.rectangular,
      PlacementTemplateBodyShape.dualRow,
      PlacementTemplateBodyShape.quadRow,
      PlacementTemplateBodyShape.smallThreeSide,
      PlacementTemplateBodyShape.connectorStrip,
      PlacementTemplateBodyShape.radialRound,
      PlacementTemplateBodyShape.genericBlank,
    ]);
    expect(starterPlacementTemplates.map((t) => t.contactMarkerCount),
        [2, 8, 8, 3, 4, 2, 0]);
  });

  test('lookup preserves null/unknown handling and presentation fallbacks', () {
    for (final id in [null, '', ' ', 'not_in_catalogue']) {
      expect(placementTemplateById(id), isNull);
    }
    for (final template in starterPlacementTemplates) {
      expect(identical(placementTemplateById(' ${template.id} '), template),
          isTrue);
    }
    const custom = PlacementTemplateDefinition(
        id: 'not_in_catalogue',
        templateFamily: 'TEMPLATE FAMILY Custom — notes',
        topContactMarkers: 1,
        rightContactMarkers: 0,
        bottomContactMarkers: 0,
        leftContactMarkers: 0,
        example: 'Visual only');
    expect(custom.bodyShape, PlacementTemplateBodyShape.genericBlank);
    expect(custom.bodyAspectRatio, 2);
    expect(custom.shortTemplateShapeName, 'Custom');
    expect(custom.contactMarkerSummaryShort, '1 contact');
    expect(custom.contactMarkerSummary, 'Top: 1, Right: 0, Bottom: 0, Left: 0');
  });

  testWidgets(
      'chooser keeps keyed rows, mini shapes, selected styling and ID callback',
      (tester) async {
    String? chosen;
    final current = starterPlacementTemplates[1];
    await tester.pumpWidget(_harness(PlacementTemplateChooser(
        selectedTemplateId: current.id,
        onTemplateSelected: (value) => chosen = value)));
    final ys = <double>[];
    const miniSizes = [
      Size(20, 14),
      Size(20, 14),
      Size(26, 16),
      Size(16, 16),
      Size(26, 8),
      Size(14, 20),
      Size(20, 14)
    ];
    for (var index = 0; index < starterPlacementTemplates.length; index++) {
      final template = starterPlacementTemplates[index];
      final row =
          find.byKey(Key('board_canvas_add_component_template_${template.id}'));
      ys.add(tester.getTopLeft(row).dy);
      expect(find.text(template.shortTemplateShapeName), findsOneWidget);
      expect(
          tester.getSize(find.byKey(
              Key('board_canvas_add_component_template_shape_${template.id}'))),
          miniSizes[index]);
    }
    expect(ys, orderedEquals([...ys]..sort()));
    final selected = find.byKey(
        Key('board_canvas_add_component_template_${current.id}_selected'));
    expect(tester.widget<Icon>(selected).semanticLabel, 'selected');
    expect(tester.widget<Icon>(selected).color, BoardCanvasPalette.signal);
    final next = starterPlacementTemplates.last;
    await tester.ensureVisible(
        find.byKey(Key('board_canvas_add_component_template_${next.id}')));
    await tester
        .tap(find.byKey(Key('board_canvas_add_component_template_${next.id}')));
    expect(chosen, next.id);
    expect(selected, findsOneWidget,
        reason: 'The caller retains selected-template state.');
  });

  testWidgets(
      'selected summary retains contact count, draft badge and change callback',
      (tester) async {
    var changes = 0;
    final template = starterPlacementTemplates[1];
    await tester.pumpWidget(_harness(PlacementTemplateSelectedSummary(
        template: template, onChangeTemplate: () => changes++)));
    expect(find.text('Dual-row package'), findsOneWidget);
    expect(find.text('8 contacts'), findsOneWidget);
    expect(find.text('Mustand'), findsOneWidget);
    expect(
        find.byKey(
            Key('board_canvas_add_component_template_${template.id}_selected')),
        findsOneWidget);
    await tester.tap(
        find.byKey(const Key('board_canvas_add_component_change_template')));
    expect(changes, 1);
  });

  for (final index in List<int>.generate(7, (i) => i)) {
    testWidgets(
        'shape preview $index preserves body proportions and default marker geometry',
        (tester) async {
      final template = starterPlacementTemplates[index];
      await tester.pumpWidget(_harness(PlacementTemplatePreview(
          template: template,
          topContactMarkers: template.topContactMarkers,
          rightContactMarkers: template.rightContactMarkers,
          bottomContactMarkers: template.bottomContactMarkers,
          leftContactMarkers: template.leftContactMarkers)));
      final canvas =
          find.byKey(const Key('board_canvas_add_component_builder_preview'));
      final size = tester.getSize(canvas);
      expect(size.width / size.height, closeTo(template.bodyAspectRatio, 1e-9));
      expect(
          find.byKey(
              Key('board_canvas_add_component_builder_preview_${template.id}')),
          findsOneWidget);
      final painter = tester.widget<CustomPaint>(canvas).painter!
          as PlacementTemplatePreviewPainter;
      final recording = TestRecordingCanvas();
      painter.paint(recording, const Size(200, 100));
      final calls = recording.invocations.map((i) => i.invocation).toList();
      final pathCall = calls.singleWhere((i) => i.memberName == #drawPath);
      final path = pathCall.positionalArguments[0] as Path;
      final outline = pathCall.positionalArguments[1] as Paint;
      expect(outline.color.toARGB32(), const Color(0xFF5C6BC0).toARGB32());
      expect(outline.strokeWidth, closeTo(1.8, 1e-6));
      expect(
          path.getBounds(),
          template.isRoundTemplateBody
              ? const Rect.fromLTRB(62, 12, 138, 88)
              : const Rect.fromLTRB(12, 12, 188, 88));
      if (!template.isRoundTemplateBody) {
        expect(path.contains(const Offset(13, 13)),
            template.bodyShape == PlacementTemplateBodyShape.genericBlank);
      }
      final circles = calls.where((i) => i.memberName == #drawCircle).toList();
      expect(circles.length, template.contactMarkerCount);
      for (final circle in circles) {
        expect(circle.positionalArguments[1], 3.0);
        expect((circle.positionalArguments[2] as Paint).color.toARGB32(),
            const Color(0xFF2E7D32).toARGB32());
      }
      expect(tester.takeException(), isNull);
    });
  }

  test('explicit draft counts retain the four edge marker positions', () {
    final painter = _painter(starterPlacementTemplates.first,
        top: 1, right: 2, bottom: 3, left: 4);
    final recording = TestRecordingCanvas();
    painter.paint(recording, const Size(200, 100));
    final points = recording.invocations
        .map((i) => i.invocation)
        .where((i) => i.memberName == #drawCircle)
        .map((i) => i.positionalArguments[0] as Offset)
        .toList();
    const expected = [
      Offset(100, 12),
      Offset(188, 12 + 76 / 3),
      Offset(188, 12 + 152 / 3),
      Offset(56, 88),
      Offset(100, 88),
      Offset(144, 88),
      Offset(12, 27.2),
      Offset(12, 42.4),
      Offset(12, 57.6),
      Offset(12, 72.8)
    ];
    expect(points.length, expected.length);
    for (var i = 0; i < points.length; i++) {
      expect((points[i] - expected[i]).distance, lessThan(1e-9));
    }
  });

  test('zero-marker and repaint behavior retain the existing predicate', () {
    final template = starterPlacementTemplates.first;
    final before = _painter(template);
    final recording = TestRecordingCanvas();
    before.paint(recording, const Size(200, 100));
    expect(
        recording.invocations
            .where((i) => i.invocation.memberName == #drawCircle),
        isEmpty);
    expect(_painter(template).shouldRepaint(before), isFalse);
    expect(_painter(template, left: 1).shouldRepaint(before), isTrue);
    expect(
        _painter(starterPlacementTemplates.last).shouldRepaint(before), isTrue);
    expect(
        PlacementTemplatePreviewPainter(
                template: template,
                topContactMarkers: 0,
                rightContactMarkers: 0,
                bottomContactMarkers: 0,
                leftContactMarkers: 0,
                boundaryColor: Colors.red,
                markerColor: Colors.orange,
                fillColor: Colors.black,
                dashedBoundary: true,
                strokeWidth: 3)
            .shouldRepaint(before),
        isFalse);
  });

  testWidgets(
      'draft card preserves keyed size/rotation copy and dashed preview',
      (tester) async {
    await tester.pumpWidget(_harness(PlacementDraftPreviewCard(
        template: starterPlacementTemplates.first,
        draftWidth: .12,
        draftHeight: .08,
        draftRotationDeg: 90,
        topContactMarkers: 2,
        rightContactMarkers: 0,
        bottomContactMarkers: 2,
        leftContactMarkers: 0)));
    expect(find.text('Suurus: 0.12 × 0.08'), findsOneWidget);
    expect(find.text('Pööre: 90°'), findsOneWidget);
    expect(find.text('Draft / unsaved'), findsOneWidget);
    final painter = tester
        .widget<CustomPaint>(find.byKey(
            const Key('board_canvas_add_component_builder_local_preview')))
        .painter! as PlacementTemplatePreviewPainter;
    expect(painter.topContactMarkers, 2);
    expect(painter.bottomContactMarkers, 2);
    expect(painter.dashedBoundary, isTrue);
    expect(painter.strokeWidth, 2);
  });

  test(
      'the same painter retains Canvas ghost fill, boundary and marker overrides',
      () {
    final painter = PlacementTemplatePreviewPainter(
        template: starterPlacementTemplates.first,
        topContactMarkers: 1,
        rightContactMarkers: 0,
        bottomContactMarkers: 1,
        leftContactMarkers: 0,
        boundaryColor: BoardCanvasPalette.signal,
        markerColor: BoardCanvasPalette.navy,
        fillColor: BoardCanvasPalette.signalTint,
        dashedBoundary: true,
        strokeWidth: 2.1);
    final recording = TestRecordingCanvas();
    painter.paint(recording, const Size(200, 100));
    final paths = recording.invocations
        .map((i) => i.invocation)
        .where((i) => i.memberName == #drawPath)
        .toList();
    expect(paths.length, greaterThan(2));
    expect((paths.first.positionalArguments[1] as Paint).color.toARGB32(),
        BoardCanvasPalette.signalTint.toARGB32());
    for (final path in paths.skip(1)) {
      expect((path.positionalArguments[1] as Paint).color.toARGB32(),
          BoardCanvasPalette.signal.toARGB32());
      expect((path.positionalArguments[1] as Paint).strokeWidth,
          closeTo(2.1, 1e-6));
    }
    expect(
        recording.invocations
            .where((i) => i.invocation.memberName == #drawCircle)
            .length,
        2);
  });

  testWidgets('chooser and summary remain usable in compact and wide slots',
      (tester) async {
    for (final width in [240.0, 320.0]) {
      await tester.pumpWidget(_harness(
          Column(children: [
            PlacementTemplateChooser(
                selectedTemplateId: starterPlacementTemplates.first.id,
                onTemplateSelected: (_) {}),
            PlacementTemplateSelectedSummary(
                template: starterPlacementTemplates.last,
                onChangeTemplate: () {}),
          ]),
          width: width));
      expect(tester.takeException(), isNull);
    }
  });
}
