import 'package:flutter/material.dart';

/// BenchBeep launcher home screen — black & gold instrument theme.
///
/// Drop-in replacement for the previous `benchbeep_home_screen.dart`.
/// Public API (class name + constructor) is unchanged, so the router /
/// wrapper that builds this screen needs no edits.
///
/// Requires two bundled assets (see pubspec snippet in README):
///   assets/brand/benchbeep_mark.png   — gold probe/trace mark
///   assets/brand/pcb_board.png        — feathered gold PCB photo
class BenchBeepHomeScreen extends StatelessWidget {
  const BenchBeepHomeScreen({
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onImportProject,
    required this.onOpenProjectFolder,
    required this.onOpenProject,
    required this.onOpenWorkbench,
    super.key,
  });

  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context)? onImportProject;
  final Future<void> Function(BuildContext context) onOpenProjectFolder;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;

  // ---- black & gold palette ----
  static const _bg = Color(0xFF0C0C0C);
  static const _panel = Color(0xFF1A1916);
  static const _panel2 = Color(0xFF141310);
  static const _inset = Color(0xFF0A0A0A);
  static const _edge = Color(0xFF332E22);
  static const _edgeGold = Color(0xFF6B5A30);
  static const _frame = Color(0xFF8A7338);
  static const _gold = Color(0xFFE7C25A);
  static const _goldBright = Color(0xFFF0CF6A);
  static const _goldDim = Color(0xFFCDA64C);
  static const _activeFill = Color(0x17E7C25A);
  static const _hoverFill = Color(0x24E7C25A);
  static const _softGlow = Color(0x2BE7C25A);
  static const _cream = Color(0xFFF3ECDC);
  static const _muted = Color(0xFFA89F8C);
  static const _faint = Color(0xFF7E776A);
  static const _ready = Color(0xFF6FCF97);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('benchbeep_home_launcher'),
      backgroundColor: _bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 1320;
            final pad = isNarrow ? 16.0 : 26.0;

            final rail = _LauncherRail(
              hasProject: hasProject,
              onLoadBundledProject: onLoadBundledProject,
              onImportProject: onImportProject,
              onOpenProjectFolder: onOpenProjectFolder,
              onOpenProject: onOpenProject,
              onOpenWorkbench: onOpenWorkbench,
            );
            final right = _RightColumn(
              hasProject: hasProject,
              onLoadBundledProject: onLoadBundledProject,
              onOpenProjectFolder: onOpenProjectFolder,
              onOpenProject: onOpenProject,
              onOpenWorkbench: onOpenWorkbench,
            );

            final body = isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [rail, const SizedBox(height: 16), right],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 360, child: rail),
                      const SizedBox(width: 18),
                      Expanded(child: right),
                    ],
                  );

            return DecoratedBox(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.7, -0.9),
                  radius: 1.2,
                  colors: [Color(0xFF1C1812), _bg],
                  stops: [0.0, 0.6],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(pad),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1340),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _MenuBar(
                          hasProject: hasProject,
                          onOpenProject: onOpenProject,
                          onOpenWorkbench: onOpenWorkbench,
                          onImportProject: onImportProject,
                        ),
                        const SizedBox(height: 16),
                        body,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================ menu bar ============================
class _MenuBar extends StatelessWidget {
  const _MenuBar({
    required this.hasProject,
    required this.onOpenProject,
    required this.onOpenWorkbench,
    required this.onImportProject,
  });

  final bool hasProject;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;
  final Future<void> Function(BuildContext context)? onImportProject;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('benchbeep_app_menu_bar'),
      decoration: BoxDecoration(
        color: const Color(0x99131110),
        border: Border.all(color: BenchBeepHomeScreen._frame),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const _Pill(
            label: 'Instrument menu',
            mono: true,
            color: BenchBeepHomeScreen._gold,
            border: BenchBeepHomeScreen._edgeGold,
          ),
          const _Pill(
            key: ValueKey('benchbeep_menu_home_item'),
            label: 'Home',
            active: true,
            color: BenchBeepHomeScreen._gold,
            border: BenchBeepHomeScreen._edgeGold,
          ),
          _NavTab(
            key: const ValueKey('benchbeep_menu_workbench_button'),
            label: 'Workbench',
            onPressed: hasProject ? onOpenProject : onOpenWorkbench,
          ),
          _NavTab(
            key: const ValueKey('benchbeep_menu_import_button'),
            label: 'Import',
            onPressed: onImportProject == null
                ? null
                : () => onImportProject!(context),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    super.key,
    required this.label,
    this.active = false,
    this.mono = false,
    required this.color,
    required this.border,
  });

