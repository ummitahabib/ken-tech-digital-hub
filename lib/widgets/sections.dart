// ─── sections.dart — complete, conflict-free ─────────────────────────────────
import 'dart:math' as math;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';
import '../models/app_data.dart';
import 'common_widgets.dart';

// ─── URL helper ───────────────────────────────────────────────────────────────

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch $url');
  }
}

// ─── Shared data class ────────────────────────────────────────────────────────

class _S {
  final FaIconData icon;
  final String label, url;
  const _S(this.icon, this.label, this.url);
}

// ═══════════════════════════════════════════════════════════════════════════════
// PARTNERS STRIP
// ═══════════════════════════════════════════════════════════════════════════════

class PartnersStrip extends StatelessWidget {
  const PartnersStrip({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 700;
    return Container(
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(horizontal: wide ? 80 : 24, vertical: 22),
      child: Column(
        children: [
          Text(
            'TOOLS & PLATFORMS WE USE',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppTheme.textLight,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: AppData.partners
                .map(
                  (p) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Text(
                      p['name']!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SERVICES SECTION
// ═══════════════════════════════════════════════════════════════════════════════

class _StaggeredEntrance extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration baseDelay;
  const _StaggeredEntrance({
    required this.child,
    required this.index,
    this.baseDelay = const Duration(milliseconds: 120),
  });
  @override
  State<_StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<_StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(widget.baseDelay * widget.index, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}

class _AnimatedSectionHeader extends StatefulWidget {
  final String eyebrow, title, subtitle;
  const _AnimatedSectionHeader({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });
  @override
  State<_AnimatedSectionHeader> createState() => _AnimatedSectionHeaderState();
}

class _AnimatedSectionHeaderState extends State<_AnimatedSectionHeader>
    with TickerProviderStateMixin {
  late final AnimationController _eyebrowCtrl,
      _titleCtrl,
      _subtitleCtrl,
      _underlineCtrl;

  @override
  void initState() {
    super.initState();
    _eyebrowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _titleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _subtitleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _underlineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _eyebrowCtrl.forward();
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) _titleCtrl.forward();
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        _subtitleCtrl.forward();
        _underlineCtrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _eyebrowCtrl.dispose();
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    _underlineCtrl.dispose();
    super.dispose();
  }

  Widget _fadeSlide(
    AnimationController ctrl,
    Widget child, {
    Offset from = const Offset(0, 0.3),
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: ctrl, curve: Curves.easeOut),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: from,
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeOutCubic)),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fadeSlide(
          _eyebrowCtrl,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
            ),
            child: Text(
              widget.eyebrow,
              style: TextStyle(
                color: AppTheme.accent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _fadeSlide(
          _titleCtrl,
          Column(
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _underlineCtrl,
                builder: (_, __) {
                  final v = CurvedAnimation(
                    parent: _underlineCtrl,
                    curve: Curves.easeOutExpo,
                  ).value;
                  return Align(
                    child: Container(
                      height: 3,
                      width: 60 * v,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.accent,
                            AppTheme.accent.withOpacity(0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _fadeSlide(
          _subtitleCtrl,
          Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          from: const Offset(0, 0.2),
        ),
      ],
    );
  }
}

class _NeumorphicServiceCard extends StatefulWidget {
  final dynamic service;
  const _NeumorphicServiceCard({required this.service});
  @override
  State<_NeumorphicServiceCard> createState() => _NeumorphicServiceCardState();
}

class _NeumorphicServiceCardState extends State<_NeumorphicServiceCard>
    with TickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _glowCtrl, _iconFloatCtrl, _textRevealCtrl;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _iconFloatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _textRevealCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _iconFloatCtrl.dispose();
    _textRevealCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme.background.computeLuminance() < 0.5;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _hovered ? -6.0 : 0.0),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.55)
                        : Colors.grey.withOpacity(0.35),
                    offset: const Offset(8, 8),
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    color: isDark
                        ? Colors.white.withOpacity(0.04)
                        : Colors.white.withOpacity(0.9),
                    offset: const Offset(-6, -6),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.18),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.grey.withOpacity(0.25),
                    offset: const Offset(6, 6),
                    blurRadius: 14,
                  ),
                  BoxShadow(
                    color: isDark
                        ? Colors.white.withOpacity(0.03)
                        : Colors.white.withOpacity(0.85),
                    offset: const Offset(-5, -5),
                    blurRadius: 12,
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _glowCtrl,
                builder: (_, __) => Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.accent.withOpacity(
                            0.04 + 0.04 * _glowCtrl.value,
                          ),
                          Colors.transparent,
                          AppTheme.accent.withOpacity(
                            0.02 + 0.02 * (1 - _glowCtrl.value),
                          ),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _iconFloatCtrl,
                      builder: (_, child) => Transform.translate(
                        offset: Offset(
                          0,
                          -3 * math.sin(_iconFloatCtrl.value * math.pi),
                        ),
                        child: child,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 280),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _hovered
                              ? AppTheme.accent.withOpacity(0.18)
                              : AppTheme.accent.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: _hovered
                              ? [
                                  BoxShadow(
                                    color: AppTheme.accent.withOpacity(0.3),
                                    blurRadius: 16,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          widget.service.icon as IconData,
                          color: AppTheme.accent,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _textRevealCtrl,
                        curve: Curves.easeOut,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0, 0.25),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _textRevealCtrl,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                        child: Text(
                          widget.service.title as String,
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _textRevealCtrl,
                        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                      ),
                      child: Text(
                        widget.service.description as String,
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const Spacer(),
                    FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _textRevealCtrl,
                        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Learn more',
                            style: TextStyle(
                              color: AppTheme.accent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 280),
                            transform: Matrix4.identity()
                              ..translate(_hovered ? 4.0 : 0.0, 0.0),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: AppTheme.accent,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.background,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          _AnimatedSectionHeader(
            eyebrow: 'What We Do',
            title: 'Services that drive\nreal business results',
            subtitle:
                'From social media to paid ads — everything your business needs to dominate online.',
          ),
          const SizedBox(height: 52),
          LayoutBuilder(
            builder: (_, c) {
              int cols = c.maxWidth > 1000 ? 3 : (c.maxWidth > 640 ? 2 : 1);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  childAspectRatio: cols == 1 ? 1.5 : (cols == 2 ? 0.9 : 0.95),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: AppData.services.length,
                itemBuilder: (_, i) => _StaggeredEntrance(
                  index: i,
                  child: _NeumorphicServiceCard(service: AppData.services[i]),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          _StaggeredEntrance(
            index: AppData.services.length + 1,
            child: PrimaryButton(
              text: 'View All Services',
              icon: Icons.arrow_forward_rounded,
              isOutlined: true,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// WORK / PORTFOLIO
// ═══════════════════════════════════════════════════════════════════════════════

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'Our Work',
            title: 'Campaigns that\ndelivered results',
            subtitle: 'Real projects, real clients, real outcomes.',
          ),
          const SizedBox(height: 52),
          LayoutBuilder(
            builder: (_, c) {
              int cols = c.maxWidth > 900 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  childAspectRatio: 1.45,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: AppData.projects.length,
                itemBuilder: (_, i) =>
                    ProjectCard(project: AppData.projects[i]),
              );
            },
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'See All Case Studies',
            icon: Icons.arrow_forward_rounded,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ABOUT SECTION
// ═══════════════════════════════════════════════════════════════════════════════

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.background,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _AboutImg()),
                const SizedBox(width: 72),
                const Expanded(flex: 5, child: _AboutCopy()),
              ],
            )
          : const Column(
              children: [_AboutCopy(), SizedBox(height: 48), _AboutImgSm()],
            ),
    );
  }
}

class _AboutImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 460,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.12),
                blurRadius: 40,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            'https://images.unsplash.com/photo-1552664730-d307ca884978?w=700',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: AppTheme.surface),
          ),
        ),
        Positioned(
          bottom: -16,
          right: -12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.divider),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppTheme.tagCyan,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: AppTheme.accent,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Based in Abuja, Nigeria',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      'Serving clients nationwide',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AboutImgSm extends StatelessWidget {
  const _AboutImgSm();
  @override
  Widget build(BuildContext context) => _AboutImg();
}

class _AboutCopy extends StatelessWidget {
  const _AboutCopy();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          eyebrow: 'About Us',
          title: '8+ years growing\nNigerian brands',
          centered: false,
        ),
        const SizedBox(height: 20),
        Text(
          'Ken Digital Tech Hub is a full-service digital marketing agency headquartered in Abuja, Nigeria. We combine strategy, creativity, and data to deliver outstanding results for businesses across the country.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppTheme.textSecondary,
            height: 1.75,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'From growing social media followings to running high-converting ad campaigns, we help Nigerian businesses thrive in the digital age — building lasting digital presences, not just one-off campaigns.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppTheme.textSecondary,
            height: 1.75,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            _Pt(icon: Icons.ads_click_rounded, text: 'Strategy-first'),
            _Pt(icon: Icons.bar_chart_rounded, text: 'Data-driven'),
            _Pt(icon: Icons.support_agent_rounded, text: 'Dedicated managers'),
            _Pt(icon: Icons.assessment_rounded, text: 'Monthly reports'),
            _Pt(icon: Icons.public_rounded, text: 'Nigerian market experts'),
            _Pt(icon: Icons.bolt_rounded, text: 'Agile execution'),
          ],
        ),
        const SizedBox(height: 34),
        Row(
          children: [
            PrimaryButton(
              text: 'Meet the Team',
              icon: Icons.people_alt_rounded,
            ),
            const SizedBox(width: 12),
            PrimaryButton(text: 'Our Story', isOutlined: true),
          ],
        ),
      ],
    );
  }
}

