import 'package:flutter/material.dart';

import '../../../shared/theme/app_theme.dart';

class BenchBeepHomeScreen extends StatelessWidget {
  const BenchBeepHomeScreen({
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onImportProject,
    required this.onOpenProject,
    required this.onOpenWorkbench,
    super.key,
  });

  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context)? onImportProject;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;

  static const _paper = Color(0xFFFFFFFF);
  static const _background = Color(0xFFEAEFF3);
  static const _backgroundLift = Color(0xFFF5F8FA);
  static const _navy = Color(0xFF173A5E);
  static const _ink = Color(0xFF15293B);
  static const _inkMuted = Color(0xFF65788A);
  static const _rule = Color(0xFFD7E1EA);
  static const _ruleStrong = Color(0xFFC4D0DC);
  static const _signal = Color(0xFFE8742B);
  static const _signalDark = Color(0xFFC85F1C);
  static const _signalTint = Color(0xFFFCEEE1);
  static const _ready = Color(0xFF2F8F6B);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens =
        theme.extension<BenchBeepVisualTokens>() ??
        BenchBeepVisualTokens.darkInstrument;

    return Scaffold(
      key: const ValueKey('benchbeep_home_launcher'),
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 720;
            final horizontalPadding = isNarrow ? 18.0 : 30.0;
            final verticalPadding = isNarrow ? 18.0 : 24.0;
            final availableHeight = constraints.maxHeight - (verticalPadding * 2);
            final content = isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _LauncherRail(
                        tokens: tokens,
                        hasProject: hasProject,
                        onLoadBundledProject: onLoadBundledProject,
                        onImportProject: onImportProject,
                        onOpenProject: onOpenProject,
                        onOpenWorkbench: onOpenWorkbench,
                      ),
                      const SizedBox(height: 18),
                      _DetailPanel(
                        tokens: tokens,
                        hasProject: hasProject,
                        onLoadBundledProject: onLoadBundledProject,
                        onImportProject: onImportProject,
                        onOpenProject: onOpenProject,
                        onOpenWorkbench: onOpenWorkbench,
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: 356,
                        child: _LauncherRail(
                          tokens: tokens,
                          hasProject: hasProject,
                          onLoadBundledProject: onLoadBundledProject,
                          onImportProject: onImportProject,
                          onOpenProject: onOpenProject,
                          onOpenWorkbench: onOpenWorkbench,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _DetailPanel(
                          tokens: tokens,
                          hasProject: hasProject,
                          onLoadBundledProject: onLoadBundledProject,
                          onImportProject: onImportProject,
                          onOpenProject: onOpenProject,
                          onOpenWorkbench: onOpenWorkbench,
                        ),
                      ),
                    ],
                  );

            return DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_backgroundLift, _background],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1240,
                      minHeight: availableHeight > 0 ? availableHeight : 0,
                    ),
                    child: isNarrow ? content : IntrinsicHeight(child: content),
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

class _LauncherRail extends StatelessWidget {
  const _LauncherRail({
    required this.tokens,
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onImportProject,
    required this.onOpenProject,
    required this.onOpenWorkbench,
  });

  final BenchBeepVisualTokens tokens;
  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context)? onImportProject;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('benchbeep_home_board_card'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _BrandPlate(),
        const SizedBox(height: 14),
        const _ModeButton(
          label: 'Start new',
          detail: 'deferred',
          index: '01',
          enabled: false,
          active: false,
          onPressed: null,
        ),
        const SizedBox(height: 10),
        _ModeButton(
          key: const ValueKey('benchbeep_home_open_workbench_button'),
          label: hasProject ? 'Ava projekt' : 'Open existing',
          detail: 'workbench context',
          index: '02',
          enabled: true,
          active: true,
          onPressed: hasProject ? onOpenProject : onOpenWorkbench,
        ),
        const SizedBox(height: 10),
        _ModeButton(
          key: const ValueKey('benchbeep_home_import_project_button'),
          label: 'Import project',
          detail: 'existing ZIP flow',
          index: '03',
          enabled: onImportProject != null,
          active: false,
          onPressed: onImportProject == null
              ? null
              : () => onImportProject!(context),
        ),
        const SizedBox(height: 10),
        _ModeButton(
          label: 'Ava näidisprojekt',
          detail: 'read-only baseline',
          index: '04',
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._paper,
        border: Border.all(color: BenchBeepHomeScreen._rule),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F0F2A45),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: _BenchBeepMark(size: 58)),
            const SizedBox(height: 10),
            Text(
              'BenchBeep',
              key: const ValueKey('benchbeep_home_title'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: BenchBeepHomeScreen._navy,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Bench instrument launcher',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: BenchBeepHomeScreen._signalDark,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Measurement Data Visualization',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: BenchBeepHomeScreen._inkMuted,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'TraceBench Viewer',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: BenchBeepHomeScreen._inkMuted,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    super.key,
    required this.label,
    required this.detail,
    required this.index,
    required this.enabled,
    required this.active,
    required this.onPressed,
  });

  final String label;
  final String detail;
  final String index;
  final bool enabled;
  final bool active;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        active ? BenchBeepHomeScreen._signal : BenchBeepHomeScreen._rule;
    final foreground =
        enabled ? BenchBeepHomeScreen._ink : BenchBeepHomeScreen._inkMuted;
    return Material(
      color: BenchBeepHomeScreen._paper,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: active ? 1.4 : 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Text(
                  index,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: active
                        ? BenchBeepHomeScreen._signalDark
                        : BenchBeepHomeScreen._inkMuted,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.titleSmall
                            ?.copyWith(
                              color: foreground,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        detail,
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(
                              color: BenchBeepHomeScreen._inkMuted,
                              letterSpacing: 0.5,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: active
                      ? BenchBeepHomeScreen._signal
                      : BenchBeepHomeScreen._ruleStrong,
                  size: 18,
                ),
              ],
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
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: hasProject
                ? BenchBeepHomeScreen._ready
                : BenchBeepHomeScreen._signal,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            hasProject ? 'Sample loaded' : 'Ready',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: BenchBeepHomeScreen._inkMuted,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.9,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'TraceBench platform',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: BenchBeepHomeScreen._inkMuted,
            letterSpacing: 0.7,
          ),
        ),
      ],
    );
  }
}