  final String label;
  final bool active;
  final bool mono;
  final Color color;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? const Color(0x1FE7C25A) : Colors.transparent,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(11),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: mono ? 12.5 : 14,
          fontFeatures: mono ? const [FontFeature.tabularFigures()] : null,
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (!enabled) return BenchBeepHomeScreen._faint;
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return BenchBeepHomeScreen._gold;
          }
          return BenchBeepHomeScreen._muted;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (!enabled) return Colors.transparent;
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return BenchBeepHomeScreen._hoverFill;
          }
          if (states.contains(WidgetState.pressed)) {
            return BenchBeepHomeScreen._activeFill;
          }
          return Colors.transparent;
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        side: WidgetStateProperty.resolveWith((states) {
          final warm = enabled &&
              (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed));
          return BorderSide(
            color: warm ? BenchBeepHomeScreen._frame : Colors.transparent,
          );
        }),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}

// ============================ left rail ============================
class _LauncherRail extends StatelessWidget {
  const _LauncherRail({
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onImportProject,
    required this.onOpenProjectFolder,
    required this.onOpenProject,
    required this.onOpenWorkbench,
  });

  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context)? onImportProject;
  final Future<void> Function(BuildContext context) onOpenProjectFolder;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('benchbeep_home_board_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _BrandPlate(),
        const SizedBox(height: 10),
        const _ModeButton(
          key: ValueKey('benchbeep_home_new_project_deferred'),
          index: '01',
          label: 'Start new',
          detail: 'deferred',
          enabled: false,
          active: false,
          onPressed: null,
        ),
        const SizedBox(height: 11),
        _ModeButton(
          key: const ValueKey('benchbeep_home_open_workbench_button'),
          index: '02',
          label: hasProject ? 'Ava projekt' : 'Open existing',
          detail: 'workbench context',
          enabled: true,
          active: true,
          onPressed: hasProject ? onOpenProject : onOpenWorkbench,
        ),
        const SizedBox(height: 11),
        _ModeButton(
          key: const ValueKey('benchbeep_home_import_project_button'),
          index: '03',
          label: 'Import project',
          detail: 'existing ZIP flow',
          enabled: onImportProject != null,
          active: false,
          onPressed:
              onImportProject == null ? null : () => onImportProject!(context),
        ),
        const SizedBox(height: 11),
        _ModeButton(
          key: const ValueKey('benchbeep_home_sample_project_button'),
          index: '04',
          label: 'Ava näidisprojekt',
          detail: 'read-only baseline',
          enabled: true,
          active: false,
          onPressed: onLoadBundledProject,
        ),
        const SizedBox(height: 16),
        _RailStatus(hasProject: hasProject),
      ],
    );
  }
}

class _BrandPlate extends StatelessWidget {
  const _BrandPlate();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._panel,
        border: Border.all(color: BenchBeepHomeScreen._edgeGold),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33E7C25A),
            blurRadius: 30,
            spreadRadius: -16,
            offset: Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BenchBeepLockup(),
          SizedBox(height: 13),
          Text(
            'Measurement Data Visualization',
            key: ValueKey('benchbeep_home_title'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: BenchBeepHomeScreen._goldDim,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'TraceBench Viewer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: BenchBeepHomeScreen._muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Combined lockup: gold mark image + `bench beep` wordmark.
/// Only the beep arcs pulse — the rest of the lockup stays still.
class _BenchBeepLockup extends StatelessWidget {
  const _BenchBeepLockup();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/brand/benchbeep_mark.png',
          height: 64,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const SizedBox(height: 64),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'bench',
              style: TextStyle(
                color: BenchBeepHomeScreen._gold,
                fontSize: 38,
                height: 0.9,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'beep',
              style: TextStyle(
                color: BenchBeepHomeScreen._cream,
                fontSize: 38,
                height: 0.9,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(width: 6),
            _BeepArcs(size: 30),
          ],
        ),
      ],
    );
  }
}

/// The "beep" emission arcs glow in once so widget tests can settle.
class _BeepArcs extends StatefulWidget {
  const _BeepArcs({required this.size});

