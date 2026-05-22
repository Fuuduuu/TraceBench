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
        ? confirmed.whereType<String>().toList(growable: false)
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

class PhotoFact {
  const PhotoFact({
    required this.photoId,
    required this.mode,
    required this.path,
    this.notes,
    this.sha256,
    this.sourceDevice,
    this.exifStripped,
    this.layer,
  });

  final String photoId;
  final String mode;
  final String path;
  final String? notes;
  final String? sha256;
  final String? sourceDevice;
  final bool? exifStripped;
  final String? layer;

  factory PhotoFact.fromJson(Map<String, dynamic> json) {
    return PhotoFact(
      photoId: json['photo_id']?.toString() ?? 'unknown',
      mode: json['mode']?.toString() ?? 'unknown',
      path: json['path']?.toString() ?? '',
      notes: json['notes']?.toString(),
      sha256: json['sha256']?.toString(),
      sourceDevice: json['source_device']?.toString(),
      exifStripped:
          json['exif_stripped'] is bool ? json['exif_stripped'] as bool : null,
      layer: json['layer']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'photo_id': photoId,
        'mode': mode,
        'path': path,
        'notes': notes,
        'sha256': sha256,
        'source_device': sourceDevice,
        'exif_stripped': exifStripped,
        'layer': layer,
      };
}

class DamageRegionFact {
  const DamageRegionFact({
    required this.regionId,
    required this.photoId,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.damageType,
    this.notes,
    this.severity,
    this.affectsComponents,
  });

  final String regionId;
  final String photoId;
  final num x;
  final num y;
  final num width;
  final num height;
  final String damageType;
  final String? notes;
  final String? severity;
  final List<String>? affectsComponents;

  factory DamageRegionFact.fromJson(Map<String, dynamic> json) {
    final bbox = json['bbox'] as Map<String, dynamic>?;
    return DamageRegionFact(
      regionId: json['region_id']?.toString() ?? 'unknown',
      photoId: json['photo_id']?.toString() ?? 'unknown',
      x: (bbox?['x'] as num?) ?? 0,
      y: (bbox?['y'] as num?) ?? 0,
      width: (bbox?['width'] as num?) ?? 0,
      height: (bbox?['height'] as num?) ?? 0,
      damageType: json['damage_type']?.toString() ?? 'unknown',
      notes: json['notes']?.toString(),
      severity: json['severity']?.toString(),
      affectsComponents: _toStringList(json['affects_components']),
    );
  }

  Map<String, dynamic> toJson() => {
        'region_id': regionId,
        'photo_id': photoId,
        'bbox': {
          'x': x,
          'y': y,
          'width': width,
          'height': height,
        },
        'damage_type': damageType,
        'severity': severity,
        'notes': notes,
        if (affectsComponents != null) 'affects_components': affectsComponents,
      };
}

class SuspectRegionFact {
  const SuspectRegionFact({
    required this.regionId,
    required this.photoId,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.reason,
    this.notes,
    this.affectsComponents,
    this.priority,
  });

  final String regionId;
  final String photoId;
  final num x;
  final num y;
  final num width;
  final num height;
  final String reason;
  final String? notes;
  final List<String>? affectsComponents;
  final String? priority;

  factory SuspectRegionFact.fromJson(Map<String, dynamic> json) {
    final bbox = json['bbox'] as Map<String, dynamic>?;
    return SuspectRegionFact(
      regionId: json['region_id']?.toString() ?? 'unknown',
      photoId: json['photo_id']?.toString() ?? 'unknown',
      x: (bbox?['x'] as num?) ?? 0,
      y: (bbox?['y'] as num?) ?? 0,
      width: (bbox?['width'] as num?) ?? 0,
      height: (bbox?['height'] as num?) ?? 0,
      reason: json['reason']?.toString() ?? 'unknown',
      notes: json['notes']?.toString(),
      affectsComponents: _toStringList(json['affects_components']),
      priority: json['priority']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'region_id': regionId,
        'photo_id': photoId,
        'bbox': {
          'x': x,
          'y': y,
          'width': width,
          'height': height,
        },
        'reason': reason,
        'priority': priority,
        'notes': notes,
        if (affectsComponents != null) 'affects_components': affectsComponents,
      };
}

class VisualTraceFact {
  const VisualTraceFact({
    required this.traceId,
    required this.photoId,
    required this.evidenceType,
    this.fromComponent,
    this.toComponent,
    this.fromPin,
    this.toPin,
    this.confidence,
    this.layer,
    this.notes,
  });