class _Pt extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Pt({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppTheme.tagCyan,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: AppTheme.tagCyanText),
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TESTIMONIALS
// ═══════════════════════════════════════════════════════════════════════════════

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.background,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'Client Stories',
            title: 'What our clients\nsay about us',
          ),
          const SizedBox(height: 52),
          LayoutBuilder(
            builder: (_, c) {
              int cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 580 ? 2 : 1);
              if (cols == 1) {
                return SizedBox(
                  height: 320,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.testimonials.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (_, i) => SizedBox(
                      width: 300,
                      child: TestimonialCard(
                        testimonial: AppData.testimonials[i],
                      ),
                    ),
                  ),
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AppData.testimonials
                    .map(
                      (t) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: TestimonialCard(testimonial: t),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// FAQ
// ═══════════════════════════════════════════════════════════════════════════════

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'FAQ',
            title: 'Questions & answers',
            subtitle: 'Everything you need to know before partnering with us.',
          ),
          const SizedBox(height: 44),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              children: AppData.faqs.map((f) => FaqTile(item: f)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// BLOG
// ═══════════════════════════════════════════════════════════════════════════════

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.background,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: SectionHeader(
                  eyebrow: 'Insights',
                  title: 'Tips & insights',
                  centered: false,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: AppTheme.accent,
                ),
                label: Text(
                  'All Articles',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (_, c) {
              int cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 580 ? 2 : 1);
              if (cols == 1) {
                return SizedBox(
                  height: 380,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.blogPosts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (_, i) => SizedBox(
                      width: 270,
                      child: BlogCard(post: AppData.blogPosts[i]),
                    ),
                  ),
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AppData.blogPosts
                    .map(
                      (p) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: BlogCard(post: p),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CTA BANNER  — _SocIcon lives here ONLY, no duplicate anywhere
// ═══════════════════════════════════════════════════════════════════════════════

class CtaBanner extends StatelessWidget {
  const CtaBanner({super.key});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 960;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.darkBg,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 5, child: _CtaLeft()),
                const SizedBox(width: 56),
                Expanded(flex: 4, child: _CtaForm()),
              ],
            )
          : Column(
              children: [
                const _CtaLeft(),
                const SizedBox(height: 40),
                _CtaForm(),
              ],
            ),
    );
  }
}

// ── Social icon for CTA / dark background ────────────────────────────────────

class _SocIcon extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final String url;

  const _SocIcon({required this.icon, required this.label, required this.url});

  @override
  State<_SocIcon> createState() => _SocIconState();
}

