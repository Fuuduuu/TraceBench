import 'package:flutter/material.dart';

/// BenchBeep startup launcher in the established black and gold identity.
class BenchBeepHomeScreen extends StatefulWidget {
  const BenchBeepHomeScreen({
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onImportProject,
    required this.onOpenProjectFolder,
    required this.onOpenProject,
    required this.onOpenWorkbench,
    required this.onExitRequested,
    super.key,
  });

  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context)? onImportProject;
  final Future<void> Function(BuildContext context) onOpenProjectFolder;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;
  final Future<void> Function() onExitRequested;

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
  static const _exit = Color(0xFFE08A55);

  @override
  State<BenchBeepHomeScreen> createState() => _BenchBeepHomeScreenState();
}

class _BenchBeepHomeScreenState extends State<BenchBeepHomeScreen> {
  final GlobalKey _rightColumnKey = GlobalKey();
  late bool _showLoadDetail;

  @override
  void initState() {
    super.initState();
    _showLoadDetail = !widget.hasProject;
  }

  @override
  void didUpdateWidget(covariant BenchBeepHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasProject != widget.hasProject) {
      _showLoadDetail = !widget.hasProject;
    }
  }

  void _selectLoadDetail() {
    if (!_showLoadDetail) {
      setState(() {
        _showLoadDetail = true;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final detailContext = _rightColumnKey.currentContext;
      if (detailContext == null || !mounted) {
        return;
      }
      Scrollable.ensureVisible(
        detailContext,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        alignment: 0.08,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('benchbeep_home_launcher'),
      backgroundColor: BenchBeepHomeScreen._bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 1400;
            final isCompact = constraints.maxWidth < 900;
            final padding = constraints.maxWidth >= 720 ? 20.0 : 16.0;
            final rail = _LauncherRail(
              hasProject: widget.hasProject,
              loadSelected: _showLoadDetail,
              showSampleAction: isCompact,
              onLoadBundledProject: widget.onLoadBundledProject,
              onOpenProject: widget.onOpenProject,
              onSelectLoad: _selectLoadDetail,
            );
            final detail = KeyedSubtree(
              key: _rightColumnKey,
              child: _RightColumn(
                hasProject: widget.hasProject,
                showLoadDetail: _showLoadDetail,
                onImportProject: widget.onImportProject,
                onOpenProjectFolder: widget.onOpenProjectFolder,
                onOpenWorkbench: widget.onOpenWorkbench,
                onLoadBundledProject: widget.onLoadBundledProject,
                showSampleAction: !isCompact,
              ),
            );
            final availableBodyHeight = constraints.hasBoundedHeight
                ? constraints.maxHeight - (padding * 2) - 64 - 18
                : 720.0;
            final desktopBodyHeight =
                availableBodyHeight < 650 ? 650.0 : availableBodyHeight;
            final body = !isWide
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      rail,
                      const SizedBox(height: 18),
                      detail,
                    ],
                  )
                : SizedBox(
                    height: desktopBodyHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(width: 392, child: rail),
                        const SizedBox(width: 18),
                        Expanded(child: detail),
                      ],
                    ),
                  );

            return DecoratedBox(
              key: const ValueKey('benchbeep_home_frame'),
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  center: Alignment(-0.7, -0.9),
                  radius: 1.2,
                  colors: [
                    Color(0xFF1C1812),
                    BenchBeepHomeScreen._bg,
                  ],
                  stops: [0, 0.6],
                ),
                border: Border.all(color: BenchBeepHomeScreen._frame),
                borderRadius: BorderRadius.circular(26),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(padding),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1840),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _MenuBar(onExitRequested: widget.onExitRequested),
                        const SizedBox(height: 18),
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

class _MenuBar extends StatelessWidget {
  const _MenuBar({required this.onExitRequested});

  final Future<void> Function() onExitRequested;