  final double size;

  @override
  State<_BeepArcs> createState() => _BeepArcsState();
}

class _BeepArcsState extends State<_BeepArcs>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
    _opacity = Tween<double>(begin: 0.95, end: 0.24).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SizedBox(
        width: widget.size,
        height: widget.size * 1.5,
        child: CustomPaint(painter: _BeepArcsPainter()),
      ),
    );
  }
}

class _BeepArcsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = BenchBeepHomeScreen._goldBright
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final cx = size.width * 0.18;
    final cy = size.height * 0.5;
    final unit = size.height / 42.0;
    final arcs = [
      [7.0, 3.0],
      [13.0, 3.4],
      [19.0, 3.8],
      [25.0, 4.2],
    ];
    for (final a in arcs) {
      final r = a[0] * unit;
      paint.strokeWidth = a[1] * unit;
      final rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);
      // right-facing arc, ~120°
      canvas.drawArc(rect, -1.05, 2.10, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ModeButton extends StatefulWidget {
  const _ModeButton({
    super.key,
    required this.index,
    required this.label,
    required this.detail,
    required this.enabled,
    required this.active,
    required this.onPressed,
  });

  final String index;
  final String label;
  final String detail;
  final bool enabled;
  final bool active;
  final VoidCallback? onPressed;

  @override
  State<_ModeButton> createState() => _ModeButtonState();
}

class _ModeButtonState extends State<_ModeButton> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final interactive = widget.enabled && widget.onPressed != null;
    final lifted = interactive && (_hovered || _focused);
    final border = widget.active
        ? (lifted
            ? BenchBeepHomeScreen._goldBright
            : BenchBeepHomeScreen._frame)
        : lifted
            ? BenchBeepHomeScreen._goldDim
            : BenchBeepHomeScreen._edgeGold;
    final fg = widget.enabled
        ? BenchBeepHomeScreen._cream
        : BenchBeepHomeScreen._faint;
    final surface = widget.active
        ? BenchBeepHomeScreen._activeFill
        : lifted
            ? BenchBeepHomeScreen._hoverFill
            : BenchBeepHomeScreen._panel;

    return AnimatedScale(
      scale: lifted ? 1.004 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: border, width: widget.active || lifted ? 1.4 : 1),
          borderRadius: BorderRadius.circular(13),
          boxShadow: lifted || widget.active
              ? const [
                  BoxShadow(
                    color: BenchBeepHomeScreen._softGlow,
                    blurRadius: 24,
                    spreadRadius: -14,
                    offset: Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: surface,
          animationDuration: const Duration(milliseconds: 120),
          borderRadius: BorderRadius.circular(13),
          child: InkWell(
            onTap: interactive ? widget.onPressed : null,
            onHover: interactive
                ? (hovered) => setState(() => _hovered = hovered)
                : null,
            onFocusChange: interactive
                ? (focused) => setState(() => _focused = focused)
                : null,
            borderRadius: BorderRadius.circular(13),
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: BenchBeepHomeScreen._activeFill,
            splashColor: BenchBeepHomeScreen._hoverFill,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(
                    widget.index,
                    style: TextStyle(
                      color: widget.active || lifted
                          ? BenchBeepHomeScreen._gold
                          : BenchBeepHomeScreen._faint,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: TextStyle(
                            color: widget.active || lifted
                                ? BenchBeepHomeScreen._gold
                                : fg,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.detail,
                          style: const TextStyle(
                            color: BenchBeepHomeScreen._muted,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: widget.active || lifted
                        ? BenchBeepHomeScreen._gold
                        : BenchBeepHomeScreen._goldDim,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RailStatus extends StatelessWidget {
  const _RailStatus({required this.hasProject});

  final bool hasProject;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: hasProject
                    ? BenchBeepHomeScreen._ready
                    : BenchBeepHomeScreen._gold,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (hasProject
                            ? BenchBeepHomeScreen._ready
                            : BenchBeepHomeScreen._gold)
                        .withValues(alpha: 0.6),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                hasProject ? 'Sample loaded' : 'Ready',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: hasProject
                      ? BenchBeepHomeScreen._ready
                      : BenchBeepHomeScreen._gold,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ),
            const Text(
              'TraceBench platform',
              style: TextStyle(
                color: BenchBeepHomeScreen._muted,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _ProgressBar(active: hasProject),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    const total = 34;
    final on = active ? 19 : 0;
    const tick = 20;
    return SizedBox(
      height: 18,
      child: Row(
        children: List.generate(total, (i) {
          Color c = const Color(0xFF2A2620);
          if (i < on) {
            c = BenchBeepHomeScreen._ready;
          } else if (active && i == tick) {
            c = BenchBeepHomeScreen._gold;
          }
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ============================ right column ============================
class _RightColumn extends StatelessWidget {
  const _RightColumn({
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onOpenProjectFolder,
    required this.onOpenProject,
    required this.onOpenWorkbench,
  });

  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context) onOpenProjectFolder;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _QuickStartStrip(),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, c) {
            final detail = _DetailPanel(
              hasProject: hasProject,
              onLoadBundledProject: onLoadBundledProject,
              onOpenProjectFolder: onOpenProjectFolder,
              onOpenProject: onOpenProject,
              onOpenWorkbench: onOpenWorkbench,
            );
            const hero = _HeroBoard();
            if (c.maxWidth < 900) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  detail,
                  const SizedBox(height: 16),
                  hero,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 11, child: detail),
                const SizedBox(width: 16),
                const Expanded(flex: 9, child: hero),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _QuickStartStrip extends StatelessWidget {
  const _QuickStartStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._panel2,
        border: Border.all(color: BenchBeepHomeScreen._edge),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.menu_book_outlined,
              color: BenchBeepHomeScreen._gold, size: 46),
          SizedBox(width: 22),
          Expanded(
            child: Wrap(
              spacing: 36,
              runSpacing: 8,
              children: [
                _QuickItem(n: '01.', label: 'Start new', note: '(deferred)'),
                _QuickItem(
                    n: '04.', label: 'Näidisprojekt', note: '(read-only)'),
                _QuickItem(n: '02.', label: 'Workbench', note: '(project)'),
                _QuickItem(
                    n: '05.', label: 'Tutorial: Basic Measurement Setup'),
                _QuickItem(
                    n: '03.', label: 'Import project', note: '(existing ZIP)'),
                _QuickItem(n: '06.', label: 'Quick-Start Guide', note: '(PDF)'),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'QUICK START',
                style: TextStyle(
                  color: BenchBeepHomeScreen._gold,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 1.4,
                ),
              ),
              Text(
                '& TUTORIALS',
                style: TextStyle(
                  color: BenchBeepHomeScreen._goldDim,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickItem extends StatelessWidget {
  const _QuickItem({required this.n, required this.label, this.note});

  final String n;
  final String label;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 212,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            n,
            style: const TextStyle(
              color: BenchBeepHomeScreen._gold,
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: BenchBeepHomeScreen._cream,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          if (note != null) ...[
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                note!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: BenchBeepHomeScreen._muted,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailPanel extends StatelessWidget {
  const _DetailPanel({
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onOpenProjectFolder,
    required this.onOpenProject,
    required this.onOpenWorkbench,
  });

  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context) onOpenProjectFolder;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._panel,
        border: Border.all(color: BenchBeepHomeScreen._edgeGold),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2BE7C25A),
            blurRadius: 34,
            spreadRadius: -18,
            offset: Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(26, 24, 26, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'OPEN EXISTING',
            style: TextStyle(
              color: BenchBeepHomeScreen._gold,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Board workbench',
            style: TextStyle(
              color: BenchBeepHomeScreen._cream,
              fontWeight: FontWeight.w700,
              fontSize: 30,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Pick up the board exactly where the diagnostic context lives.',
            style: TextStyle(
              color: BenchBeepHomeScreen._muted,
              fontSize: 14.5,
            ),
          ),
          const SizedBox(height: 22),
          _ProjectRow(
            label: 'Pelle PV20',
            type: 'burner_controller · bundled sample',
            active: hasProject,
            onTap: hasProject ? onOpenProject : onLoadBundledProject,
          ),
          const SizedBox(height: 12),
          _ProjectRow(
            label: 'Open Workbench',
            type: 'current board canvas context',
            active: false,
            onTap: onOpenWorkbench,
          ),
          const SizedBox(height: 12),
          _ProjectRow(
            label: 'Ava projekt kaustast',
            type: 'existing local folder · writable when valid',
            active: false,
            onTap: () {
              onOpenProjectFolder(context);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectRow extends StatefulWidget {
  const _ProjectRow({
    required this.label,
    required this.type,
    required this.active,
    required this.onTap,
  });

  final String label;
  final String type;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final lifted = _hovered || _focused;
    final border = widget.active
        ? (lifted
            ? BenchBeepHomeScreen._goldBright
            : BenchBeepHomeScreen._frame)
        : lifted
            ? BenchBeepHomeScreen._goldDim
            : BenchBeepHomeScreen._edgeGold;
    final surface = widget.active
        ? const Color(0x14E7C25A)
        : lifted
            ? BenchBeepHomeScreen._hoverFill
            : BenchBeepHomeScreen._panel2;

    return AnimatedScale(
      scale: lifted ? 1.003 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: border, width: widget.active || lifted ? 1.4 : 1),
          borderRadius: BorderRadius.circular(13),
          boxShadow: lifted || widget.active
              ? const [
                  BoxShadow(
                    color: BenchBeepHomeScreen._softGlow,
                    blurRadius: 24,
                    spreadRadius: -14,
                    offset: Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: surface,
          animationDuration: const Duration(milliseconds: 120),
          borderRadius: BorderRadius.circular(13),
          child: InkWell(
            onTap: widget.onTap,
            onHover: (hovered) => setState(() => _hovered = hovered),
            onFocusChange: (focused) => setState(() => _focused = focused),
            borderRadius: BorderRadius.circular(13),
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: BenchBeepHomeScreen._activeFill,
            splashColor: BenchBeepHomeScreen._hoverFill,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  const _MiniBoardGlyph(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: widget.active || lifted
                                ? BenchBeepHomeScreen._gold
                                : BenchBeepHomeScreen._cream,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: BenchBeepHomeScreen._muted,
                            fontSize: 12.5,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.chevron_right,
                    color: widget.active || lifted
                        ? BenchBeepHomeScreen._gold
                        : BenchBeepHomeScreen._goldDim,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniBoardGlyph extends StatelessWidget {
  const _MiniBoardGlyph();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 38,
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._inset,
        border: Border.all(color: BenchBeepHomeScreen._edgeGold),
        borderRadius: BorderRadius.circular(9),
      ),
      child: CustomPaint(painter: _MiniBoardGlyphPainter()),
    );
  }
}

class _MiniBoardGlyphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final trace = Paint()
      ..color = BenchBeepHomeScreen._edgeGold
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;
    final gold = Paint()..color = BenchBeepHomeScreen._gold;
    final goldDim = Paint()..color = BenchBeepHomeScreen._goldDim;

    final lt = Offset(size.width * 0.26, size.height * 0.32);
    final rt = Offset(size.width * 0.74, size.height * 0.32);
    final lb = Offset(size.width * 0.26, size.height * 0.68);
    final rb = Offset(size.width * 0.74, size.height * 0.68);
    final c = Offset(size.width * 0.5, size.height * 0.5);
    canvas.drawLine(lt, c, trace);
    canvas.drawLine(c, rb, trace);
    canvas.drawLine(rt, c, trace);
    canvas.drawLine(c, lb, trace);
    canvas.drawCircle(lt, 2.6, gold);
    canvas.drawCircle(rb, 2.6, gold);
    canvas.drawCircle(rt, 2.6, goldDim);
    canvas.drawCircle(lb, 2.6, goldDim);
    canvas.drawCircle(c, 2.8, gold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Full-bleed gold PCB photo. The asset is pre-feathered (transparent
/// edges) and we add an inner vignette so it melts into the black panel.
class _HeroBoard extends StatelessWidget {
  const _HeroBoard();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.18,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: BenchBeepHomeScreen._inset,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/brand/pcb_board.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
              // Thin edge feathers hide the source image rectangle while
              // keeping the board center and lower text readable.
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xDD060D0A),
                      Color(0x88060D0A),
                      Colors.transparent,
                      Colors.transparent,
                      Color(0x88060D0A),
                      Color(0xDD060D0A),
                    ],
                    stops: [0.0, 0.035, 0.075, 0.925, 0.965, 1.0],
                  ),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xDD060D0A),
                      Color(0x88060D0A),
                      Colors.transparent,
                      Colors.transparent,
                      Color(0x88060D0A),
                      Color(0xDD060D0A),
                    ],
                    stops: [0.0, 0.035, 0.075, 0.925, 0.965, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
