import 'package:flutter/material.dart';

/// Feature-local visual constants for the New Project Wizard.
///
/// This type deliberately owns no mutable configuration or application state.
abstract final class WizardCompactTokens {
  static const Color background = Color(0xFF0B0B0A);
  static const Color panel = Color(0xFF151412);
  static const Color panelRaised = Color(0xFF1B1915);
  static const Color inset = Color(0xFF080807);
  static const Color edge = Color(0xFF332E22);
  static const Color edgeGold = Color(0xFF6B5A30);
  static const Color frame = Color(0xFF8A7338);
  static const Color gold = Color(0xFFE7C25A);
  static const Color goldBright = Color(0xFFF0CF6A);
  static const Color goldDim = Color(0xFFCDA64C);
  static const Color cream = Color(0xFFF3ECDC);
  static const Color muted = Color(0xFFA89F8C);
  static const Color faint = Color(0xFF7E776A);
  static const Color success = Color(0xFF6FCF97);
  static const Color warning = Color(0xFFE08A55);
  static const Color warningBright = Color(0xFFF0A268);
  static const Color activeFill = Color(0x17E7C25A);

  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space24 = 24;

  static const double radiusSmall = 6;
  static const double radiusControl = 8;
  static const double radiusPanel = 12;
  static const double radiusWindow = 16;

  static const double minimumTapTarget = 44;
  static const double visibleIconControl = 36;
  static const double headerMinimumHeight = 40;
  static const double popoverMaximumWidth = 372;
  static const double viewportInset = 16;

  static const Duration fastMotion = Duration(milliseconds: 140);
  static const Curve standardCurve = Cubic(0.4, 0, 0.2, 1);

  static Duration motionDuration({required bool disableAnimations}) {
    return disableAnimations ? Duration.zero : fastMotion;
  }

  static TextStyle bodyStyle({
    Color color = cream,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    double height = 1.4,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle labelStyle({
    Color color = cream,
    double fontSize = 13,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.25,
    );
  }

  static BoxDecoration panelDecoration({
    Color color = panel,
    Color borderColor = edge,
    double radius = radiusPanel,
  }) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static InputDecoration inputDecoration({
    String? hintText,
    Widget? suffixIcon,
    String? suffixText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: faint),
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: muted),
      filled: true,
      fillColor: inset,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: space12,
        vertical: space12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusControl),
        borderSide: const BorderSide(color: edge),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusControl),
        borderSide: const BorderSide(color: edge),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusControl),
        borderSide: const BorderSide(color: gold, width: 1.4),
      ),
    );
  }
}