  Future<void> _confirmExit(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierColor: const Color(0xB8050505),
      builder: (dialogContext) {
        return AlertDialog(
          key: const ValueKey('benchbeep_exit_dialog'),
          backgroundColor: BenchBeepHomeScreen._panel,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
          insetPadding: const EdgeInsets.all(24),
          constraints: const BoxConstraints.tightFor(width: 460),
          titlePadding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
          contentPadding: const EdgeInsets.fromLTRB(26, 14, 26, 0),
          actionsPadding: const EdgeInsets.fromLTRB(26, 14, 26, 22),
          actionsAlignment: MainAxisAlignment.start,
          titleTextStyle: const TextStyle(
            color: BenchBeepHomeScreen._cream,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
          contentTextStyle: const TextStyle(
            color: BenchBeepHomeScreen._muted,
            fontSize: 15,
            height: 1.5,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: BenchBeepHomeScreen._frame),
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Kas väljuda BenchBeepist?'),
          content: const Text('Rakendus suletakse.'),
          actions: [
            TextButton(
              key: const ValueKey('benchbeep_exit_cancel_button'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: BenchBeepHomeScreen._muted,
                side: const BorderSide(color: BenchBeepHomeScreen._edge),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Tühista'),
            ),
            TextButton(
              key: const ValueKey('benchbeep_exit_confirm_button'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: BenchBeepHomeScreen._exit,
                side: const BorderSide(color: BenchBeepHomeScreen._exit),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Välju'),
            ),
          ],
        );
      },
    );
    if (shouldExit == true) {
      await onExitRequested();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('benchbeep_app_menu_bar'),
      decoration: BoxDecoration(
        color: const Color(0x99131110),
        border: Border.all(color: BenchBeepHomeScreen._frame),
        borderRadius: BorderRadius.circular(16),
      ),
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final brand = const _CompactBrand();
          final actions = Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton(
                key: const ValueKey('benchbeep_home_settings_button'),
                onPressed: null,
                style: TextButton.styleFrom(
                  disabledForegroundColor: BenchBeepHomeScreen._faint,
                  side: const BorderSide(color: BenchBeepHomeScreen._edge),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Seaded'),
                    SizedBox(width: 8),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(color: BenchBeepHomeScreen._edge),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(999)),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        child: Text(
                          'Tulekul',
                          style: TextStyle(fontSize: 11, letterSpacing: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                key: const ValueKey('benchbeep_home_exit_button'),
                onPressed: () => _confirmExit(context),
                style: TextButton.styleFrom(
                  foregroundColor: BenchBeepHomeScreen._exit,
                  side: const BorderSide(color: BenchBeepHomeScreen._exit),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: const Text('Välju'),
              ),
            ],
          );
          if (constraints.maxWidth < 900) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                brand,
                const SizedBox(height: 10),
                actions,
              ],
            );
          }
          return Row(
            children: [
              brand,
              const Spacer(),
              actions,
            ],
          );
        },
      ),
    );
  }
}