class _DetailPanel extends StatelessWidget {
  const _DetailPanel({
    required this.tokens,
    required this.hasProject,
    required this.onLoadBundledProject,
    required this.onImportProject,
    required this.onOpenProject,
    required this.onOpenWorkbench,
  });

  final BenchBeepVisualTokens tokens;
  final bool hasProject;
  final Future<void> Function() onLoadBundledProject;
  final Future<void> Function(BuildContext context)? onImportProject;
  final VoidCallback onOpenProject;
  final VoidCallback onOpenWorkbench;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BenchBeepHomeScreen._paper,
        border: Border.all(color: BenchBeepHomeScreen._rule),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x190F2A45),
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DetailHeader(hasProject: hasProject),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProjectRow(
                  label: 'Pelle PV20',
                  type: 'burner_controller',
                  meta: hasProject ? 'loaded now' : 'bundled sample',
                  readings: '14 reads',
                  active: hasProject,
                  onLoadBundledProject: onLoadBundledProject,
                  onOpenProject: onOpenProject,
                ),
                const SizedBox(height: 10),
                _ProjectRow(
                  label: 'Open Workbench',
                  type: 'current board canvas context',
                  meta: 'existing route',
                  readings: 'read-only',
                  active: false,
                  onLoadBundledProject: null,
                  onOpenProject: onOpenWorkbench,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.hasProject});

  final bool hasProject;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: BenchBeepHomeScreen._rule),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OPEN EXISTING',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: BenchBeepHomeScreen._signalDark,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Board workbench',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: BenchBeepHomeScreen._ink,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pick up the board exactly where the diagnostic context lives.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: BenchBeepHomeScreen._inkMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hasProject ? '01' : '00',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: BenchBeepHomeScreen._navy,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  hasProject ? 'loaded' : 'loaded',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: BenchBeepHomeScreen._inkMuted,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  const _ProjectRow({
    required this.label,
    required this.type,
    required this.meta,
    required this.readings,
    required this.active,
    required this.onLoadBundledProject,
    required this.onOpenProject,
  });

  final String label;
  final String type;
  final String meta;
  final String readings;
  final bool active;
  final Future<void> Function()? onLoadBundledProject;
  final VoidCallback onOpenProject;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: active ? BenchBeepHomeScreen._signalTint : Colors.white,
        border: Border.all(
          color:
              active ? BenchBeepHomeScreen._signal : BenchBeepHomeScreen._rule,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Row(
          children: [
            const _MiniBoardGlyph(),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: BenchBeepHomeScreen._ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    type,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: BenchBeepHomeScreen._inkMuted,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 104,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  meta,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: BenchBeepHomeScreen._inkMuted,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  readings,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: BenchBeepHomeScreen._navy,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              tooltip: active ? 'Ava projekt' : 'Open Workbench',
              onPressed: onOpenProject,
              icon: const Icon(Icons.chevron_right),
              color: BenchBeepHomeScreen._signal,
            ),
          ],
        ),
      ),
    );
  }
}

class _BenchBeepMark extends StatelessWidget {
  const _BenchBeepMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 1.5, size),
      painter: _BenchBeepMarkPainter(),
    );
  }
}

