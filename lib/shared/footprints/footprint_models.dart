enum FootprintBodyShape {
  rect,
  roundedRect,
  oval,
  customPath,
}

enum FootprintPinSide {
  left,
  right,
  top,
  bottom,
  unknown,
}

enum FootprintPinShape {
  rect,
  oval,
  circle,
}

enum FootprintHitTestKind {
  boundingBox,
  bodyOnly,
  customPath,
}

enum FootprintFallbackPolicy {
  none,
  geometryOnlyFallback,
}

class FootprintPoint {
  const FootprintPoint(this.x, this.y);

  final double x;
  final double y;

  Map<String, Object> toMap() {
    return {
      'x': x,
      'y': y,
    };
  }
}

class FootprintBody {
  const FootprintBody({
    required this.shape,
    required this.width,
    required this.height,
  })  : assert(width > 0),
        assert(height > 0);

  final FootprintBodyShape shape;
  final double width;
  final double height;

  Map<String, Object> toMap() {
    return {
      'shape': shape.name,
      'width': width,
      'height': height,
    };
  }
}

class FootprintBoundingBox {
  const FootprintBoundingBox({
    required this.minX,
    required this.minY,
    required this.maxX,
    required this.maxY,
  })  : assert(maxX > minX),
        assert(maxY > minY);

  final double minX;
  final double minY;
  final double maxX;
  final double maxY;

  bool get isValid => maxX > minX && maxY > minY;

  bool contains(FootprintPoint point) {
    return point.x >= minX &&
        point.x <= maxX &&
        point.y >= minY &&
        point.y <= maxY;
  }

  Map<String, Object> toMap() {
    return {
      'min_x': minX,
      'min_y': minY,
      'max_x': maxX,
      'max_y': maxY,
    };
  }
}

class FootprintLabelAnchor {
  const FootprintLabelAnchor({
    required this.point,
    this.alignment = 'center',
  });

  final FootprintPoint point;
  final String alignment;

  Map<String, Object> toMap() {
    return {
      'point': point.toMap(),
      'alignment': alignment,
    };
  }
}

class FootprintOrientationMarker {
  const FootprintOrientationMarker({
    required this.point,
    required this.markerType,
    required this.size,
  }) : assert(size > 0);

  final FootprintPoint point;
  final String markerType;
  final double size;

  Map<String, Object> toMap() {
    return {
      'point': point.toMap(),
      'marker_type': markerType,
      'size': size,
    };
  }
}

class FootprintPinAnchor {
  const FootprintPinAnchor({
    required this.pinNumber,
    required this.anchor,
    required this.side,
    required this.shape,
    this.width,
    this.height,
    this.radius,
    this.labelAnchor,
  })  : assert(pinNumber > 0),
        assert(
          (radius != null && width == null && height == null) ||
              (radius == null && width != null && height != null),
        ),
        assert(radius == null || radius > 0),
        assert(width == null || width > 0),
        assert(height == null || height > 0);

  final int pinNumber;
  final FootprintPoint anchor;
  final FootprintPinSide side;
  final FootprintPinShape shape;
  final double? width;
  final double? height;
  final double? radius;
  final FootprintPoint? labelAnchor;

  Map<String, Object?> toMap() {
    return {
      'pin_number': pinNumber,
      'anchor': anchor.toMap(),
      'side': side.name,
      'shape': shape.name,
      'width': width,
      'height': height,
      'radius': radius,
      'label_anchor': labelAnchor?.toMap(),
    };
  }
}

class FootprintPinGroup {
  const FootprintPinGroup({
    required this.groupId,
    required this.pinNumbers,
    this.label,
  });

  final String groupId;
  final List<int> pinNumbers;
  final String? label;

  Map<String, Object?> toMap() {
    return {
      'group_id': groupId,
      'pin_numbers': pinNumbers,
      'label': label,
    };
  }
}

class FootprintPinCountRules {
  const FootprintPinCountRules({
    this.fixedCount,
    this.minPins,
    this.maxPins,
    this.fixedPinsPerSide = const {},
    this.variantDriven = false,
  })  : assert(fixedCount == null || fixedCount > 0),
        assert(minPins == null || minPins >= 0),
        assert(maxPins == null || maxPins >= 0),
        assert(minPins == null || maxPins == null || maxPins >= minPins);

  final int? fixedCount;
  final int? minPins;
  final int? maxPins;
  final Map<FootprintPinSide, int> fixedPinsPerSide;
  final bool variantDriven;

  Map<String, Object?> toMap() {
    return {
      'fixed_count': fixedCount,
      'min_pins': minPins,
      'max_pins': maxPins,
      'fixed_pins_per_side':
          fixedPinsPerSide.map((key, value) => MapEntry(key.name, value)),
      'variant_driven': variantDriven,
    };
  }
}

class FootprintVariant {
  const FootprintVariant({
    required this.variantId,
    this.pinsPerSide = const {},
    this.pitch,
    this.bodyWidth,
    this.bodyHeight,
    this.leadLength,
    this.leadWidth,
    this.orientationMarker,
  })  : assert(pitch == null || pitch > 0),
        assert(bodyWidth == null || bodyWidth > 0),
        assert(bodyHeight == null || bodyHeight > 0),
        assert(leadLength == null || leadLength > 0),
        assert(leadWidth == null || leadWidth > 0);

  final String variantId;
  final Map<FootprintPinSide, int> pinsPerSide;
  final double? pitch;
  final double? bodyWidth;
  final double? bodyHeight;
  final double? leadLength;
  final double? leadWidth;
  final FootprintOrientationMarker? orientationMarker;