  final String traceId;
  final String photoId;
  final String evidenceType;
  final String? fromComponent;
  final String? toComponent;
  final String? fromPin;
  final String? toPin;
  final String? confidence;
  final String? layer;
  final String? notes;

  factory VisualTraceFact.fromJson(Map<String, dynamic> json) {
    return VisualTraceFact(
      traceId: json['trace_id']?.toString() ?? 'unknown',
      photoId: json['photo_id']?.toString() ?? 'unknown',
      evidenceType: json['evidence_type']?.toString() ?? 'visual_trace',
      fromComponent: json['from_component']?.toString(),
      toComponent: json['to_component']?.toString(),
      fromPin: json['from_pin']?.toString(),
      toPin: json['to_pin']?.toString(),
      confidence: json['confidence']?.toString(),
      layer: json['layer']?.toString(),
      notes: json['notes']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'trace_id': traceId,
        'photo_id': photoId,
        'evidence_type': evidenceType,
        if (fromComponent != null) 'from_component': fromComponent,
        if (toComponent != null) 'to_component': toComponent,
        if (fromPin != null) 'from_pin': fromPin,
        if (toPin != null) 'to_pin': toPin,
        if (confidence != null) 'confidence': confidence,
        if (layer != null) 'layer': layer,
        if (notes != null) 'notes': notes,
      };
}

class KnownFacts {
  const KnownFacts({
    required this.projectId,
    required this.components,
    required this.pins,
    required this.measurements,
    required this.nets,
    required this.excludedFromFaultCandidates,
    required this.componentPinIndex,
    required this.photos,
    required this.damageRegions,
    required this.suspectRegions,
    required this.visualTraces,
  });

  final String projectId;
  final List<ComponentFact> components;
  final List<PinFact> pins;
  final List<MeasurementFact> measurements;
  final List<NetFact> nets;
  final List<ExcludedFootprintFact> excludedFromFaultCandidates;
  final Map<String, List<String>> componentPinIndex;
  final List<PhotoFact> photos;
  final List<DamageRegionFact> damageRegions;
  final List<SuspectRegionFact> suspectRegions;
  final List<VisualTraceFact> visualTraces;

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

    final excluded =
        ((json['excluded_from_fault_candidates'] as List?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map((e) => ExcludedFootprintFact.fromJson(e))
            .toList(growable: false);

    final photos = ((json['photos'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => PhotoFact.fromJson(e))
        .toList(growable: false);

    final damageRegions = ((json['damage_regions'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => DamageRegionFact.fromJson(e))
        .toList(growable: false);

    final suspectRegions = ((json['suspect_regions'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => SuspectRegionFact.fromJson(e))
        .toList(growable: false);

    final visualTraces = ((json['visual_traces'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => VisualTraceFact.fromJson(e))
        .toList(growable: false);

    final rawPinIndex = json['component_pin_index'] is Map
        ? json['component_pin_index'] as Map
        : null;
    final componentPinIndex = <String, List<String>>{};
    if (rawPinIndex != null) {
      for (final entry in rawPinIndex.entries) {
        final key = entry.key.toString();
        final values = _toStringList(entry.value);
        final dedup = <String>[];
        for (final value in values) {
          if (!dedup.contains(value)) {
            dedup.add(value);
          }
        }
        componentPinIndex[key] = dedup;
      }
    }

    return KnownFacts(
      projectId: json['project_id']?.toString() ?? 'unknown_project',
      components: components,
      pins: pins,
      measurements: measurements,
      nets: nets,
      excludedFromFaultCandidates: excluded,
      componentPinIndex: componentPinIndex,
      photos: photos,
      damageRegions: damageRegions,
      suspectRegions: suspectRegions,
      visualTraces: visualTraces,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'components': components
          .map((c) => {
                'component_id': c.componentId,
                'designator': c.designator,
                'type': c.type,
                'package': c.package,
                'pin_count': c.pinCount,
                'marking': c.marking,
                'status': c.status,
              })
          .toList(),
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
      if (componentPinIndex.isNotEmpty)
        'component_pin_index': componentPinIndex,
      'photos': photos.map((photo) => photo.toJson()).toList(),
      'damage_regions': damageRegions.map((region) => region.toJson()).toList(),
      'suspect_regions':
          suspectRegions.map((region) => region.toJson()).toList(),
      'visual_traces': visualTraces.map((trace) => trace.toJson()).toList(),
    };
  }
}

List<String> _toStringList(Object? raw) {
  if (raw is List) {
    return raw.whereType<String>().toList(growable: false);
  }
  return const [];
}
