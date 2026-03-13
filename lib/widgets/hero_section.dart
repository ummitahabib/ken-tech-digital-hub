import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HeroSection
// ═══════════════════════════════════════════════════════════════════════════════
class HeroSection extends StatelessWidget {
  final VoidCallback? onCtaPressed;
  const HeroSection({super.key, this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final wide = w > 960;
    final hPad = wide ? 80.0 : 24.0;

    return Container(
      color: AppTheme.background,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, wide ? 120 : 96, hPad, 72),
          child: wide
              ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(flex: 55, child: _HeroLeft(onCtaPressed: onCtaPressed)),
                  const SizedBox(width: 60),
                  const Expanded(flex: 45, child: _LiveFeed()),
                ])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _HeroLeft(onCtaPressed: onCtaPressed),
                  const SizedBox(height: 48),
                  const _LiveFeed(),
                ]),
        ),
        const _ServiceTicker(),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Left column
// ═══════════════════════════════════════════════════════════════════════════════
class _HeroLeft extends StatefulWidget {
  final VoidCallback? onCtaPressed;
  const _HeroLeft({this.onCtaPressed});
  @override State<_HeroLeft> createState() => _HeroLeftState();
}

class _HeroLeftState extends State<_HeroLeft> with TickerProviderStateMixin {
  // ── Entrance: 3 headline lines + 4 support elements ─────────────────────
  // Headline: i=0,1,2  |  Support: i=3(eyebrow), 4(sub), 5(body), 6(cta)
  static const int _n = 7;
  late AnimationController _entrance;
  late List<Animation<double>>  _fades;
  late List<Animation<Offset>>  _slides;

  // ── Idle float: very slow, almost imperceptible vertical drift ───────────
  late AnimationController _idleFloat;
  late List<Animation<double>> _lineFloat; // each headline line floats at slightly different phase

  @override
  void initState() {
    super.initState();

    // Entrance controller — 1600ms total, elements staggered every ~120ms
    // Safe intervals: start = i*0.08, end = start+0.42 → max = 6*0.08+0.42 = 0.90 ✓
    _entrance = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));

    _fades  = List.generate(_n, (i) {
      final s = (i * 0.08).clamp(0.0, 0.58);
      final e = (s + 0.42).clamp(0.0, 1.0);
      return CurvedAnimation(parent: _entrance,
          curve: Interval(s, e, curve: Curves.easeOut));
    });

    _slides = List.generate(_n, (i) {
      final s = (i * 0.08).clamp(0.0, 0.58);
      final e = (s + 0.42).clamp(0.0, 1.0);
      // Headline lines (0-2): taller travel distance for cinematic reveal
      // Support elements (3-6): shorter, quicker
      final dy = i < 3 ? 0.38 : 0.22;
      return Tween<Offset>(begin: Offset(0, dy), end: Offset.zero)
          .animate(CurvedAnimation(parent: _entrance,
              curve: Interval(s, e, curve: Curves.easeOutCubic)));
    });

    _entrance.forward();

    // Idle float — 6s period, repeat reverse, very subtle
    _idleFloat = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 6000))..repeat(reverse: true);

    // Each headline line has a different phase offset (0, 0.33, 0.66)
    // so they drift independently — feels organic, not mechanical
    _lineFloat = List.generate(3, (i) {
      final phaseShift = i * (math.pi * 2 / 3);
      // We drive this via AnimatedBuilder + sin(), not Tween — smoother phase control
      // But to stay Tween-based, we stagger with slightly different durations
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _idleFloat, curve: Curves.easeInOutSine));
    });
  }

  @override
  void dispose() { _entrance.dispose(); _idleFloat.dispose(); super.dispose(); }

  Widget _entranceWrap(int i, Widget child) => FadeTransition(
    opacity: _fades[i],
    child: SlideTransition(position: _slides[i], child: child),
  );

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Eyebrow
      _entranceWrap(3, const _EyebrowPill()),
      const SizedBox(height: 24),

      // Headline — each line: entrance slide + continuous idle float
      _AnimatedHeadlineLine(
        text: 'We grow',
        screenW: w,
        fadeAnim: _fades[0],
        slideAnim: _slides[0],
        idleCtrl: _idleFloat,
        idlePhase: 0.0,
      ),
      _AnimatedHeadlineLine(
        text: 'your brand',
        screenW: w,
        fadeAnim: _fades[1],
        slideAnim: _slides[1],
        idleCtrl: _idleFloat,
        idlePhase: math.pi * 2 / 3,
      ),
      _AnimatedHeadlineLine(
        text: 'online.',
        screenW: w,
        fadeAnim: _fades[2],
        slideAnim: _slides[2],
        idleCtrl: _idleFloat,
        idlePhase: math.pi * 4 / 3,
      ),
      const SizedBox(height: 14),

      // Accent subline
      _entranceWrap(4, Text(
        'Digital · Strategic · Results',
        style: GoogleFonts.spaceGrotesk(
          fontSize: w > 640 ? 20 : 15,
          fontWeight: FontWeight.w600,
          color: AppTheme.accent,
          letterSpacing: -0.2,
        ),
      )),
      const SizedBox(height: 22),

      // Body copy
      _entranceWrap(5, ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Text(
          'Ken Digital Tech Hub helps businesses across Nigeria succeed online — '
          'through expert social media management, paid advertising, content creation, '
          'and data-driven marketing strategy.',
          style: GoogleFonts.inter(fontSize: 16, color: AppTheme.textSecondary, height: 1.72),
        ),
      )),
      const SizedBox(height: 36),

      // CTAs + social proof
      _entranceWrap(6, Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(spacing: 12, runSpacing: 12, children: [
          _HeroBtn(label: 'Get a Free Strategy Call', primary: true, onTap: widget.onCtaPressed),
          const _HeroBtn(label: 'See Our Work', primary: false),
        ]),
        const SizedBox(height: 42),
        const _SocialProof(),
      ])),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Animated headline line — entrance slide/fade + idle float with phase offset
