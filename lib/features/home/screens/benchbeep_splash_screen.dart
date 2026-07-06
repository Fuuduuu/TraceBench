import 'package:flutter/material.dart';

const String? _kWordmarkFont = null;

class BenchBeepSplashScreen extends StatefulWidget {
  const BenchBeepSplashScreen({
    super.key,
    required this.onComplete,
    this.total = const Duration(milliseconds: 3200),
  });

  final VoidCallback onComplete;
  final Duration total;

  @override
  State<BenchBeepSplashScreen> createState() => _BenchBeepSplashScreenState();

  static const bg = Color(0xFF0C0C0C);
  static const gold = Color(0xFFE7C25A);
  static const goldBright = Color(0xFFF0CF6A);
  static const goldDim = Color(0xFFCDA64C);
  static const cream = Color(0xFFF3ECDC);
  static const faint = Color(0xFF7E776A);
  static const green = Color(0xFF6FCF97);
  static const seg = Color(0xFF241F16);
}

class _BenchBeepSplashScreenState extends State<BenchBeepSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.total)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _completeOnce();
        }
      })
      ..forward();
  }

  @override
  void didUpdateWidget(covariant BenchBeepSplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.total != widget.total && !_done) {
      _controller.duration = widget.total;
    }
  }

  void _completeOnce() {
    if (_done) {
      return;
    }
    _done = true;
    widget.onComplete();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _seg(double start, double end, {Curve curve = Curves.easeOutCubic}) {
    final t = ((_controller.value - start) / (end - start)).clamp(0.0, 1.0);
    return curve.transform(t);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('benchbeep_startup_intro'),
      backgroundColor: BenchBeepSplashScreen.bg,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final markT = _seg(0.15, 0.43);
          final benchT = _seg(0.275, 0.47);
          final beepT = _seg(0.315, 0.51);
          final arcs = [
            _seg(0.09, 0.30, curve: Curves.easeOut),
            _seg(0.13, 0.34, curve: Curves.easeOut),
            _seg(0.17, 0.38, curve: Curves.easeOut),
            _seg(0.21, 0.42, curve: Curves.easeOut),
          ];
          final dotT = _seg(0.09, 0.21, curve: Curves.easeOutBack);
          final subT = _seg(0.39, 0.61);
          final meterInT = _seg(0.46, 0.62);
          final fillT = _seg(0.50, 0.78, curve: Curves.easeInOut);
          final outT = _seg(0.80, 0.99, curve: Curves.easeInOut);

          final leaveOpacity = 1.0 - outT;
          final leaveScale = 1.0 - 0.035 * outT;

          return DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.5, -0.85),
                radius: 1.2,
                colors: [Color(0xFF1C1812), BenchBeepSplashScreen.bg],
                stops: [0.0, 0.64],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Opacity(
                  opacity: leaveOpacity.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: leaveScale,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _Lockup(
                              markT: markT,
                              benchT: benchT,
                              beepT: beepT,
                              arcs: arcs,
                              dotT: dotT,
                              subT: subT,
                            ),
                            const SizedBox(height: 40),
                            Opacity(
                              opacity: meterInT,
                              child: Transform.translate(
                                offset: Offset(0, 10 * (1 - meterInT)),
                                child: _BootMeter(fill: fillT),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Lockup extends StatelessWidget {
  const _Lockup({
    required this.markT,
    required this.benchT,
    required this.beepT,
    required this.arcs,
    required this.dotT,
    required this.subT,
  });

  final double markT;
  final double benchT;
  final double beepT;
  final double dotT;
  final double subT;
  final List<double> arcs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: markT,
          child: ClipRect(
            clipper: _WipeClipper(markT),
            child: Image(
              key: const ValueKey('benchbeep_startup_mark'),
              image: const ExactAssetImage('assets/brand/benchbeep_mark.png'),
              height: 92,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) => const SizedBox(height: 92),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _word('bench', BenchBeepSplashScreen.gold, benchT),
            _word('beep', BenchBeepSplashScreen.cream, beepT),
            const SizedBox(width: 16),
            SizedBox(
              width: 44,
              height: 66,
              child: CustomPaint(
                key: const ValueKey('benchbeep_startup_beep_arcs'),
                painter: _BeepArcsPainter(progress: arcs, dot: dotT),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Opacity(
          opacity: subT,
          child: Text(
            'MEASUREMENT DATA VISUALIZATION',
            key: const ValueKey('benchbeep_startup_subtitle'),
            style: TextStyle(
              color: BenchBeepSplashScreen.goldDim,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 3.0 + 6.0 * (1 - subT),
            ),
          ),
        ),
      ],
    );
  }

  Widget _word(String value, Color color, double progress) {
    return Opacity(
      opacity: progress,
      child: Transform.translate(
        offset: Offset(0, 28 * (1 - progress)),
        child: RichText(
          text: TextSpan(
            text: value,
            style: TextStyle(
              fontFamily: _kWordmarkFont,
              color: color,
              fontSize: 82,
              height: 0.9,
              fontWeight: FontWeight.w700,
              letterSpacing: -2.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _WipeClipper extends CustomClipper<Rect> {
  const _WipeClipper(this.progress);

  final double progress;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * progress, size.height);
  }

  @override
  bool shouldReclip(covariant _WipeClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}

class _BeepArcsPainter extends CustomPainter {
  const _BeepArcsPainter({required this.progress, required this.dot});

  final List<double> progress;
  final double dot;

  @override
  void paint(Canvas canvas, Size size) {
    final unit = size.height / 42.0;
    final cx = size.width * 0.16;
    final cy = size.height * 0.5;

    final stroke = Paint()
      ..color = BenchBeepSplashScreen.goldBright
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const arcs = [
      (radius: 7.0, stroke: 3.0),
      (radius: 13.0, stroke: 3.4),
      (radius: 19.0, stroke: 3.8),
      (radius: 25.0, stroke: 4.2),
    ];

    for (var i = 0; i < arcs.length; i += 1) {
      final arcProgress = progress[i];
      if (arcProgress <= 0) {
        continue;
      }
      stroke.strokeWidth = arcs[i].stroke * unit;
      final rect = Rect.fromCircle(
        center: Offset(cx, cy),
        radius: arcs[i].radius * unit,
      );
      canvas.drawArc(rect, -1.05, 2.10 * arcProgress, false, stroke);
    }

    if (dot > 0) {
      final dotPaint = Paint()..color = BenchBeepSplashScreen.goldBright;
      canvas.drawCircle(Offset(cx, cy), 2.6 * unit * dot, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BeepArcsPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.dot != dot;
  }
}

class _BootMeter extends StatelessWidget {
  const _BootMeter({required this.fill});

  final double fill;

  static const _segmentCount = 28;

  @override
  Widget build(BuildContext context) {
    final lit = (fill * _segmentCount).round().clamp(0, _segmentCount);
    return SizedBox(
      key: const ValueKey('benchbeep_startup_meter'),
      width: 340,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'INITIALISING TRACEBENCH PLATFORM',
                  key: ValueKey('benchbeep_startup_platform_label'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: BenchBeepSplashScreen.goldDim,
                    fontSize: 11.5,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(fill * 100).round()}%',
                style: const TextStyle(
                  color: BenchBeepSplashScreen.faint,
                  fontSize: 11.5,
                  letterSpacing: 1.0,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 12,
            child: Row(
              children: List.generate(_segmentCount, (index) {
                Color color = BenchBeepSplashScreen.seg;
                if (index < lit) {
                  color = index == _segmentCount - 1
                      ? BenchBeepSplashScreen.gold
                      : BenchBeepSplashScreen.green;
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: index < lit
                            ? [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.5),
                                  blurRadius: 7,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