class _SocIconState extends State<_SocIcon> {
  bool _isHovered = false;

  void _setHovered(bool value) {
    if (_isHovered == value) return;
    setState(() => _isHovered = value);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isHovered ? AppTheme.accent : AppTheme.darkCard;
    final borderColor = _isHovered ? AppTheme.accent : AppTheme.darkCardBorder;
    final iconColor = Colors.white.withValues(alpha: _isHovered ? 1.0 : 0.5);

    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => _setHovered(true),
        onExit: (_) => _setHovered(false),
        child: GestureDetector(
          onTap: () => _openUrl(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: borderColor),
            ),
            child: Center(
              child: FaIcon(widget.icon, size: 15, color: iconColor),
            ),
          ),
        ),
      ),
    );
  }
}
// ── Info row — plain ─────────────────────────────────────────────────────────

class _IR extends StatelessWidget {
  final FaIconData icon;
  final String text;
  const _IR(this.icon, this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 13, color: AppTheme.accent),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white.withOpacity(0.55),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Info row — tappable ──────────────────────────────────────────────────────

class _IRLink extends StatefulWidget {
  final FaIconData icon;
  final String text, url;
  const _IRLink(this.icon, this.text, this.url);
  @override
  State<_IRLink> createState() => _IRLinkState();
}

class _IRLinkState extends State<_IRLink> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: () => _openUrl(widget.url),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaIcon(widget.icon, size: 13, color: AppTheme.accent),
            const SizedBox(width: 8),
            Flexible(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: _hov
                      ? AppTheme.accent
                      : Colors.white.withOpacity(0.55),
                ),
                child: Text(widget.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CtaLeft extends StatelessWidget {
  const _CtaLeft();

  static const List<String> _benefits = [
    'Free consultation',
    'No lock-in contracts',
    '48h response',
    'Nigeria-based team',
  ];

  @override
  Widget build(BuildContext context) {
    final mutedText = Colors.white.withValues(alpha: 0.6);
    final softText = Colors.white.withValues(alpha: 0.8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ready to grow\nyour business online?',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.12,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Book a free strategy call. No commitments — just a real conversation about how we can help your business win online.',
          style: GoogleFonts.inter(fontSize: 15, color: mutedText, height: 1.7),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: _benefits
              .map((text) => _BenefitItem(text: text, textColor: softText))
              .toList(),
        ),
        const SizedBox(height: 36),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.darkCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.darkCardBorder),
          ),
          child: const Column(
            children: [
              _IR(
                FontAwesomeIcons.locationDot,
                'Wuse Zone 5, Sky Memorial Complex, FCT Abuja',
              ),
              SizedBox(height: 8),
              _IR(
                FontAwesomeIcons.locationDot,
                'Wuse Zone 2, Asamankese St, Block 29 Suite 3, Abuja',
              ),
              SizedBox(height: 8),
              _IRLink(
                FontAwesomeIcons.envelope,
                'kendigitaltechhub@gmail.com',
                'mailto:kendigitaltechhub@gmail.com',
              ),
              SizedBox(height: 8),
              _IRLink(
                FontAwesomeIcons.phone,
                '08035014022   ·   08113500601',
                'tel:+2348035014022',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _SocIcon(
              icon: FontAwesomeIcons.facebookF,
              label: 'Facebook',
              url: 'https://www.facebook.com/KDTH4',
            ),
            _SocIcon(
              icon: FontAwesomeIcons.instagram,
              label: 'Instagram',
              url: 'https://www.instagram.com/kendigital4009/',
            ),
            _SocIcon(
              icon: FontAwesomeIcons.youtube,
              label: 'YouTube',
              url: 'https://www.youtube.com/@KENDIGITALTECHHUB',
            ),
            _SocIcon(
              icon: FontAwesomeIcons.xTwitter,
              label: 'Twitter/X',
              url: 'https://x.com/hub_ken82312',
            ),
            _SocIcon(
              icon: FontAwesomeIcons.linkedinIn,
              label: 'LinkedIn',
              url: 'https://www.linkedin.com/company/94802182/',
            ),
          ],
        ),
      ],
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;
  final Color textColor;

  const _BenefitItem({required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FaIcon(
          FontAwesomeIcons.circleCheck,
          size: 14,
          color: AppTheme.accent,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
// ── CTA Form ─────────────────────────────────────────────────────────────────

class _CtaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.4),
            blurRadius: 48,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get a Free Consultation',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "No commitment. We'll respond within 48 hours.",
            style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLight),
          ),
          const SizedBox(height: 22),
          _F(hint: 'Your full name', icon: Icons.person_outline_rounded),
          const SizedBox(height: 10),
          _F(hint: 'Email address', icon: Icons.email_outlined),
          const SizedBox(height: 10),
          _F(hint: 'WhatsApp number', icon: Icons.phone_outlined),
          const SizedBox(height: 10),
          _F(
            hint: 'Tell us about your business',
            icon: Icons.business_outlined,
            lines: 3,
          ),
          const SizedBox(height: 20),
          _SubmitBtn(),
        ],
      ),
    );
  }
}