// Subtle text shadow for depth without changing colors
// ═══════════════════════════════════════════════════════════════════════════════
class _AnimatedHeadlineLine extends StatelessWidget {
  final String text;
  final double screenW;
  final Animation<double> fadeAnim;
  final Animation<Offset> slideAnim;
  final AnimationController idleCtrl;
  final double idlePhase; // radians — creates organic phase drift between lines

  const _AnimatedHeadlineLine({
    required this.text,
    required this.screenW,
    required this.fadeAnim,
    required this.slideAnim,
    required this.idleCtrl,
    required this.idlePhase,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = screenW > 1100 ? 68.0 : (screenW > 640 ? 54.0 : 40.0);

    return FadeTransition(
      opacity: fadeAnim,
      child: SlideTransition(
        position: slideAnim,
        // Idle float — drives vertical translate via sin wave with phase offset
        child: AnimatedBuilder(
          animation: idleCtrl,
          builder: (_, child) {
            // sin() with phase offset → each line drifts independently
            // amplitude: 2.5px — premium, barely perceptible
            final t = idleCtrl.value * math.pi * 2 + idlePhase;
            final dy = math.sin(t) * 2.5;

            // Also slightly modulate opacity: 1.0 → 0.92 in phase
            // creates a breathing feel, not opacity flutter
            final opacityMod = 0.92 + math.sin(t * 0.5) * 0.08;

            return Transform.translate(
              offset: Offset(0, dy),
              child: Opacity(opacity: opacityMod.clamp(0.0, 1.0), child: child),
            );
          },
          child: Text(
            text,
            style: GoogleFonts.spaceGrotesk(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              height: 1.04,
              letterSpacing: -2,
              shadows: [
                // Subtle editorial depth shadow — very soft, uses near-black at low opacity
                Shadow(
                  color: AppTheme.ink.withOpacity(0.06),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
                Shadow(
                  color: AppTheme.ink.withOpacity(0.03),
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Eyebrow pill with pulsing accent dot ─────────────────────────────────────
class _EyebrowPill extends StatefulWidget {
  const _EyebrowPill();
  @override _EyebrowPillState createState() => _EyebrowPillState();
}

class _EyebrowPillState extends State<_EyebrowPill> with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _ringScale;
  late Animation<double> _ringOpacity;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 2400))..repeat();
    _ringScale = Tween<double>(begin: 1.0, end: 2.2).animate(
        CurvedAnimation(parent: _pulse,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
    _ringOpacity = Tween<double>(begin: 0.8, end: 0.0).animate(
        CurvedAnimation(parent: _pulse,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
  }

  @override
  void dispose() { _pulse.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.tagCyan,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.accent.withOpacity(0.25)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(width: 14, height: 14,
          child: Stack(alignment: Alignment.center, children: [
            AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) => Transform.scale(
                scale: _ringScale.value,
                child: Opacity(
                  opacity: _ringOpacity.value,
                  child: Container(width: 8, height: 8,
                    decoration: BoxDecoration(
                        color: AppTheme.accent.withOpacity(0.4),
                        shape: BoxShape.circle)),
                ),
              ),
            ),
            Container(width: 6, height: 6,
                decoration: const BoxDecoration(
                    color: AppTheme.accent, shape: BoxShape.circle)),
          ]),
        ),
        const SizedBox(width: 7),
        Text("Nigeria's #1 Digital Marketing Agency",
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
              color: AppTheme.tagCyanText, letterSpacing: 0.2)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Hero CTA buttons — neumorphic + scale tap + soft hover glow
// ═══════════════════════════════════════════════════════════════════════════════
class _HeroBtn extends StatefulWidget {
  final String label;
  final bool primary;
  final VoidCallback? onTap;
  const _HeroBtn({required this.label, required this.primary, this.onTap});
  @override State<_HeroBtn> createState() => _HeroBtnState();
}

class _HeroBtnState extends State<_HeroBtn> with SingleTickerProviderStateMixin {
  bool _hov = false;

  late AnimationController _tap;
  late Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();
    _tap = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 200));
    _tapScale = Tween<double>(begin: 1.0, end: 0.95)
        .animate(CurvedAnimation(parent: _tap, curve: Curves.easeOut));
  }

  @override
  void dispose() { _tap.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTapDown: (_) => _tap.forward(),
        onTapUp:   (_) { _tap.reverse(); widget.onTap?.call(); },
        onTapCancel: () => _tap.reverse(),
        child: AnimatedBuilder(
          animation: _tapScale,
          builder: (_, child) => Transform.scale(
            scale: _hov && widget.primary ? 1.04 : _tapScale.value,
            child: child,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: widget.primary
                ? BoxDecoration(
                    color: _hov ? AppTheme.greenDark : AppTheme.green,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: _hov
                        ? [
                            BoxShadow(color: AppTheme.green.withOpacity(0.40),
                                blurRadius: 22, offset: const Offset(0, 8)),
                            BoxShadow(color: AppTheme.green.withOpacity(0.20),
                                blurRadius: 6, offset: const Offset(0, 2)),
                          ]
                        : [
                            // Neumorphic resting state
                            const BoxShadow(color: Color(0x99FFFFFF),
                                offset: Offset(-3, -3), blurRadius: 7),
                            const BoxShadow(color: Color(0x18000000),
                                offset: Offset(3, 3), blurRadius: 7),
                          ],
                  )
                : BoxDecoration(
                    color: _hov ? AppTheme.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: _hov ? AppTheme.accent.withOpacity(0.35) : AppTheme.divider),
                    boxShadow: _hov
                        ? [BoxShadow(color: Colors.black.withOpacity(0.06),
                              blurRadius: 14, offset: const Offset(0, 5))]
                        : [],
                  ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(widget.label,
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                    color: widget.primary ? Colors.white : AppTheme.textPrimary)),
              if (widget.primary) ...[
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_rounded, size: 15, color: Colors.white),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Live Feed
// ═══════════════════════════════════════════════════════════════════════════════
class _LiveFeed extends StatefulWidget {
  const _LiveFeed();
  @override State<_LiveFeed> createState() => _LiveFeedState();
}

class _LiveFeedState extends State<_LiveFeed> with TickerProviderStateMixin {
  static const _results = [
    _R('Lagos Fashion House',   'Social Media',  '340% follower growth in 90 days',    false),
    _R('Abuja Real Estate Co.', 'Paid Ads',      '₦12M in qualified leads generated',   true),
    _R('Naija Beauty Brand',    'SEO + Content', '3× online sales in 6 months',         false),
    _R('FCT EdTech Startup',    'Google Ads',    '60% lower cost-per-lead',             true),
    _R('Abuja Hospitality Co.', 'Social Media',  '50K followers in 4 months',           false),
    _R('Niger Delta Oil Firm',  'Strategy',      '4× website traffic growth',            true),
  ];

  int _idx = 0;

  // Card swap
  late AnimationController _swap;
  late Animation<Offset> _slideIn;
  late Animation<double>  _fadeIn;
  late Animation<double>  _scaleIn;

  // Panel floating oscillation
  late AnimationController _float;
  late Animation<double>   _floatY;

  // Panel entrance
  late AnimationController _enter;
  late Animation<double>   _enterFade;
  late Animation<Offset>   _enterSlide;

  // Stats stagger — 4 items: [0,0.4],[0.2,0.6],[0.4,0.8],[0.6,1.0] ✓
  late AnimationController _stats;
  late List<Animation<double>> _statFades;

  @override
  void initState() {
    super.initState();

    _swap = AnimationController(vsync: this, duration: const Duration(milliseconds: 460));
    _slideIn = Tween<Offset>(begin: const Offset(0, 0.14), end: Offset.zero)
        .animate(CurvedAnimation(parent: _swap, curve: Curves.easeOutCubic));
    _fadeIn  = CurvedAnimation(parent: _swap, curve: Curves.easeOut);
    _scaleIn = Tween<double>(begin: 0.96, end: 1.0)
        .animate(CurvedAnimation(parent: _swap, curve: Curves.easeOutCubic));
    _swap.forward();

    _float = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 4000))..repeat(reverse: true);
    _floatY = Tween<double>(begin: 0, end: -6)
        .animate(CurvedAnimation(parent: _float, curve: Curves.easeInOutSine));

    _enter = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _enterFade  = CurvedAnimation(parent: _enter,
        curve: const Interval(0.1, 1.0, curve: Curves.easeOut));
    _enterSlide = Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _enter,
            curve: const Interval(0.0, 0.9, curve: Curves.easeOutCubic)));
    _enter.forward();

    _stats = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 1000));
    _statFades = List.generate(4, (i) {
      final s = i * 0.20;
      final e = (s + 0.40).clamp(0.0, 1.0);
      return CurvedAnimation(parent: _stats,
          curve: Interval(s, e, curve: Curves.easeOut));
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _stats.forward();
    });

    _schedule();
  }

  void _schedule() => Future.delayed(const Duration(milliseconds: 2800), _next);

  void _next() {
    if (!mounted) return;
    _swap.reverse().then((_) {
      if (!mounted) return;
      setState(() => _idx = (_idx + 1) % _results.length);
      _swap.forward();
      _schedule();
    });
  }

  @override
  void dispose() {
    _swap.dispose(); _float.dispose(); _enter.dispose(); _stats.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const statItems = [
      ('200+', 'Clients'), ('₦50M+', 'Ad Spend'),
      ('8+ yrs', 'Experience'), ('98%', 'Retention'),
    ];

    return FadeTransition(
      opacity: _enterFade,
      child: SlideTransition(
        position: _enterSlide,
        child: AnimatedBuilder(
          animation: _floatY,
          builder: (_, child) => Transform.translate(
              offset: Offset(0, _floatY.value), child: child),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              _PulsingDot(),
              const SizedBox(width: 7),
              Text('Live client results',
                style: GoogleFonts.inter(fontSize: 12,
                    fontWeight: FontWeight.w500, color: AppTheme.textLight)),
              const Spacer(),
              Text('Updated weekly',
                style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLight)),
            ]),
            const SizedBox(height: 12),

            SlideTransition(
              position: _slideIn,
              child: FadeTransition(
                opacity: _fadeIn,
                child: ScaleTransition(
                  scale: _scaleIn,
                  child: _ResultCard(r: _results[_idx], featured: true),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _ResultCard(r: _results[(_idx + 1) % _results.length], featured: false),
            const SizedBox(height: 8),
            _ResultCard(r: _results[(_idx + 2) % _results.length], featured: false),
            const SizedBox(height: 20),

            Row(children: List.generate(4, (i) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < 3 ? 10.0 : 0),
                child: FadeTransition(
                  opacity: _statFades[i],
                  child: _StatBox(statItems[i].$1, statItems[i].$2),
                ),
              ),
            ))),
          ]),
        ),
      ),
    );
  }
}

