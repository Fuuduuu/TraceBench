/// Ordered component codes and their descriptive Canvas labels.
/// Callers that display raw codes use the keys directly.
const Map<String, String> componentTypeLabels = {
  'unknown': 'Generic / unclassified',
  'passive': 'Resistor / capacitor / diode / passive',
  'ic': 'IC dual-side / quad-side / dense grid',
  'connector': 'Connector / header',
  'regulator': 'Regulator / relay / module',
};

String normalizeComponentType(String? rawValue) {
  final value = rawValue?.trim().toLowerCase() ?? '';
  return componentTypeLabels.containsKey(value) ? value : 'unknown';
}
