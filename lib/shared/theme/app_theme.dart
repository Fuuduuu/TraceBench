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

/// Shared warm Workbench values. The original Canvas aliases remain exact.
abstract final class WorkbenchColors {
  static const Color shell = Color(0xFF0C0C0C);
  static const Color paper = Color(0xFF1A1916);
  static const Color tile = Color(0xFF141310);
  static const Color navy = Color(0xFFF3ECDC);
  static const Color navyDeep = Color(0xFF0A0A0A);
  static const Color muted = Color(0xFFA89F8C);
  static const Color dim = Color(0xFF7E776A);
  static const Color signal = Color(0xFFE7C25A);
  static const Color signalTint = Color(0xFF2A2416);
  static const Color ready = Color(0xFF6FCF97);
  static const Color readyTint = Color(0xFF0E251B);
  static const Color rule = Color(0xFF332E22);
  static const Color ruleStrong = Color(0xFF6B5A30);

  // Essential boundaries and secondary copy must remain readable on surfaces.
  // dim/rule/ruleStrong are retained only for existing Canvas consumers.
  static const Color outline = Color(0xFFB2A48A);
  static const Color raised = Color(0xFF24211B);
  static const Color warning = Color(0xFFF6C453);
  static const Color danger = Color(0xFFEAA6A6);
  static const Color dangerStrong = Color(0xFFFCA5A5);
  static const Color dangerTint = Color(0xFF211417);
  static const Color dangerRaised = Color(0xFF493039);
}

