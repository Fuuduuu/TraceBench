class MeasurementUnitOption {
  const MeasurementUnitOption({
    required this.label,
    required this.mode,
    required this.schemaUnit,
  });

  final String label;
  final String mode;
  final String schemaUnit;
}

const List<MeasurementUnitOption> measurementUnitOptions = [
  MeasurementUnitOption(label: 'V', mode: 'voltage', schemaUnit: 'V'),
  MeasurementUnitOption(label: 'Ω', mode: 'resistance', schemaUnit: 'Ω'),
  MeasurementUnitOption(label: 'Diode', mode: 'diode', schemaUnit: 'diode'),
  MeasurementUnitOption(label: 'Beep', mode: 'continuity', schemaUnit: 'beep'),
];

/// Canvas lookup keeps its exact-label matching and V fallback.
/// Forms that require an explicit choice retain their own nullable selection.
MeasurementUnitOption measurementUnitForLabel(String label) {
  return measurementUnitOptions.firstWhere(
    (option) => option.label == label,
    orElse: () => measurementUnitOptions.first,
  );
}