  Map<String, Object?> toMap() {
    return {
      'variant_id': variantId,
      'pins_per_side':
          pinsPerSide.map((key, value) => MapEntry(key.name, value)),
      'pitch': pitch,
      'body_width': bodyWidth,
      'body_height': bodyHeight,
      'lead_length': leadLength,
      'lead_width': leadWidth,
      'orientation_marker': orientationMarker?.toMap(),
    };
  }
}

class FootprintStyleTokens {
  const FootprintStyleTokens({
    required this.strokeToken,
    required this.fillToken,
    required this.opacityToken,
    required this.lineStyleToken,
    required this.label,
    this.metadataOnly = true,
  });

  final String strokeToken;
  final String fillToken;
  final String opacityToken;
  final String lineStyleToken;
  final String label;
  final bool metadataOnly;

  Map<String, Object> toMap() {
    return {
      'stroke_token': strokeToken,
      'fill_token': fillToken,
      'opacity_token': opacityToken,
      'line_style_token': lineStyleToken,
      'label': label,
      'metadata_only': metadataOnly,
    };
  }
}

class FootprintLodHints {
  const FootprintLodHints({
    required this.minVisibleZoom,
    required this.fullDetailZoom,
    required this.collapsePinsBelowZoom,
    required this.note,
    this.metadataOnly = true,
  })  : assert(fullDetailZoom >= minVisibleZoom),
        assert(collapsePinsBelowZoom >= 0);

  final double minVisibleZoom;
  final double fullDetailZoom;
  final double collapsePinsBelowZoom;
  final String note;
  final bool metadataOnly;

  Map<String, Object> toMap() {
    return {
      'min_visible_zoom': minVisibleZoom,
      'full_detail_zoom': fullDetailZoom,
      'collapse_pins_below_zoom': collapsePinsBelowZoom,
      'note': note,
      'metadata_only': metadataOnly,
    };
  }
}

class FootprintHitTestShape {
  const FootprintHitTestShape({
    required this.kind,
    required this.bounds,
    required this.note,
    this.metadataOnly = true,
  });

  final FootprintHitTestKind kind;
  final FootprintBoundingBox bounds;
  final String note;
  final bool metadataOnly;

  Map<String, Object> toMap() {
    return {
      'kind': kind.name,
      'bounds': bounds.toMap(),
      'note': note,
      'metadata_only': metadataOnly,
    };
  }
}

class FootprintTemplate {
  const FootprintTemplate({
    required this.templateId,
    required this.templateVersion,
    required this.packageFamily,
    required this.displayName,
    required this.description,
    required this.body,
    required this.origin,
    required this.boundingBox,
    required this.labelAnchor,
    required this.orientationMarker,
    required this.pinAnchors,
    required this.pinGroups,
    required this.pinCountRules,
    required this.defaultPinPitch,
    required this.allowedVariants,
    required this.defaultStyleTokens,
    required this.lodHints,
    required this.hitTestShape,
    required this.accessibilityLabelTemplate,
    this.fallbackPolicy = FootprintFallbackPolicy.none,
    this.pinAnchorsAreGeometricOnly = true,
    this.allowsExternalLeadExtents = false,
  })  : assert(templateId.length > 0),
        assert(templateVersion.length > 0),
        assert(packageFamily.length > 0),
        assert(displayName.length > 0),
        assert(description.length > 0),
        assert(defaultPinPitch > 0),
        assert(accessibilityLabelTemplate.length > 0);

  final String templateId;
  final String templateVersion;
  final String packageFamily;
  final String displayName;
  final String description;
  final FootprintBody body;
  final FootprintPoint origin;
  final FootprintBoundingBox boundingBox;
  final FootprintLabelAnchor labelAnchor;
  final FootprintOrientationMarker orientationMarker;
  final List<FootprintPinAnchor> pinAnchors;
  final List<FootprintPinGroup> pinGroups;
  final FootprintPinCountRules pinCountRules;
  final double defaultPinPitch;
  final List<FootprintVariant> allowedVariants;
  final FootprintStyleTokens defaultStyleTokens;
  final FootprintLodHints lodHints;
  final FootprintHitTestShape hitTestShape;
  final String accessibilityLabelTemplate;
  final FootprintFallbackPolicy fallbackPolicy;
  final bool pinAnchorsAreGeometricOnly;
  final bool allowsExternalLeadExtents;

  bool get isUnknownFallback =>
      fallbackPolicy == FootprintFallbackPolicy.geometryOnlyFallback;

  Map<String, Object?> toMap() {
    return {
      'template_id': templateId,
      'template_version': templateVersion,
      'package_family': packageFamily,
      'display_name': displayName,
      'description': description,
      'body': body.toMap(),
      'origin': origin.toMap(),
      'bounding_box': boundingBox.toMap(),
      'label_anchor': labelAnchor.toMap(),
      'orientation_marker': orientationMarker.toMap(),
      'pin_anchors': pinAnchors.map((e) => e.toMap()).toList(growable: false),
      'pin_groups': pinGroups.map((e) => e.toMap()).toList(growable: false),
      'pin_count_rules': pinCountRules.toMap(),
      'default_pin_pitch': defaultPinPitch,
      'allowed_variants':
          allowedVariants.map((e) => e.toMap()).toList(growable: false),
      'default_style_tokens': defaultStyleTokens.toMap(),
      'lod_hints': lodHints.toMap(),
      'hit_test_shape': hitTestShape.toMap(),
      'accessibility_label_template': accessibilityLabelTemplate,
      'fallback_policy': fallbackPolicy.name,
      'pin_anchors_are_geometric_only': pinAnchorsAreGeometricOnly,
      'allows_external_lead_extents': allowsExternalLeadExtents,
    };
  }
}
