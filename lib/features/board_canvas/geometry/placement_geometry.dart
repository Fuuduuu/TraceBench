import 'dart:math' as math;
import 'dart:ui' show Offset, Rect, Size;

import '../../../shared/footprints/footprint_models.dart';
import '../../../shared/models/known_facts.dart';

enum FootprintVisualKind {
  testPoint,
  passive2,
  capacitor,
  diode,
  transistor3,
  icDualSide,
  icQuadSide,
  smallMultiPin,
  connector,
  switchPackage,
  moduleBlock,
  mechanical,
  denseGrid,
  generic,
}

Offset renderedPlacementCenter(
  ComponentVisualPlacementFact placement,
  Size size,
) {
  final normalizedX = placement.centerX.toDouble().clamp(0.0, 1.0);
  final normalizedY = placement.centerY.toDouble().clamp(0.0, 1.0);
  return Offset(normalizedX * size.width, normalizedY * size.height);
}

Size renderedPlacementBodySize(
  ComponentVisualPlacementFact placement,
  FootprintTemplate? template,
) {
  if (placement.scale != null) {
    final scale = placement.scale!.toDouble();
    const base = 28.0;
    final scaled = (base * scale).clamp(8.0, 140.0);
    return Size(scaled, (scaled * 0.66).clamp(6.0, 120.0));
  }

  if (placement.width != null && placement.height != null) {
    final width = (placement.width!.toDouble() * 60).clamp(8.0, 140.0);
    final height = (placement.height!.toDouble() * 60).clamp(6.0, 120.0);
    return Size(width, height);
  }

  if (template != null) {
    final width = (template.body.width * 40).clamp(8.0, 140.0);
    final height = (template.body.height * 40).clamp(6.0, 120.0);
    return Size(width, height);
  }

  return const Size(24, 16);
}

Size renderedFootprintVisualSize(
  ComponentVisualPlacementFact placement,
  ComponentFact? component,
  FootprintTemplate? template,
) {
  final bodySize = renderedPlacementBodySize(placement, template);
  final minimumSize = minimumFootprintVisualEnvelope(
    footprintVisualKind(placement, component, template),
  );
  return Size(
    math.max(bodySize.width, minimumSize.width),
    math.max(bodySize.height, minimumSize.height),
  );
}

Size minimumFootprintVisualEnvelope(FootprintVisualKind visualKind) {
  switch (visualKind) {
    case FootprintVisualKind.icDualSide:
      return const Size(56, 40);
    case FootprintVisualKind.icQuadSide:
      return const Size(60, 44);
    case FootprintVisualKind.smallMultiPin:
      return const Size(34, 24);
    case FootprintVisualKind.passive2:
    case FootprintVisualKind.diode:
      return const Size(44, 18);
    case FootprintVisualKind.capacitor:
      return const Size(40, 40);
    case FootprintVisualKind.transistor3:
      return const Size(52, 40);
    case FootprintVisualKind.connector:
      return const Size(44, 22);
    case FootprintVisualKind.testPoint:
      return const Size(22, 22);
    case FootprintVisualKind.switchPackage:
      return const Size(36, 24);
    case FootprintVisualKind.moduleBlock:
      return const Size(56, 40);
    case FootprintVisualKind.mechanical:
      return const Size(20, 20);
    case FootprintVisualKind.denseGrid:
      return const Size(48, 48);
    case FootprintVisualKind.generic:
      return const Size(32, 22);
  }
}

