import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/vocabulary/component_types.dart';

void main() {
  test('component catalogue preserves code order and descriptive labels', () {
    expect(componentTypeLabels.keys, [
      'unknown',
      'passive',
      'ic',
      'connector',
      'regulator',
    ]);
    expect(componentTypeLabels.values, [
      'Generic / unclassified',
      'Resistor / capacitor / diode / passive',
      'IC dual-side / quad-side / dense grid',
      'Connector / header',
      'Regulator / relay / module',
    ]);
  });

  for (final (raw, expected) in <(String?, String)>[
    ('unknown', 'unknown'),
    (' passive ', 'passive'),
    ('\tIC\n', 'ic'),
    ('ConNector', 'connector'),
    (' REGULATOR ', 'regulator'),
    (null, 'unknown'),
    ('', 'unknown'),
    (' \t\n', 'unknown'),
    ('resistor', 'unknown'),
    ('passive extra', 'unknown'),
  ]) {
    test('normalizes $raw to $expected without inventing another type', () {
      expect(normalizeComponentType(raw), expected);
    });
  }
}