/// Opt-in presentation theme. buildTheme and the global fallback stay unchanged.
ThemeData buildWorkbenchTheme() {
  const c = ColorScheme(
    brightness: Brightness.dark,
    primary: WorkbenchColors.signal,
    onPrimary: WorkbenchColors.navyDeep,
    primaryContainer: WorkbenchColors.signalTint,
    onPrimaryContainer: WorkbenchColors.navy,
    primaryFixed: WorkbenchColors.signal,
    primaryFixedDim: WorkbenchColors.warning,
    onPrimaryFixed: WorkbenchColors.navyDeep,
    onPrimaryFixedVariant: WorkbenchColors.navyDeep,
    secondary: WorkbenchColors.warning,
    onSecondary: WorkbenchColors.navyDeep,
    secondaryContainer: WorkbenchColors.signalTint,
    onSecondaryContainer: WorkbenchColors.warning,
    secondaryFixed: WorkbenchColors.warning,
    secondaryFixedDim: WorkbenchColors.signal,
    onSecondaryFixed: WorkbenchColors.navyDeep,
    onSecondaryFixedVariant: WorkbenchColors.navyDeep,
    tertiary: WorkbenchColors.navy,
    onTertiary: WorkbenchColors.navyDeep,
    tertiaryContainer: WorkbenchColors.raised,
    onTertiaryContainer: WorkbenchColors.navy,
    tertiaryFixed: WorkbenchColors.navy,
    tertiaryFixedDim: WorkbenchColors.outline,
    onTertiaryFixed: WorkbenchColors.navyDeep,
    onTertiaryFixedVariant: WorkbenchColors.navyDeep,
    error: WorkbenchColors.dangerStrong,
    onError: WorkbenchColors.navyDeep,
    errorContainer: WorkbenchColors.dangerTint,
    onErrorContainer: WorkbenchColors.danger,
    surface: WorkbenchColors.paper,
    onSurface: WorkbenchColors.navy,
    surfaceDim: WorkbenchColors.shell,
    surfaceBright: WorkbenchColors.signalTint,
    surfaceContainerLowest: WorkbenchColors.shell,
    surfaceContainerLow: WorkbenchColors.tile,
    surfaceContainer: WorkbenchColors.paper,
    surfaceContainerHigh: WorkbenchColors.raised,
    surfaceContainerHighest: WorkbenchColors.signalTint,
    onSurfaceVariant: WorkbenchColors.muted,
    outline: WorkbenchColors.outline,
    outlineVariant: WorkbenchColors.outline,
    inverseSurface: WorkbenchColors.navy,
    onInverseSurface: WorkbenchColors.navyDeep,
    inversePrimary: Color(0xFF604600),
    surfaceTint: Colors.transparent,
    shadow: Colors.black,
    scrim: Colors.black54,
  );
  final base = ThemeData(useMaterial3: true, colorScheme: c);
  final text = base.textTheme.apply(
    bodyColor: c.onSurface,
    displayColor: c.onSurface,
  );
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: c.outline),
  );
  final inputs = InputDecorationThemeData(
    filled: true,
    fillColor: WorkbenchColors.tile,
    labelStyle: TextStyle(color: c.onSurfaceVariant),
    floatingLabelStyle: TextStyle(color: c.primary),
    hintStyle: TextStyle(color: c.onSurfaceVariant),
    helperStyle: TextStyle(color: c.onSurfaceVariant),
    errorStyle: TextStyle(color: c.error),
    prefixIconColor: c.onSurfaceVariant,
    suffixIconColor: c.onSurfaceVariant,
    border: border,
    enabledBorder: border,
    disabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: BorderSide(color: c.primary, width: 2),
    ),
    errorBorder: border.copyWith(borderSide: BorderSide(color: c.error)),
    focusedErrorBorder: border.copyWith(
      borderSide: BorderSide(color: c.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
  final menu = MenuStyle(
    backgroundColor: const WidgetStatePropertyAll(WorkbenchColors.raised),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    side: WidgetStatePropertyAll(BorderSide(color: c.outline)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  Color stateSurface(Set<WidgetState> states) {
    final alpha = states.contains(WidgetState.pressed)
        ? 0.12
        : states.contains(WidgetState.focused)
            ? 0.10
            : states.contains(WidgetState.hovered)
                ? 0.06
                : 0.0;
    return Color.alphaBlend(c.primary.withValues(alpha: alpha), c.surface);
  }

  Color stateForeground(Set<WidgetState> states) =>
      states.contains(WidgetState.disabled) ? c.onSurfaceVariant : c.onSurface;
  final outlineSide = WidgetStateBorderSide.resolveWith(
    (states) => BorderSide(
      color: states.contains(WidgetState.focused) ? c.primary : c.outline,
      width: states.contains(WidgetState.focused) ? 2 : 1,
    ),
  );
  final localButton = ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith(stateForeground),
    backgroundColor: WidgetStateProperty.resolveWith(stateSurface),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    side: outlineSide,
    minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    textStyle: WidgetStateProperty.resolveWith(
      (states) => text.labelLarge!.copyWith(
        decoration: states.contains(WidgetState.focused)
            ? TextDecoration.underline
            : TextDecoration.none,
      ),
    ),
  );
  final selectionOverlay = WidgetStateProperty.resolveWith<Color?>((states) {
    if (states.contains(WidgetState.disabled)) return Colors.transparent;
    final alpha = states.contains(WidgetState.focused)
        ? 0.10
        : states.contains(WidgetState.pressed)
            ? 0.12
            : states.contains(WidgetState.hovered)
                ? 0.06
                : 0.0;
    return c.primary.withValues(alpha: alpha);
  });
  final filledButton = localButton.copyWith(
    foregroundColor: const WidgetStatePropertyAll(WorkbenchColors.navyDeep),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return WorkbenchColors.outline;
      final alpha = states.contains(WidgetState.pressed)
          ? 0.12
          : states.contains(WidgetState.focused)
              ? 0.08
              : states.contains(WidgetState.hovered)
                  ? 0.04
                  : 0.0;
      return Color.alphaBlend(
        WorkbenchColors.navyDeep.withValues(alpha: alpha),
        c.primary,
      );
    }),
    side: const WidgetStatePropertyAll(BorderSide.none),
    elevation: const WidgetStatePropertyAll(0),
  );
  return base.copyWith(
    textTheme: text,
    primaryTextTheme: text,
    scaffoldBackgroundColor: c.surface,
    canvasColor: c.surface,
    cardColor: WorkbenchColors.tile,
    disabledColor: c.onSurfaceVariant,
    focusColor: c.primary.withValues(alpha: 0.10),
    hoverColor: c.primary.withValues(alpha: 0.06),
    highlightColor: c.primary.withValues(alpha: 0.12),
    splashColor: c.primary.withValues(alpha: 0.12),
    dividerColor: WorkbenchColors.rule,
    iconTheme: IconThemeData(color: c.onSurface),
    primaryIconTheme: IconThemeData(color: c.onPrimary),
    inputDecorationTheme: inputs,
    cardTheme: CardThemeData(
      color: WorkbenchColors.tile,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: WorkbenchColors.rule),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: WorkbenchColors.raised,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: text.titleLarge,
      contentTextStyle: text.bodyMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: c.outline),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: WorkbenchColors.raised,
      surfaceTintColor: Colors.transparent,
      textStyle: text.bodyMedium,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => text.bodyMedium!.copyWith(
          color: states.contains(WidgetState.selected)
              ? c.primary
              : stateForeground(states),
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: c.outline),
      ),
    ),
    menuTheme: MenuThemeData(style: menu),
    menuButtonTheme: MenuButtonThemeData(style: localButton),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: text.bodyMedium,
      disabledColor: c.onSurfaceVariant,
      inputDecorationTheme: inputs,
      menuStyle: menu,
    ),
    chipTheme: ChipThemeData(
      color: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? c.primaryContainer
            : stateSurface(states),
      ),
      labelStyle: TextStyle(color: c.onSurface),
      secondaryLabelStyle: TextStyle(color: c.onPrimaryContainer),
      checkmarkColor: c.primary,
      deleteIconColor: c.onSurface,
      showCheckmark: true,
      side: outlineSide,
      surfaceTintColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    ),
    filledButtonTheme: FilledButtonThemeData(style: filledButton),
    elevatedButtonTheme: ElevatedButtonThemeData(style: filledButton),
    outlinedButtonTheme: OutlinedButtonThemeData(style: localButton),
    textButtonTheme: TextButtonThemeData(
      style: localButton.copyWith(
        side: WidgetStateBorderSide.resolveWith(
          (states) => states.contains(WidgetState.focused)
              ? BorderSide(color: c.primary, width: 2)
              : BorderSide.none,
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(style: localButton),
    tooltipTheme: TooltipThemeData(
      textStyle: TextStyle(color: c.onInverseSurface),
      decoration: BoxDecoration(
        color: c.inverseSurface,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: c.inverseSurface,
      contentTextStyle: TextStyle(color: c.onInverseSurface),
      actionTextColor: c.inversePrimary,
      disabledActionTextColor: c.onInverseSurface,
      behavior: SnackBarBehavior.floating,
    ),
    listTileTheme: ListTileThemeData(
      textColor: c.onSurface,
      iconColor: c.primary,
      selectedColor: c.onSurface,
      selectedTileColor: c.primaryContainer,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? c.primary : c.surface,
      ),
      checkColor: WidgetStatePropertyAll(c.onPrimary),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(
          color: states.contains(WidgetState.selected) ? c.primary : c.outline,
          width: states.contains(WidgetState.focused) ? 2 : 1,
        ),
      ),
      overlayColor: selectionOverlay,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? c.primary : c.outline,
      ),
      overlayColor: selectionOverlay,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? c.onPrimary : c.onSurface,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? c.primary : c.surface,
      ),
      trackOutlineColor: WidgetStatePropertyAll(c.outline),
      overlayColor: selectionOverlay,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: c.primary,
      selectionColor: c.primary.withValues(alpha: 0.20),
      selectionHandleColor: c.primary,
    ),
  );
}

/// Leaves the closed trigger's ambient Theme intact. Flutter captures this
/// InheritedTheme when opening a transient menu, so only that route opts in.
class WorkbenchPopupTheme extends InheritedTheme {
  const WorkbenchPopupTheme({required super.child, super.key});

  @override
  Widget wrap(BuildContext context, Widget child) =>
      Theme(data: buildWorkbenchTheme(), child: child);

  @override
  bool updateShouldNotify(WorkbenchPopupTheme oldWidget) => false;
}