FootprintVisualKind footprintVisualKind(
  ComponentVisualPlacementFact placement,
  ComponentFact? component,
  FootprintTemplate? template,
) {
  final designator = (component?.designator ?? '').trim().toUpperCase();
  final componentId = placement.componentId.trim().toUpperCase();
  final templateId = (placement.templateId ?? '').trim().toLowerCase();
  final templateName = (template?.templateId ?? '').trim().toLowerCase();
  final marker = '$designator $componentId $templateId $templateName';
  final markerLower = marker.toLowerCase();
  final componentIdTokens = componentId
      .split(RegExp(r'[^A-Z0-9]+'))
      .where((token) => token.isNotEmpty)
      .toList(growable: false);
  final componentRef =
      componentIdTokens.isEmpty ? componentId : componentIdTokens.last;

  bool hasReferencePrefix(String prefix) {
    final upperPrefix = prefix.toUpperCase();
    return designator.startsWith(upperPrefix) ||
        componentRef.startsWith(upperPrefix);
  }

  final templateVisualKind = _footprintVisualKindByTemplateId(templateId) ??
      _footprintVisualKindByTemplateId(templateName);

  if (hasReferencePrefix('TP') ||
      designator == 'GND' ||
      componentRef == 'GND' ||
      markerLower.contains('testpoint') ||
      markerLower.contains('test point') ||
      markerLower.contains('test-point') ||
      markerLower.contains('ground') ||
      markerLower.contains('gnd')) {
    return FootprintVisualKind.testPoint;
  }
  if (hasReferencePrefix('J') ||
      hasReferencePrefix('JP') ||
      hasReferencePrefix('CN')) {
    return FootprintVisualKind.connector;
  }
  if (templateVisualKind != null) {
    return templateVisualKind;
  }
  if (hasReferencePrefix('Q') ||
      markerLower.contains('mosfet') ||
      markerLower.contains('transistor')) {
    final pinCount = template?.pinAnchors.length ?? 0;
    if (pinCount > 4) {
      return FootprintVisualKind.icDualSide;
    }
    return FootprintVisualKind.transistor3;
  }
  if (hasReferencePrefix('U') || hasReferencePrefix('IC')) {
    final markerHasSoic = markerLower.contains('soic') ||
        markerLower.contains('dip') ||
        markerLower.contains('tssop') ||
        markerLower.contains('so-ic');
    final markerHasQfn = markerLower.contains('qfp') ||
        markerLower.contains('qfn') ||
        markerLower.contains('densegrid') ||
        markerLower.contains('bga');
    if (markerHasQfn) {
      return FootprintVisualKind.icQuadSide;
    }
    if (markerHasSoic) {
      return FootprintVisualKind.icDualSide;
    }
    final pinCount = template?.pinAnchors.length ?? 0;
    if (pinCount >= 8) {
      return FootprintVisualKind.icDualSide;
    }
    if (pinCount == 5 || pinCount == 6) {
      return FootprintVisualKind.smallMultiPin;
    }
    return FootprintVisualKind.icDualSide;
  }
  if (hasReferencePrefix('R')) {
    return FootprintVisualKind.passive2;
  }
  if (hasReferencePrefix('C')) {
    return FootprintVisualKind.capacitor;
  }
  if (hasReferencePrefix('D')) {
    return FootprintVisualKind.diode;
  }
  if (hasReferencePrefix('SW') || hasReferencePrefix('S')) {
    return FootprintVisualKind.switchPackage;
  }
  if (hasReferencePrefix('MH') || hasReferencePrefix('FID')) {
    return FootprintVisualKind.mechanical;
  }
  if (hasReferencePrefix('K')) {
    return FootprintVisualKind.moduleBlock;
  }

  final pinCount = template?.pinAnchors.length ?? 0;
  if (markerLower.contains('connector') || markerLower.contains('header')) {
    return FootprintVisualKind.connector;
  }
  if (markerLower.contains('capacitor') ||
      markerLower.contains('cap_') ||
      markerLower.contains('cap-')) {
    return FootprintVisualKind.capacitor;
  }
  if (markerLower.contains('resistor') || markerLower.contains('passive')) {
    return FootprintVisualKind.passive2;
  }
  if (markerLower.contains('diode')) {
    return FootprintVisualKind.diode;
  }
  if (pinCount >= 3 ||
      markerLower.contains('sot') ||
      markerLower.contains('soic') ||
      markerLower.contains('qfp') ||
      markerLower.contains('qfn') ||
      markerLower.contains('dip')) {
    return markerLower.contains('qfp') || markerLower.contains('qfn')
        ? FootprintVisualKind.icQuadSide
        : FootprintVisualKind.icDualSide;
  }

  return FootprintVisualKind.generic;
}

FootprintVisualKind? _footprintVisualKindByTemplateId(String templateId) {
  if (templateId.trim().isEmpty) {
    return null;
  }
  switch (templateId) {
    case 'unknown_rect':
      return FootprintVisualKind.generic;
    case 'unknown_2pin':
      return FootprintVisualKind.passive2;
    case 'unknown_3pin':
      return FootprintVisualKind.transistor3;
    case 'unknown_multi_pin':
      return FootprintVisualKind.smallMultiPin;
    case 'chip_0402':
    case 'chip_0603':
    case 'chip_0805':
    case 'chip_1206':
    case 'two_pin_smd':
    case 'two_pin_axial':
      return FootprintVisualKind.passive2;
    case 'sot23_3':
      return FootprintVisualKind.transistor3;
    case 'sot23_5':
    case 'sot223':
      return FootprintVisualKind.smallMultiPin;
    case 'soic_8':
    case 'soic_14':
    case 'soic_16':
      return FootprintVisualKind.icDualSide;
    case 'header_1xn':
    case 'header_2xn':
      return FootprintVisualKind.connector;
    default:
      return null;
  }
}

bool renderedPlacementContains({
  required ComponentVisualPlacementFact placement,
  required ComponentFact? component,
  required FootprintTemplate? template,
  required Offset position,
  required Size size,
}) {
  final center = renderedPlacementCenter(placement, size);
  final bodySize = renderedFootprintVisualSize(
    placement,
    component,
    template,
  );
  final translated = position - center;
  // Rotation visual support is intentionally deferred to a later explicit rotation scope.
  // Keep hit testing aligned with the upright footprint rendered in this pass.
  final localPosition = translated;
  return Rect.fromCenter(
    center: Offset.zero,
    width: bodySize.width,
    height: bodySize.height,
  ).contains(localPosition);
}
