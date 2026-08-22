import '../../../shared/models/known_facts.dart';

bool measurementEndpointMatchesComponent(
  String endpoint,
  String componentId,
) {
  return endpoint == componentId || endpoint.startsWith('$componentId.');
}

EndpointDisplayParts endpointDisplayParts(String endpoint) {
  final trimmed = endpoint.trim();
  final dotIndex = trimmed.indexOf('.');
  if (dotIndex <= 0 || dotIndex == trimmed.length - 1) {
    return EndpointDisplayParts(component: trimmed, pin: null);
  }
  return EndpointDisplayParts(
    component: trimmed.substring(0, dotIndex),
    pin: trimmed,
  );
}

class EndpointDisplayParts {
  const EndpointDisplayParts({required this.component, this.pin});

  final String component;
  final String? pin;
}

Map<String, int> measurementCountsByComponents({
  required List<MeasurementFact> measurements,
  required Set<String> componentIds,
}) {
  final counts = <String, int>{};
  for (final componentId in componentIds) {
    final measurementCount = measurements
        .where(
          (measurement) =>
              measurementEndpointMatchesComponent(
                  measurement.from, componentId) ||
              measurementEndpointMatchesComponent(measurement.to, componentId),
        )
        .length;
    if (measurementCount > 0) {
      counts[componentId] = measurementCount;
    }
  }
  return counts;
}

int measurementCountForComponent({
  required List<MeasurementFact> measurements,
  required String componentId,
}) {
  return measurements
      .where(
        (measurement) =>
            measurementEndpointMatchesComponent(
                measurement.from, componentId) ||
            measurementEndpointMatchesComponent(measurement.to, componentId),
      )
      .length;
}

Map<String, List<MeasurementFact>> measurementValueBadgesByComponents({
  required List<MeasurementFact> measurements,
  required Set<String> componentIds,
}) {
  final badgesByComponent = <String, List<MeasurementFact>>{};
  for (final componentId in componentIds) {
    final matches = <_IndexedMeasurement>[];
    for (var index = 0; index < measurements.length; index++) {
      final measurement = measurements[index];
      if (!measurementHasScalarValueAndUnit(measurement)) {
        continue;
      }
      if (measurementEndpointMatchesComponent(measurement.from, componentId) ||
          measurementEndpointMatchesComponent(measurement.to, componentId)) {
        matches.add(_IndexedMeasurement(index, measurement));
      }
    }
    if (matches.isEmpty) {
      continue;
    }
    matches.sort(_compareIndexedMeasurements);
    badgesByComponent[componentId] =
        matches.map((match) => match.measurement).toList(growable: false);
  }
  return badgesByComponent;
}

bool measurementHasScalarValueAndUnit(MeasurementFact measurement) {
  final unit = measurement.unit?.trim();
  if (unit == null || unit.isEmpty) {
    return false;
  }

  final value = measurement.value;
  if (value is num) {
    return value.isFinite;
  }
  if (value is String) {
    return value.trim().isNotEmpty;
  }
  return false;
}

String measurementValueBadgeText(MeasurementFact measurement) {
  return '${measurement.value} ${measurement.unit}';
}

bool measurementValidityNeedsCaution(MeasurementFact measurement) {
  final status = measurement.validityStatus.toLowerCase();
  return status.contains('stale') ||
      status.contains('invalid') ||
      status.contains('suspect');
}

int _compareIndexedMeasurements(
  _IndexedMeasurement left,
  _IndexedMeasurement right,
) {
  final leftId = left.measurement.measurementId.trim();
  final rightId = right.measurement.measurementId.trim();
  if (leftId.isNotEmpty && rightId.isNotEmpty && leftId != rightId) {
    return leftId.compareTo(rightId);
  }
  return left.index.compareTo(right.index);
}

class _IndexedMeasurement {
  const _IndexedMeasurement(this.index, this.measurement);

  final int index;
  final MeasurementFact measurement;
}
