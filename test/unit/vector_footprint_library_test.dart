import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/footprints/footprint_models.dart';
import 'package:trace_bench_viewer/shared/footprints/vector_footprint_library.dart';

void main() {
  const expectedV1TemplateIds = <String>{
    'unknown_rect',
    'unknown_2pin',
    'unknown_3pin',
    'unknown_multi_pin',
    'chip_0402',
    'chip_0603',
    'chip_0805',
    'chip_1206',
    'two_pin_smd',
    'two_pin_axial',
    'three_pin_smd_generic',
    'three_pin_through_hole_generic',
    'sot23_3',
    'sot23_5',
    'sot223',
    'soic_8',
    'soic_14',
    'soic_16',
    'header_1xn',
    'header_2xn',
  };

  const forbiddenIdentityLoadedTemplateIds = <String>{
    'mosfet',
    'regulator',
    'diode',
    'microcontroller',
    'opamp',
    'relay_driver',
    'power_supply',
    '5v_regulator',
    'eeprom',
    'transistor',
  };

  const forbiddenIdentityWords = <String>[
    'mosfet',
    'regulator',
    'diode',
    'microcontroller',
    'opamp',
    'eeprom',
    'transistor',
    'power supply',
  ];

  test('registry contains all V1 template IDs', () {
    final ids = VectorFootprintLibrary.templates
        .map((template) => template.templateId)
        .toSet();

    expect(ids, expectedV1TemplateIds);
  });

  test('registry template IDs are unique', () {
    final ids = VectorFootprintLibrary.templates
        .map((template) => template.templateId)
        .toList(growable: false);
    expect(ids.toSet().length, ids.length);
  });

  test('every template has required fields', () {
    for (final template in VectorFootprintLibrary.templates) {
      expect(template.templateId, isNotEmpty);
      expect(template.templateVersion, isNotEmpty);
      expect(template.packageFamily, isNotEmpty);
      expect(template.displayName, isNotEmpty);
      expect(template.description, isNotEmpty);
      expect(template.accessibilityLabelTemplate, isNotEmpty);

      expect(template.body.width, greaterThan(0));
      expect(template.body.height, greaterThan(0));

      expect(template.boundingBox.isValid, isTrue);
      expect(template.labelAnchor.alignment, isNotEmpty);
      expect(template.hitTestShape.metadataOnly, isTrue);
      expect(template.defaultStyleTokens.metadataOnly, isTrue);
      expect(template.lodHints.metadataOnly, isTrue);
    }
  });

  test('forbidden identity-loaded template IDs are absent', () {
    final ids = VectorFootprintLibrary.templates
        .map((template) => template.templateId)
        .toSet();
    for (final forbidden in forbiddenIdentityLoadedTemplateIds) {
      expect(ids.contains(forbidden), isFalse);
    }
  });

  test(
      'display_name/description/package_family/accessibility labels do not assert confirmed electrical identity',
      () {
    for (final template in VectorFootprintLibrary.templates) {
      final fieldsToCheck = <String>[
        template.displayName.toLowerCase(),
        template.description.toLowerCase(),
        template.packageFamily.toLowerCase(),
        template.accessibilityLabelTemplate.toLowerCase(),
        template.defaultStyleTokens.label.toLowerCase(),
      ];

      for (final value in fieldsToCheck) {
        for (final forbiddenWord in forbiddenIdentityWords) {
          expect(value.contains(forbiddenWord), isFalse,
              reason:
                  'Field value "$value" should not contain "$forbiddenWord".');
        }
      }
    }
  });

  test('unknown_* templates exist and are geometry fallback only', () {
    final unknownIds = <String>{
      'unknown_rect',
      'unknown_2pin',
      'unknown_3pin',
      'unknown_multi_pin',
    };

    for (final id in unknownIds) {
      final template = VectorFootprintLibrary.templateById(id);
      expect(template, isNotNull);
      expect(template!.isUnknownFallback, isTrue);
      expect(template.description.toLowerCase().contains('fallback only'),
          isTrue);
    }
  });

  test('unknown_rect supports zero pins safely', () {
    final template = VectorFootprintLibrary.templateById('unknown_rect');
    expect(template, isNotNull);
    expect(template!.pinCountRules.minPins, 0);
    expect(template.pinCountRules.maxPins, 0);
    expect(template.pinAnchors, isEmpty);
  });

  test('negative minPins/maxPins remain invalid', () {
    expect(
      () => FootprintPinCountRules(minPins: -1),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => FootprintPinCountRules(maxPins: -1),
      throwsA(isA<AssertionError>()),
    );
  });

  test('maxPins lower than minPins remains invalid', () {
    expect(
      () => FootprintPinCountRules(minPins: 2, maxPins: 1),
      throwsA(isA<AssertionError>()),
    );
  });

  test('unknown_2pin/unknown_3pin/unknown_multi_pin keep intended semantics',
      () {
    final unknown2Pin = VectorFootprintLibrary.templateById('unknown_2pin');
    final unknown3Pin = VectorFootprintLibrary.templateById('unknown_3pin');
    final unknownMultiPin =
        VectorFootprintLibrary.templateById('unknown_multi_pin');

    expect(unknown2Pin, isNotNull);
    expect(unknown3Pin, isNotNull);
    expect(unknownMultiPin, isNotNull);

    expect(unknown2Pin!.pinCountRules.fixedCount, 2);
    expect(unknown3Pin!.pinCountRules.fixedCount, 3);
    expect(unknownMultiPin!.pinCountRules.variantDriven, isTrue);
    expect(unknownMultiPin.pinCountRules.minPins, 4);
  });

  test('coordinate frame convention is represented consistently', () {
    for (final template in VectorFootprintLibrary.templates) {
      expect(template.origin.x, 0);
      expect(template.origin.y, 0);
      expect(template.boundingBox.contains(template.labelAnchor.point), isTrue);
      expect(template.boundingBox.contains(template.orientationMarker.point),
          isTrue);
    }
  });

  test('bounding boxes are deterministic and valid', () {
    for (final template in VectorFootprintLibrary.templates) {
      expect(template.boundingBox.maxX, greaterThan(template.boundingBox.minX));
      expect(template.boundingBox.maxY, greaterThan(template.boundingBox.minY));
    }
  });

  test('label anchors exist for every template', () {
    for (final template in VectorFootprintLibrary.templates) {
      expect(template.labelAnchor.point.x, isA<double>());
      expect(template.labelAnchor.point.y, isA<double>());
    }
  });

  test('pin anchors use template-local coordinate frame', () {
    for (final template in VectorFootprintLibrary.templates) {
      for (final pin in template.pinAnchors) {
        final inBoundingBox = template.boundingBox.contains(pin.anchor);
        expect(inBoundingBox || template.allowsExternalLeadExtents, isTrue);
      }
    }
  });

  test('pin anchors are geometric only and do not imply pin_defined facts', () {
    for (final template in VectorFootprintLibrary.templates) {
      expect(template.pinAnchorsAreGeometricOnly, isTrue);

      final map = template.toMap();
      expect(map.containsKey('pin_defined'), isFalse);
      expect(map.containsKey('pin_fact'), isFalse);
    }
  });

  test(
      'templates do not contain electrical identity/net/voltage/fault/AI confidence/proposal fields',
      () {
    const forbiddenKeys = <String>{
      'component_identity',
      'component_type',
      'net_id',
      'voltage',
      'fault',
      'confidence',
      'ai_confidence',
      'proposal_status',
      'unconfirmed_ai_proposal',
    };

    for (final template in VectorFootprintLibrary.templates) {
      final map = template.toMap();
      for (final forbidden in forbiddenKeys) {
        expect(map.containsKey(forbidden), isFalse);
      }
    }
  });

  test('default_style_tokens/lod_hints/hit_test_shape are metadata only', () {
    for (final template in VectorFootprintLibrary.templates) {
      expect(template.defaultStyleTokens.metadataOnly, isTrue);
      expect(template.lodHints.metadataOnly, isTrue);
      expect(template.hitTestShape.metadataOnly, isTrue);
    }
  });

  test('no renderer classes/widgets are introduced in footprint library files',
      () {
    const files = [
      'lib/shared/footprints/footprint_models.dart',
      'lib/shared/footprints/vector_footprint_library.dart',
    ];
    const forbiddenStrings = [
      'CustomPainter',
      'Widget',
      'RenderObject',
      'SceneBuilder',
      'InteractiveViewer',
    ];

    for (final filePath in files) {
      final text = File(filePath).readAsStringSync();
      for (final forbidden in forbiddenStrings) {
        expect(text.contains(forbidden), isFalse);
      }
    }
  });
}