// ── Pulsing dot ───────────────────────────────────────────────────────────────
class _PulsingDot extends StatefulWidget {
  @override State<_PulsingDot> createState() => _PulsingDotState();
}
class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _s, _o;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 1900))..repeat();
    _s = Tween<double>(begin: 1.0, end: 2.4).animate(
        CurvedAnimation(parent: _c,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
    _o = Tween<double>(begin: 0.75, end: 0.0).animate(
        CurvedAnimation(parent: _c,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
  }
  @override void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => SizedBox(width: 12, height: 12,
    child: Stack(alignment: Alignment.center, children: [
      AnimatedBuilder(
        animation: _c,
        builder: (_, __) => Transform.scale(scale: _s.value,
          child: Opacity(opacity: _o.value,
            child: Container(width: 8, height: 8,
              decoration: BoxDecoration(
                  color: AppTheme.accent.withOpacity(0.45),
                  shape: BoxShape.circle)))),
      ),
      Container(width: 7, height: 7,
          decoration: const BoxDecoration(
              color: AppTheme.accent, shape: BoxShape.circle)),
    ]),
  );
}

// ── Result card — neumorphic featured + hover lift ────────────────────────────
class _ResultCard extends StatefulWidget {
  final _R r;
  final bool featured;
  const _ResultCard({required this.r, required this.featured});
  @override State<_ResultCard> createState() => _ResultCardState();
}
class _ResultCardState extends State<_ResultCard> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedOpacity(
        opacity: widget.featured ? 1.0 : (_hov ? 0.78 : 0.52),
        duration: const Duration(milliseconds: 280),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transform: Matrix4.translationValues(0, _hov ? -4 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: AppTheme.surfaceCard,
            border: Border.all(
              color: widget.featured
                  ? AppTheme.accent.withOpacity(0.38)
                  : AppTheme.divider,
              width: widget.featured ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: widget.featured
                ? [
                    BoxShadow(color: AppTheme.accent.withOpacity(0.10),
                        blurRadius: 22, offset: const Offset(0, 6)),
                    const BoxShadow(color: Color(0xAAFFFFFF),
                        offset: Offset(-2, -2), blurRadius: 5),
                    const BoxShadow(color: Color(0x10000000),
                        offset: Offset(2, 2), blurRadius: 5),
                  ]
                : _hov
                    ? [BoxShadow(color: Colors.black.withOpacity(0.07),
                          blurRadius: 12, offset: const Offset(0, 4))]
                    : [],
          ),
          child: Row(children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: widget.r.isBlue ? AppTheme.tagPurple : AppTheme.tagCyan,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.trending_up_rounded, size: 17,
                  color: widget.r.isBlue ? AppTheme.accentAlt : AppTheme.accent),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.r.client,
                style: GoogleFonts.spaceGrotesk(fontSize: 13,
                    fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
              const SizedBox(height: 2),
              Text(widget.r.result,
                style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textSecondary)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: widget.r.isBlue ? AppTheme.tagPurple : AppTheme.tagCyan,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(widget.r.tag,
                style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600,
                    color: widget.r.isBlue
                        ? AppTheme.tagPurpleText
                        : AppTheme.tagCyanText)),
            ),
          ]),
        ),
      ),
    );
  }
}

