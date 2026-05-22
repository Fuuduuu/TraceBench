class ComponentFact {
  const ComponentFact({
    required this.componentId,
    this.designator,
    this.type,
    this.package,
    this.pinCount,
    this.marking,
    this.status,
  });

  final String componentId;
  final String? designator;
  final String? type;
  final String? package;
  final int? pinCount;
  final String? marking;
  final String? status;

  factory ComponentFact.fromJson(Map<String, dynamic> json) {
    return ComponentFact(
      componentId: json['component_id']?.toString() ?? 'unknown',
      designator: json['designator'] as String?,
      type: json['type'] as String?,
      package: json['package'] as String?,
      pinCount: json['pin_count'] is int ? json['pin_count'] as int : null,
      marking: json['marking'] as String?,
      status: json['status']?.toString(),
    );
  }
}

class PinFact {
  const PinFact({
    required this.componentId,
    required this.pinId,
    this.label,
    this.status,
  });

  final String componentId;
  final String pinId;
  final String? label;
  final String? status;

  factory PinFact.fromJson(Map<String, dynamic> json) {
    return PinFact(
      componentId: json['component_id']?.toString() ?? 'unknown',
      pinId: json['pin_id']?.toString() ?? 'unknown',
      label: json['label'] as String?,
      status: json['status']?.toString(),
    );
  }
}

class MeasurementFact {
  const MeasurementFact({
    required this.measurementId,
    required this.mode,
    required this.from,
    required this.to,
    required this.reading,
    required this.validityStatus,
    required this.powerState,
    this.unit,
    this.value,
    this.originEventId,
    this.validUntilEventId,
  });

  final String measurementId;
  final String mode;
  final String from;
  final String to;
  final String reading;
  final String validityStatus;
  final String powerState;
  final Object? value;
  final String? unit;
  final String? originEventId;
  final String? validUntilEventId;

  String get humanValidityLabel {
    if (validityStatus == 'stale_after_repair') {
      return 'Aegunud pärast remonti';
    }
    if (validityStatus == 'active') {
      return 'Aktiivne';
    }
    return validityStatus;
  }

  factory MeasurementFact.fromJson(Map<String, dynamic> json) {
    final readingMap = json['reading'] as Map<String, dynamic>? ?? {};
    final readingKind = readingMap['kind']?.toString() ?? 'numeric';
    final readingValue = readingMap['value'];
    final readingUnit = readingMap['unit']?.toString();

    return MeasurementFact(
      measurementId: json['measurement_id']?.toString() ?? 'unknown',
      mode: json['mode']?.toString() ?? 'unknown',
      from: json['from']?.toString() ?? 'unknown',
      to: json['to']?.toString() ?? 'unknown',
      reading: readingKind,
      validityStatus: json['validity_status']?.toString() ?? 'active',
      powerState: json['power_state']?.toString() ?? 'unknown',
      value: readingValue,
      unit: readingUnit,
      originEventId: json['origin_event_id']?.toString(),
      validUntilEventId: json['valid_until_event_id']?.toString(),
    );
  }
}

class NetFact {
  const NetFact({
    required this.netId,
    required this.from,
    required this.to,
    required this.confirmationBasis,
    required this.confirmedByEventIds,
    this.label,
    this.verificationLevel,
  });

  final String netId;
  final String from;
  final String to;
  final String confirmationBasis;
  final List<String> confirmedByEventIds;
  final String? label;
  final String? verificationLevel;

  factory NetFact.fromJson(Map<String, dynamic> json) {
    final confirmed = json['confirmed_by_event_ids'];
    final confirmedList = confirmed is List
        ? confirmed.whereType<String>().toList()
        : <String>[];

    return NetFact(
      netId: json['net_id']?.toString() ?? 'unknown',
      from: json['from']?.toString() ?? 'unknown',
      to: json['to']?.toString() ?? 'unknown',
      confirmationBasis: json['confirmation_basis']?.toString() ?? 'measured',
      confirmedByEventIds: confirmedList,
      label: json['label']?.toString(),
      verificationLevel: json['verification_level']?.toString(),
    );
  }
}

class ExcludedFootprintFact {
  const ExcludedFootprintFact({
    required this.footprintId,
    this.designator,
  });

  final String footprintId;
  final String? designator;

  factory ExcludedFootprintFact.fromJson(Map<String, dynamic> json) {
    return ExcludedFootprintFact(
      footprintId: json['footprint_id']?.toString() ?? 'unknown',
      designator: json['designator']?.toString(),
    );
  }
}

class KnownFacts {
  const KnownFacts({
    required this.projectId,
    required this.components,
    required this.pins,
    required this.measurements,
    required this.nets,
    required this.excludedFromFaultCandidates,
  });

  final String projectId;
  final List<ComponentFact> components;
  final List<PinFact> pins;
  final List<MeasurementFact> measurements;
  final List<NetFact> nets;
  final List<ExcludedFootprintFact> excludedFromFaultCandidates;

  factory KnownFacts.fromJson(Map<String, dynamic> json) {
    final components = ((json['components'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => ComponentFact.fromJson(e))
        .toList(growable: false);

    final pins = ((json['pins'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => PinFact.fromJson(e))
        .toList(growable: false);

    final measurements = ((json['measurements'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => MeasurementFact.fromJson(e))
        .toList(growable: false);

    final nets = ((json['nets'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => NetFact.fromJson(e))
        .toList(growable: false);

    final excluded = ((json['excluded_from_fault_candidates'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => ExcludedFootprintFact.fromJson(e))
        .toList(growable: false);

    return KnownFacts(
      projectId: json['project_id']?.toString() ?? 'unknown_project',
      components: components,
      pins: pins,
      measurements: measurements,
      nets: nets,
      excludedFromFaultCandidates: excluded,
    );
  }

  Map<String, dynamic> toJson() => {
        'project_id': projectId,
        'components': components.map((c) => {
              'component_id': c.componentId,
              'designator': c.designator,
              'type': c.type,
              'package': c.package,
              'pin_count': c.pinCount,
              'marking': c.marking,
              'status': c.status,
            }).toList(),
        'pins': pins
            .map((p) => {
                  'component_id': p.componentId,
                  'pin_id': p.pinId,
                  'label': p.label,
                  'status': p.status,
                })
            .toList(),
        'measurements': measurements
            .map((m) => {
                  'measurement_id': m.measurementId,
                  'mode': m.mode,
                  'from': m.from,
                  'to': m.to,
                  'reading': {
                    'kind': m.reading,
                    'value': m.value,
                    'unit': m.unit,
                  },
                  'power_state': m.powerState,
                  'origin_event_id': m.originEventId,
                  'valid_from_event_id': m.originEventId,
                  'valid_until_event_id': m.validUntilEventId,
                  'validity_status': m.validityStatus,
                })
            .toList(),
        'nets': nets
            .map((n) => {
                  'net_id': n.netId,
                  'from': n.from,
                  'to': n.to,
                  'confirmation_basis': n.confirmationBasis,
                  'confirmed_by_event_ids': n.confirmedByEventIds,
                  'label': n.label,
                  'verification_level': n.verificationLevel,
                })
            .toList(),
        'excluded_from_fault_candidates': excludedFromFaultCandidates
            .map((f) => {
                  'footprint_id': f.footprintId,
                  'designator': f.designator,
                })
            .toList(),
      };
}