class _F extends StatelessWidget {
  final String hint;
  final IconData icon;
  final int lines;
  const _F({required this.hint, required this.icon, this.lines = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.divider),
      ),
      child: TextField(
        maxLines: lines,
        style: GoogleFonts.inter(fontSize: 13, color: AppTheme.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(fontSize: 13, color: AppTheme.textLight),
          prefixIcon: Icon(icon, size: 17, color: AppTheme.textLight),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: lines > 1 ? 14 : 12,
            horizontal: lines > 1 ? 14 : 0,
          ),
        ),
      ),
    );
  }
}

class _SubmitBtn extends StatefulWidget {
  @override
  State<_SubmitBtn> createState() => _SubmitBtnState();
}

class _SubmitBtnState extends State<_SubmitBtn> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _hov ? AppTheme.accent.withOpacity(0.88) : AppTheme.accent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hov
                ? [
                    BoxShadow(
                      color: AppTheme.accent.withOpacity(0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              'Book Free Call',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER  — _FotIcon lives here ONLY, no duplicate anywhere
// ═══════════════════════════════════════════════════════════════════════════════

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  static const List<_S> _socials = [
    _S(
      FontAwesomeIcons.facebookF,
      'Facebook',
      'https://www.facebook.com/KDTH4',
    ),
    _S(
      FontAwesomeIcons.instagram,
      'Instagram',
      'https://www.instagram.com/kendigital4009/',
    ),
    _S(
      FontAwesomeIcons.youtube,
      'YouTube',
      'https://www.youtube.com/@KENDIGITALTECHHUB',
    ),
    _S(FontAwesomeIcons.xTwitter, 'Twitter/X', 'https://x.com/hub_ken82312'),
    _S(
      FontAwesomeIcons.linkedinIn,
      'LinkedIn',
      'https://www.linkedin.com/company/94802182/',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;
    return Container(
      color: AppTheme.darkBg,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        children: [
          const SizedBox(height: 56),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
            decoration: BoxDecoration(
              color: AppTheme.darkCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.darkCardBorder),
            ),
            child: wide
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weekly marketing insights',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Join 1,000+ Nigerian business owners. No spam, ever.',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(child: _NewsletterRow()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly marketing insights',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _NewsletterRow(),
                    ],
                  ),
          ),
          const SizedBox(height: 52),
          Divider(color: Colors.white.withOpacity(0.06), height: 1),
          const SizedBox(height: 44),
          wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Expanded(flex: 3, child: _Brand(socials: _socials)),
                    const Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _SocIcon(
                          icon: FontAwesomeIcons.facebookF,
                          label: 'Facebook',
                          url: 'https://www.facebook.com/KDTH4',
                        ),
                        _SocIcon(
                          icon: FontAwesomeIcons.instagram,
                          label: 'Instagram',
                          url: 'https://www.instagram.com/kendigital4009/',
                        ),
                        _SocIcon(
                          icon: FontAwesomeIcons.youtube,
                          label: 'YouTube',
                          url: 'https://www.youtube.com/@KENDIGITALTECHHUB',
                        ),
                        _SocIcon(
                          icon: FontAwesomeIcons.xTwitter,
                          label: 'Twitter/X',
                          url: 'https://x.com/hub_ken82312',
                        ),
                        _SocIcon(
                          icon: FontAwesomeIcons.linkedinIn,
                          label: 'LinkedIn',
                          url: 'https://www.linkedin.com/company/94802182/',
                        ),
                      ],
                    ),

                    const SizedBox(width: 28),
                    Expanded(
                      child: _Col('Services', [
                        'Social Media',
                        'Paid Ads',
                        'Content Creation',
                        'SEO',
                        'Training',
                      ]),
                    ),
                    Expanded(
                      child: _Col('Company', [
                        'About Us',
                        'Our Team',
                        'Portfolio',
                        'Blog',
                        'Careers',
                      ]),
                    ),
                    Expanded(
                      child: _Col('Contact', [
                        'WhatsApp Us',
                        'Email Us',
                        'Abuja Office',
                        'LinkedIn',
                        'Free Call',
                      ]),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Brand(socials: _socials),
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _Col('Services', [
                            'Social Media',
                            'Paid Ads',
                            'Content',
                            'SEO',
                          ]),
                        ),
                        Expanded(
                          child: _Col('Company', [
                            'About',
                            'Team',
                            'Portfolio',
                            'Blog',
                          ]),
                        ),
                        Expanded(
                          child: _Col('Contact', [
                            'WhatsApp',
                            'Email',
                            'LinkedIn',
                            'Instagram',
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
          const SizedBox(height: 40),
          Divider(color: Colors.white.withOpacity(0.06), height: 1),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 16,
            runSpacing: 6,
            children: [
              Text(
                '© 2025 Ken Digital Tech Hub. All rights reserved.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              Text(
                'Abuja, Nigeria · kendigitaltechhub@gmail.com',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _NewsletterRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: AppTheme.darkCardBorder),
            ),
            child: TextField(
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'your@email.com',
                hintStyle: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.28),
                  fontSize: 13,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _SubBtn(),
      ],
    );
  }
}

class _SubBtn extends StatefulWidget {
  @override
  State<_SubBtn> createState() => _SubBtnState();
}

class _SubBtnState extends State<_SubBtn> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _hov ? AppTheme.accent.withOpacity(0.88) : AppTheme.accent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              'Subscribe',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Footer social icon ───────────────────────────────────────────────────────

class _FotIcon extends StatefulWidget {
  final FaIconData icon;
  final String tooltip, url;
  const _FotIcon({
    required this.icon,
    required this.tooltip,
    required this.url,
  });
  @override
  State<_FotIcon> createState() => _FotIconState();
}

class _FotIconState extends State<_FotIcon> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hov = true),
        onExit: (_) => setState(() => _hov = false),
        child: GestureDetector(
          onTap: () => _openUrl(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _hov ? AppTheme.accent : Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _hov ? AppTheme.accent : Colors.white.withOpacity(0.1),
              ),
            ),
            child: FaIcon(
              widget.icon,
              size: 14,
              color: Colors.white.withOpacity(_hov ? 1.0 : 0.45),
            ),
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  final List<_S> socials;
  const _Brand({required this.socials});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logo.jpg',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: AppTheme.brandGradient,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'KD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'KenDigital TechHub',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Helping Nigerian businesses\nsucceed in the digital landscape.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.white.withOpacity(0.38),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _openUrl('mailto:kendigitaltechhub@gmail.com'),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              'kendigitaltechhub@gmail.com',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppTheme.accent,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.accent,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        GestureDetector(
          onTap: () => _openUrl('tel:+2348035014022'),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              '08035014022 · 08113500601',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white.withOpacity(0.32),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: socials
              .map((s) => _FotIcon(icon: s.icon, tooltip: s.label, url: s.url))
              .toList(),
        ),
      ],
    );
  }
}

class _Col extends StatelessWidget {
  final String title;
  final List<String> items;
  const _Col(this.title, this.items);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 14),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                item,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.38),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