class _R {
  final String client, tag, result;
  final bool isBlue;
  const _R(this.client, this.tag, this.result, this.isBlue);
}

// ── Neumorphic stat box ───────────────────────────────────────────────────────
class _StatBox extends StatelessWidget {
  final String value, label;
  const _StatBox(this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.divider),
        boxShadow: const [
          BoxShadow(color: Color(0xBBFFFFFF), offset: Offset(-2, -2), blurRadius: 5),
          BoxShadow(color: Color(0x12000000), offset: Offset(2, 2),  blurRadius: 5),
        ],
      ),
      child: Column(children: [
        Text(value,
          style: GoogleFonts.spaceGrotesk(fontSize: 17,
              fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
        const SizedBox(height: 2),
        Text(label,
          style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLight)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Service Ticker — smooth infinite scroll + gradient edge fades + glowing dots
// ═══════════════════════════════════════════════════════════════════════════════
class _ServiceTicker extends StatefulWidget {
  const _ServiceTicker();
  @override State<_ServiceTicker> createState() => _ServiceTickerState();
}
class _ServiceTickerState extends State<_ServiceTicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  static const _tags = [
    'Social Media Management', 'Paid Advertising', 'Content Creation',
    'SEO & Web Visibility', 'Google Ads', 'Facebook & Instagram Ads',
    'Digital Strategy', 'Brand Growth', 'Lead Generation',
    'Community Management', 'Video Content', 'Digital Skills Training',
  ];

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this,
        duration: const Duration(seconds: 28))..repeat();
  }
  @override void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    const itemW = 200.0;
    final total = _tags.length * itemW;

    return Container(
      height: 40,
      color: AppTheme.primary,
      child: Stack(children: [
        AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            final offset = -(_c.value * total) % total;
            return ClipRect(
              child: Stack(
                children: List.generate(_tags.length * 3, (i) {
                  final idx = i % _tags.length;
                  final x   = offset + i * itemW;
                  return Positioned(
                    left: x, top: 0, bottom: 0,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(_tags[idx],
                          style: GoogleFonts.inter(fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.6))),
                      ),
                      Container(
                        width: 4, height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.accent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: AppTheme.accent.withOpacity(0.65),
                                blurRadius: 6, spreadRadius: 1),
                          ],
                        ),
                      ),
                    ]),
                  );
                }),
              ),
            );
          },
        ),
        Positioned(top: 0, bottom: 0, left: 0, width: 52,
          child: IgnorePointer(child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(
              colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.0)],
            )),
          )),
        ),
        Positioned(top: 0, bottom: 0, right: 0, width: 52,
          child: IgnorePointer(child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(
              colors: [AppTheme.primary.withOpacity(0.0), AppTheme.primary],
            )),
          )),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Social proof — staggered avatar entrance + shimmer stars
