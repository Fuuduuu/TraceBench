import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/vocabulary/measurement_units.dart';

void main() {
  test('measurement catalogue preserves ordered labels, modes and schema units',
      () {
    expect(
      measurementUnitOptions
          .map((unit) => (unit.label, unit.mode, unit.schemaUnit)),
      [
        ('V', 'voltage', 'V'),
        ('Ω', 'resistance', 'Ω'),
        ('Diode', 'diode', 'diode'),
        ('Beep', 'continuity', 'beep'),
      ],
    );
  });

  for (final (label, mode, schemaUnit) in [
    ('V', 'voltage', 'V'),
    ('Ω', 'resistance', 'Ω'),
    ('Diode', 'diode', 'diode'),
    ('Beep', 'continuity', 'beep'),
  ]) {
    test('$label resolves to $mode / $schemaUnit', () {
      final unit = measurementUnitForLabel(label);
      expect(
          (unit.label, unit.mode, unit.schemaUnit), (label, mode, schemaUnit));
    });
  }

  for (final label in ['', 'unknown', 'diode', ' V ', 'Ω ']) {
    test('unrecognized unit $label retains the Canvas V default', () {
      final unit = measurementUnitForLabel(label);
      expect((unit.label, unit.mode, unit.schemaUnit), ('V', 'voltage', 'V'));
    });
  }
}