class _BenchBeepMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final navyPaint = Paint()
      ..color = BenchBeepHomeScreen._navy
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.045
      ..strokeCap = StrokeCap.round;
    final fineNavyPaint = Paint()
      ..color = BenchBeepHomeScreen._navy
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.026
      ..strokeCap = StrokeCap.round;
    final orangeStroke = Paint()
      ..color = BenchBeepHomeScreen._signal
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.055
      ..strokeCap = StrokeCap.round;
    final penPaint = Paint()
      ..color = BenchBeepHomeScreen._signal
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.13
      ..strokeCap = StrokeCap.round;
    final nodePaint = Paint()
      ..color = BenchBeepHomeScreen._navy
      ..style = PaintingStyle.fill;
    final signalNodePaint = Paint()
      ..color = BenchBeepHomeScreen._signal
      ..style = PaintingStyle.fill;
    final paperPaint = Paint()
      ..color = BenchBeepHomeScreen._paper
      ..style = PaintingStyle.fill;

    final cable = Path()
      ..moveTo(w * 0.03, h * 0.84)
      ..cubicTo(w * 0.24, h * 0.84, w * 0.47, h * 0.86, w * 0.58, h * 0.64)
      ..cubicTo(w * 0.64, h * 0.52, w * 0.68, h * 0.42, w * 0.75, h * 0.24);
    canvas.drawPath(cable, orangeStroke);

    final handTrace = Path()
      ..moveTo(w * 0.07, h * 0.54)
      ..cubicTo(w * 0.17, h * 0.32, w * 0.32, h * 0.48, w * 0.44, h * 0.37)
      ..cubicTo(w * 0.52, h * 0.30, w * 0.55, h * 0.55, w * 0.64, h * 0.49);
    canvas.drawPath(handTrace, navyPaint);

    final lead = Path()
      ..moveTo(w * 0.32, h * 0.18)
      ..cubicTo(w * 0.43, h * 0.02, w * 0.48, h * 0.34, w * 0.62, h * 0.39)
      ..cubicTo(w * 0.68, h * 0.41, w * 0.70, h * 0.27, w * 0.75, h * 0.24);
    canvas.drawPath(lead, fineNavyPaint);

    canvas.drawLine(Offset(w * 0.17, h * 0.72), Offset(w * 0.32, h * 0.18), penPaint);
    canvas.drawLine(
      Offset(w * 0.12, h * 0.78),
      Offset(w * 0.19, h * 0.66),
      orangeStroke,
    );
    canvas.drawCircle(Offset(w * 0.14, h * 0.73), h * 0.075, signalNodePaint);
    canvas.drawCircle(Offset(w * 0.17, h * 0.72), h * 0.035, paperPaint);

    final graphNodes = [
      Offset(w * 0.74, h * 0.23),
      Offset(w * 0.91, h * 0.27),
      Offset(w * 0.83, h * 0.48),
      Offset(w * 0.96, h * 0.60),
      Offset(w * 0.78, h * 0.75),
      Offset(w * 0.66, h * 0.58),
    ];
    final edges = [
      [0, 1],
      [0, 2],
      [0, 5],
      [1, 2],
      [1, 3],
      [2, 3],
      [2, 4],
      [2, 5],
      [3, 4],
      [4, 5],
    ];
    for (final edge in edges) {
      canvas.drawLine(graphNodes[edge[0]], graphNodes[edge[1]], fineNavyPaint);
    }
    canvas.drawLine(graphNodes[0], graphNodes[1], orangeStroke);
    canvas.drawLine(graphNodes[0], graphNodes[5], orangeStroke);
    canvas.drawLine(graphNodes[5], Offset(w * 0.58, h * 0.64), orangeStroke);

    for (var index = 0; index < graphNodes.length; index += 1) {
      final isSignal = index == 0 || index == 1 || index == 5;
      canvas.drawCircle(
        graphNodes[index],
        h * (isSignal ? 0.08 : 0.07),
        isSignal ? signalNodePaint : nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniBoardGlyph extends StatelessWidget {
  const _MiniBoardGlyph();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 34,
      child: CustomPaint(painter: _MiniBoardGlyphPainter()),
    );
  }
}

class _MiniBoardGlyphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boardPaint = Paint()..color = const Color(0xFFEEF3F8);
    final borderPaint = Paint()
      ..color = BenchBeepHomeScreen._ruleStrong
      ..style = PaintingStyle.stroke;
    final tracePaint = Paint()
      ..color = BenchBeepHomeScreen._ruleStrong
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final signalPaint = Paint()..color = BenchBeepHomeScreen._signal;
    final navyPaint = Paint()..color = BenchBeepHomeScreen._navy;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, 5, size.width - 4, size.height - 10),
      const Radius.circular(4),
    );
    canvas.drawRRect(rect, boardPaint);
    canvas.drawRRect(rect, borderPaint);

    final leftTop = Offset(size.width * 0.24, size.height * 0.35);
    final rightTop = Offset(size.width * 0.76, size.height * 0.35);
    final leftBottom = Offset(size.width * 0.24, size.height * 0.65);
    final rightBottom = Offset(size.width * 0.76, size.height * 0.65);
    final center = Offset(size.width * 0.50, size.height * 0.50);
    canvas.drawLine(leftTop, center, tracePaint);
    canvas.drawLine(center, rightBottom, tracePaint);
    canvas.drawLine(rightTop, center, tracePaint);
    canvas.drawLine(center, leftBottom, tracePaint);
    canvas.drawCircle(leftTop, 2.4, navyPaint);
    canvas.drawCircle(rightBottom, 2.4, navyPaint);
    canvas.drawCircle(rightTop, 2.4, signalPaint);
    canvas.drawCircle(leftBottom, 2.4, signalPaint);
    canvas.drawCircle(center, 2.6, navyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