// ═══════════════════════════════════════════════════════════════════════════════
class _SocialProof extends StatefulWidget {
  const _SocialProof();
  @override State<_SocialProof> createState() => _SocialProofState();
}
class _SocialProofState extends State<_SocialProof> with TickerProviderStateMixin {
  late AnimationController _avCtrl;
  late List<Animation<double>> _avScales;

  late AnimationController _shimCtrl;
  late Animation<double>   _shimmer;

  // Avatar stagger: starts 0.0,0.15,0.30,0.45 — ends 0.55,0.70,0.85,1.00 ✓
  @override
  void initState() {
    super.initState();

    _avCtrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 700));
    _avScales = List.generate(4, (i) {
      final s = i * 0.15;
      final e = (s + 0.55).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: _avCtrl,
            curve: Interval(s, e, curve: Curves.easeOutBack)));
    });

    _shimCtrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 1300));
    _shimmer  = CurvedAnimation(parent: _shimCtrl, curve: Curves.easeInOut);

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) { _avCtrl.forward(); _shimCtrl.forward(); }
    });
  }

  @override
  void dispose() { _avCtrl.dispose(); _shimCtrl.dispose(); super.dispose(); }

  static const _avatarUrls = [
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=60',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=60',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=60',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=60',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 84, height: 32,
        child: Stack(
          children: List.generate(4, (i) => Positioned(
            left: i * 18.0,
            child: ScaleTransition(
              scale: _avScales[i],
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.background, width: 2),
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppTheme.surface,
                  backgroundImage: NetworkImage(_avatarUrls[i]),
                  onBackgroundImageError: (_, __) {},
                ),
              ),
            ),
          )),
        ),
      ),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AnimatedBuilder(
          animation: _shimmer,
          builder: (_, __) => Row(children: [
            ...List.generate(5, (i) {
              final t    = _shimmer.value;
              final peak = i / 4.0;
              final glow = (1.0 - (t - peak).abs() * 5.0).clamp(0.0, 1.0);
              return Icon(Icons.star_rounded, size: 12,
                color: Color.lerp(AppTheme.starColor, Colors.white, glow * 0.5)!);
            }),
            const SizedBox(width: 5),
            Text('5.0',
              style: GoogleFonts.spaceGrotesk(fontSize: 12,
                  fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
          ]),
        ),
        Text('Trusted by 200+ Nigerian businesses',
          style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLight)),
      ]),
    ]);
  }
}