class _CompactBrand extends StatelessWidget {
  const _CompactBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/brand/benchbeep_mark.png',
          height: 38,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const SizedBox(width: 38, height: 38),
        ),
        const SizedBox(width: 8),
        const Text(
          'bench',
          style: TextStyle(
            color: BenchBeepHomeScreen._gold,
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const Text(
          'beep',
          style: TextStyle(
            color: BenchBeepHomeScreen._cream,
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(width: 10),
        const _Pill(label: 'Alusta tööd'),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._activeFill,
        border: Border.all(color: BenchBeepHomeScreen._edgeGold),
        borderRadius: BorderRadius.circular(999),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        label,
        style: const TextStyle(
          color: BenchBeepHomeScreen._goldDim,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _LauncherRail extends StatelessWidget {
  const _LauncherRail({
    required this.hasProject,
    required this.loadSelected,
    required this.showSampleAction,
    required this.onLoadBundledProject,
    required this.onOpenProject,
    required this.onSelectLoad,
  });

  final bool hasProject;
  final bool loadSelected;
  final bool showSampleAction;
  final Future<void> Function() onLoadBundledProject;
  final VoidCallback onOpenProject;
  final VoidCallback onSelectLoad;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('benchbeep_home_board_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _LauncherIntro(),
        if (showSampleAction) ...[
          _SampleProjectButton(onPressed: onLoadBundledProject),
          const SizedBox(height: 10),
        ],
        const _ModeButton(
          key: ValueKey('benchbeep_home_new_project_deferred'),
          index: '01',
          label: 'Loo projekt nullist',
          detail: 'plaadi kontuur ja komponendid',
          badge: 'Tulekul',
          enabled: false,
          active: false,
          onPressed: null,
        ),
        const SizedBox(height: 11),
        _ModeButton(
          key: const ValueKey('benchbeep_home_open_workbench_button'),
          index: '02',
          label: 'Jätka avatud projektiga',
          detail: hasProject
              ? 'Pelle PV20 · visuaalne töölaud'
              : 'ühtegi projekti pole avatud',
          enabled: hasProject,
          active: hasProject,
          onPressed: hasProject ? onOpenProject : null,
        ),
        const SizedBox(height: 11),
        _ModeButton(
          key: const ValueKey('benchbeep_home_load_project_choice'),
          index: '03',
          label: 'Lae projekt',
          detail: 'ZIP-pakk või kohalik kaust',
          enabled: true,
          active: loadSelected,
          onPressed: onSelectLoad,
        ),
        const SizedBox(height: 11),
        const _ModeButton(
          key: ValueKey('benchbeep_home_phone_setup_deferred'),
          index: '04',
          label: 'Seadista telefon',
          detail: 'plaadi pildistamine',
          badge: 'Tulekul',
          enabled: false,
          active: false,
          onPressed: null,
        ),
        const SizedBox(height: 16),
        _RailStatus(hasProject: hasProject),
      ],
    );
  }
}

class _LauncherIntro extends StatelessWidget {
  const _LauncherIntro();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(2, 8, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VISUAL-FIRST TECHNICIAN WORKBENCH',
            style: TextStyle(
              color: BenchBeepHomeScreen._goldDim,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
          SizedBox(height: 9),
          Text(
            'Visuaalne remonditöölaud',
            key: ValueKey('benchbeep_home_title'),
            style: TextStyle(
              color: BenchBeepHomeScreen._cream,
              fontSize: 29,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Foto, markerid, mõõtmised ja inimese kinnitatud tähelepanekud '
            'ühel visuaalsel töölaual.',
            style: TextStyle(
              color: BenchBeepHomeScreen._muted,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
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
    this.badge,
  });

  final String index;
  final String label;
  final String detail;
  final String? badge;
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
    final border = !widget.enabled
        ? BenchBeepHomeScreen._edge
        : widget.active
            ? (lifted
                ? BenchBeepHomeScreen._goldBright
                : BenchBeepHomeScreen._frame)
            : lifted
                ? BenchBeepHomeScreen._goldDim
                : BenchBeepHomeScreen._edgeGold;
    final surface = !widget.enabled
        ? BenchBeepHomeScreen._panel2
        : widget.active
            ? BenchBeepHomeScreen._activeFill
            : lifted
                ? BenchBeepHomeScreen._hoverFill
                : BenchBeepHomeScreen._panel;

    return AnimatedScale(
      scale: lifted ? 1.004 : 1,
      duration: const Duration(milliseconds: 120),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: border,
            width: widget.active || lifted ? 1.4 : 1,
          ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                            color: !widget.enabled
                                ? BenchBeepHomeScreen._muted
                                : widget.active || lifted
                                    ? BenchBeepHomeScreen._gold
                                    : BenchBeepHomeScreen._cream,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.detail,
                          style: const TextStyle(
                            color: BenchBeepHomeScreen._faint,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (widget.badge != null)
                    _SoonBadge(label: widget.badge!)
                  else
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

class _SoonBadge extends StatelessWidget {
  const _SoonBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: BenchBeepHomeScreen._edgeGold),
        borderRadius: BorderRadius.circular(999),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      child: Text(
        label,
        style: const TextStyle(
          color: BenchBeepHomeScreen._goldDim,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
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
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: BenchBeepHomeScreen._edge)),
      ),
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: hasProject
                  ? BenchBeepHomeScreen._ready
                  : BenchBeepHomeScreen._faint,
              shape: BoxShape.circle,
              boxShadow: hasProject
                  ? const [
                      BoxShadow(
                        color: BenchBeepHomeScreen._ready,
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              hasProject ? 'Projekt avatud' : 'Ühtegi projekti pole avatud',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: hasProject
                    ? BenchBeepHomeScreen._ready
                    : BenchBeepHomeScreen._faint,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn({
    required this.hasProject,
    required this.showLoadDetail,
    required this.onImportProject,
    required this.onOpenProjectFolder,
    required this.onOpenWorkbench,
    required this.onLoadBundledProject,
    required this.showSampleAction,
  });

  final bool hasProject;
  final bool showLoadDetail;
  final Future<void> Function(BuildContext context)? onImportProject;
  final Future<void> Function(BuildContext context) onOpenProjectFolder;
  final VoidCallback onOpenWorkbench;
  final Future<void> Function() onLoadBundledProject;
  final bool showSampleAction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final detail = _DetailPanel(
          hasProject: hasProject,
          showLoadDetail: showLoadDetail,
          onImportProject: onImportProject,
          onOpenProjectFolder: onOpenProjectFolder,
          onOpenWorkbench: onOpenWorkbench,
          onLoadBundledProject: onLoadBundledProject,
          showSampleAction: showSampleAction,
        );
        const hero = _HeroBoard();
        if (constraints.hasBoundedHeight) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 320, child: detail),
              const SizedBox(height: 16),
              const Expanded(child: hero),
            ],
          );
        }
        final detailHeight = constraints.maxWidth >= 1000 ? 285.0 : 320.0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: detailHeight, child: detail),
            const SizedBox(height: 16),
            const SizedBox(height: 230, child: hero),
          ],
        );
      },
    );
  }
}

