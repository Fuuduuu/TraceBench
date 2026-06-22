import 'package:flutter/material.dart';

class BenchBeepVisualTokens extends ThemeExtension<BenchBeepVisualTokens> {
  const BenchBeepVisualTokens({
    required this.surface,
    required this.panel,
    required this.rule,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.selectedConfirmedSave,
    required this.selectedConfirmedSaveAccent,
    required this.measuringArmedMeasured,
    required this.draftUnsavedUnknown,
    required this.draftUnsavedUnknownStrong,
    required this.draftUnsavedUnknownFill,
  });

  static const darkInstrument = BenchBeepVisualTokens(
    surface: Color(0xFF101A17),
    panel: Color(0xFF172722),
    rule: Color(0xFF325247),
    textPrimary: Color(0xFFE7EFE9),
    textSecondary: Color(0xFFB6C8BD),
    textMuted: Color(0xFF7C9086),
    selectedConfirmedSave: Color(0xFF2DD4BF),
    selectedConfirmedSaveAccent: Color(0xFFC47A35),
    measuringArmedMeasured: Color(0xFFF3A712),
    draftUnsavedUnknown: Color(0xFF7B3FF2),
    draftUnsavedUnknownStrong: Color(0xFF5E35B1),
    draftUnsavedUnknownFill: Color(0x227B3FF2),
  );

  final Color surface;
  final Color panel;
  final Color rule;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color selectedConfirmedSave;
  final Color selectedConfirmedSaveAccent;
  final Color measuringArmedMeasured;
  final Color draftUnsavedUnknown;
  final Color draftUnsavedUnknownStrong;
  final Color draftUnsavedUnknownFill;

  @override
  BenchBeepVisualTokens copyWith({
    Color? surface,
    Color? panel,
    Color? rule,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? selectedConfirmedSave,
    Color? selectedConfirmedSaveAccent,
    Color? measuringArmedMeasured,
    Color? draftUnsavedUnknown,
    Color? draftUnsavedUnknownStrong,
    Color? draftUnsavedUnknownFill,
  }) {
    return BenchBeepVisualTokens(
      surface: surface ?? this.surface,
      panel: panel ?? this.panel,
      rule: rule ?? this.rule,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      selectedConfirmedSave:
          selectedConfirmedSave ?? this.selectedConfirmedSave,
      selectedConfirmedSaveAccent:
          selectedConfirmedSaveAccent ?? this.selectedConfirmedSaveAccent,
      measuringArmedMeasured:
          measuringArmedMeasured ?? this.measuringArmedMeasured,
      draftUnsavedUnknown: draftUnsavedUnknown ?? this.draftUnsavedUnknown,
      draftUnsavedUnknownStrong:
          draftUnsavedUnknownStrong ?? this.draftUnsavedUnknownStrong,
      draftUnsavedUnknownFill:
          draftUnsavedUnknownFill ?? this.draftUnsavedUnknownFill,
    );
  }

  @override
  BenchBeepVisualTokens lerp(
    ThemeExtension<BenchBeepVisualTokens>? other,
    double t,
  ) {
    if (other is! BenchBeepVisualTokens) {
      return this;
    }
    return BenchBeepVisualTokens(
      surface: Color.lerp(surface, other.surface, t)!,
      panel: Color.lerp(panel, other.panel, t)!,
      rule: Color.lerp(rule, other.rule, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      selectedConfirmedSave: Color.lerp(
        selectedConfirmedSave,
        other.selectedConfirmedSave,
        t,
      )!,
      selectedConfirmedSaveAccent: Color.lerp(
        selectedConfirmedSaveAccent,
        other.selectedConfirmedSaveAccent,
        t,
      )!,
      measuringArmedMeasured: Color.lerp(
        measuringArmedMeasured,
        other.measuringArmedMeasured,
        t,
      )!,
      draftUnsavedUnknown: Color.lerp(
        draftUnsavedUnknown,
        other.draftUnsavedUnknown,
        t,
      )!,
      draftUnsavedUnknownStrong: Color.lerp(
        draftUnsavedUnknownStrong,
        other.draftUnsavedUnknownStrong,
        t,
      )!,
      draftUnsavedUnknownFill: Color.lerp(
        draftUnsavedUnknownFill,
        other.draftUnsavedUnknownFill,
        t,
      )!,
    );
  }
}

ThemeData buildTheme() {
  const primary = Color(0xFF1F3B73);
  const accent = Color(0xFFF3A712);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primary, secondary: accent),
    extensions: const <ThemeExtension<dynamic>>[
      BenchBeepVisualTokens.darkInstrument,
    ],
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),
  );
}