class _DetailPanel extends StatelessWidget {
  const _DetailPanel({
    required this.hasProject,
    required this.showLoadDetail,
    required this.onImportProject,
    required this.onOpenProjectFolder,
    required this.onOpenWorkbench,
    required this.onLoadBundledProject,
    required this.showSampleAction,
  });

  final bool hasProject;
  final bool showLoadDetail;
  final Future<void> Function(BuildContext context)? onImportProject;
  final Future<void> Function(BuildContext context) onOpenProjectFolder;
  final VoidCallback onOpenWorkbench;
  final Future<void> Function() onLoadBundledProject;
  final bool showSampleAction;

  @override
  Widget build(BuildContext context) {
    final showLoadedProject = hasProject && !showLoadDetail;
    return Container(
      key: const ValueKey('benchbeep_home_detail_panel'),
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._panel,
        border: Border.all(color: BenchBeepHomeScreen._frame),
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
      padding: const EdgeInsets.fromLTRB(30, 28, 30, 24),
      child: showLoadedProject
          ? Column(
              key: const ValueKey('benchbeep_home_loaded_detail'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'AVATUD PROJEKT',
                  style: TextStyle(
                    color: BenchBeepHomeScreen._gold,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Jätka visuaalsel töölaual',
                  style: TextStyle(
                    color: BenchBeepHomeScreen._cream,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pelle PV20 · jätka sealt, kus töö pooleli jäi.',
                  style: TextStyle(
                    color: BenchBeepHomeScreen._muted,
                    fontSize: 14.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton(
                    key: const ValueKey(
                      'benchbeep_home_open_board_canvas_button',
                    ),
                    onPressed: onOpenWorkbench,
                    style: FilledButton.styleFrom(
                      backgroundColor: BenchBeepHomeScreen._goldBright,
                      foregroundColor: const Color(0xFF241C0A),
                      minimumSize: const Size(0, 49),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Text('Ava töölaud'),
                  ),
                ),
                if (showSampleAction) ...[
                  const SizedBox(height: 6),
                  _SampleProjectButton(onPressed: onLoadBundledProject),
                ],
              ],
            )
          : Column(
              key: const ValueKey('benchbeep_home_load_detail'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'ALUSTA',
                  style: TextStyle(
                    color: BenchBeepHomeScreen._gold,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Lae projekt sisse',
                  style: TextStyle(
                    color: BenchBeepHomeScreen._cream,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ava kaasaskantav ZIP-pakk või olemasolev kohalik '
                  'projektikaust.',
                  style: TextStyle(
                    color: BenchBeepHomeScreen._muted,
                    fontSize: 14.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final zip = _ActionButton(
                      key: const ValueKey(
                        'benchbeep_home_import_project_button',
                      ),
                      label: 'Ava ZIP',
                      detail: 'kaasaskantav projektifail',
                      onPressed: onImportProject == null
                          ? null
                          : () => onImportProject!(context),
                    );
                    final folder = _ActionButton(
                      key: const ValueKey(
                        'benchbeep_home_open_folder_button',
                      ),
                      label: 'Ava kaust',
                      detail: 'kirjutatav kohalik kaust',
                      onPressed: () => onOpenProjectFolder(context),
                    );
                    if (constraints.maxWidth < 520) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          zip,
                          const SizedBox(height: 12),
                          folder,
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: zip),
                        const SizedBox(width: 12),
                        Expanded(child: folder),
                      ],
                    );
                  },
                ),
                if (showSampleAction) ...[
                  const SizedBox(height: 6),
                  _SampleProjectButton(onPressed: onLoadBundledProject),
                ],
              ],
            ),
    );
  }
}

class _SampleProjectButton extends StatelessWidget {
  const _SampleProjectButton({required this.onPressed});

  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        key: const ValueKey('benchbeep_home_sample_project_button'),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: BenchBeepHomeScreen._muted,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
          minimumSize: const Size(0, 32),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: const TextStyle(fontSize: 13),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ava näidisprojekt'),
            Text(' tutvumiseks'),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    super.key,
    required this.label,
    required this.detail,
    required this.onPressed,
  });

  final String label;
  final String detail;
  final VoidCallback? onPressed;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final lifted = enabled && (_hovered || _focused);
    return Container(
      decoration: BoxDecoration(
        color: lifted
            ? BenchBeepHomeScreen._hoverFill
            : BenchBeepHomeScreen._inset,
        border: Border.all(
          color: lifted
              ? BenchBeepHomeScreen._goldDim
              : BenchBeepHomeScreen._edgeGold,
          width: lifted ? 1.4 : 1,
        ),
        borderRadius: BorderRadius.circular(13),
        boxShadow: lifted
            ? const [
                BoxShadow(
                  color: BenchBeepHomeScreen._softGlow,
                  blurRadius: 22,
                  spreadRadius: -14,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          onTap: widget.onPressed,
          onHover:
              enabled ? (hovered) => setState(() => _hovered = hovered) : null,
          onFocusChange:
              enabled ? (focused) => setState(() => _focused = focused) : null,
          borderRadius: BorderRadius.circular(13),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    color: enabled
                        ? BenchBeepHomeScreen._cream
                        : BenchBeepHomeScreen._faint,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.detail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: BenchBeepHomeScreen._faint,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroBoard extends StatelessWidget {
  const _HeroBoard();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('benchbeep_home_hero_band'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._inset,
        border: Border.all(color: BenchBeepHomeScreen._edge),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PLAAT JÄÄB KESKSEKS',
                style: TextStyle(
                  color: BenchBeepHomeScreen._gold,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Mõõtmised, markerid ja kinnitused jäävad alati plaadi '
                'visuaalsesse konteksti.',
                style: TextStyle(
                  color: BenchBeepHomeScreen._muted,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          );
          final imageHeight =
              constraints.hasBoundedHeight && constraints.maxHeight < 190
                  ? constraints.maxHeight
                  : 190.0;
          final image = ClipRRect(
            key: const ValueKey('benchbeep_home_hero_image'),
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/brand/pcb_board.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0, 0.2),
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          );
          if (constraints.maxWidth < 760) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                copy,
                const SizedBox(height: 16),
                Expanded(child: image),
              ],
            );
          }
          final imageWidth =
              constraints.maxWidth >= 1000 ? 430.0 : constraints.maxWidth * .4;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: copy),
              const SizedBox(width: 16),
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: image,
              ),
            ],
          );
        },
      ),
    );
  }
}
