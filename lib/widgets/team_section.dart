// ─── Team Section (Animated + Expandable Overlay) ────────────────────────────
// Uses TeamMember model throughout. Hover/tap → hero-style full-screen expand.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ken_tech_digital_hub/models/app_data.dart';
import 'package:ken_tech_digital_hub/theme/app_theme.dart';

// ─── Expanded Overlay ─────────────────────────────────────────────────────────

class _TeamOverlay extends StatefulWidget {
  final TeamMember member;
  final VoidCallback onClose;

  const _TeamOverlay({required this.member, required this.onClose});

  @override
  State<_TeamOverlay> createState() => _TeamOverlayState();
}

class _TeamOverlayState extends State<_TeamOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _blur;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
    _blur = Tween<double>(begin: 0, end: 18).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _ctrl.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final screenW = MediaQuery.of(context).size.width;
    final isWide = screenW > 700;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Stack(
        children: [
          // Blurred backdrop
          Positioned.fill(
            child: GestureDetector(
              onTap: _dismiss,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: _blur.value,
                  sigmaY: _blur.value,
                ),
                child: FadeTransition(
                  opacity: _fade,
                  child: Container(
                    color: Colors.black.withOpacity(0.65 * _fade.value),
                  ),
                ),
              ),
            ),
          ),

          // Expanded card
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Container(
                  width: isWide ? 560 : screenW * 0.92,
                  margin: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 60,
                        spreadRadius: 4,
                        offset: const Offset(0, 20),
                      ),
                      BoxShadow(
                        color: AppTheme.accent.withOpacity(0.10),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Accent top bar
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              AppTheme.accent,
                              AppTheme.accent.withOpacity(0.3),
                            ]),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 28, 32, 36),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Close button
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: _dismiss,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppTheme.background.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 18,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Avatar — use network image if available, else initials
                              _Avatar(
                                name: m.name,
                                imageUrl: m.imageUrl,
                                size: 96,
                                fontSize: 32,
                                glowRadius: 24,
                              ),

                              const SizedBox(height: 20),

                              // Name
                              Text(
                                m.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textPrimary,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // Role chip
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppTheme.accent.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppTheme.accent.withOpacity(0.25),
                                  ),
                                ),
                                child: Text(
                                  m.role,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.accent,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              Container(
                                height: 1,
                                color: AppTheme.textSecondary.withOpacity(0.10),
                              ),

                              const SizedBox(height: 20),

                              // Bio
                              if (m.bio != null && m.bio!.isNotEmpty)
                                Text(
                                  m.bio!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: AppTheme.textSecondary,
                                    height: 1.7,
                                  ),
                                ),

                              if (m.bio != null && m.bio!.isNotEmpty)
                                const SizedBox(height: 24),

                              // LinkedIn link (if present)
                              if (m.linkedin != null && m.linkedin!.isNotEmpty)
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.accent.withOpacity(0.10),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppTheme.accent.withOpacity(0.2)),
                                  ),
                                  child: Icon(Icons.work_rounded,
                                      size: 18, color: AppTheme.accent),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Avatar Widget (network image with initials fallback) ─────────────────────

class _Avatar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double size;
  final double fontSize;
  final double glowRadius;
  final bool showRing;

  const _Avatar({
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.fontSize,
    required this.glowRadius,
    this.showRing = false,
  });

  String get _initials => name
      .split(' ')
      .where((e) => e.isNotEmpty)
      .map((e) => e[0])
      .take(2)
      .join();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: imageUrl == null || imageUrl!.isEmpty
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.accent.withOpacity(0.7),
                  AppTheme.accent,
                ],
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppTheme.accent.withOpacity(0.35),
            blurRadius: glowRadius,
            spreadRadius: 2,
          ),
        ],
        border: showRing
            ? Border.all(color: AppTheme.accent.withOpacity(0.5), width: 2)
            : null,
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _initialsWidget(),
              )
            : _initialsWidget(),
      ),
    );
  }

  Widget _initialsWidget() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.accent.withOpacity(0.7), AppTheme.accent],
          ),
        ),
        child: Center(
          child: Text(
            _initials,
            style: GoogleFonts.spaceGrotesk(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
}

// ─── Team Card ────────────────────────────────────────────────────────────────

class _TeamCard extends StatefulWidget {
  final TeamMember member;
  final int index;
  final VoidCallback onTap;

  const _TeamCard({
    required this.member,
    required this.index,
    required this.onTap,
  });

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> with TickerProviderStateMixin {
  late final AnimationController _entranceCtrl;
  late final AnimationController _hoverCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _shimmerCtrl;

  late final Animation<double> _entranceFade;
  late final Animation<Offset> _entranceSlide;
  late final Animation<double> _hoverProgress;
  late final Animation<double> _hoverScale;
  late final Animation<double> _float;
  late final Animation<double> _shimmer;

  bool _hovered = false;

  @override
  void initState() {
    super.initState();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _hoverCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _entranceFade =
        CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _entranceSlide = Tween<Offset>(
      begin: const Offset(0, 0.22),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _entranceCtrl, curve: Curves.easeOutCubic));

    _hoverProgress = CurvedAnimation(
        parent: _hoverCtrl, curve: Curves.easeOut);
    _hoverScale = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _hoverCtrl, curve: Curves.easeOutCubic),
    );
    _float = Tween<double>(begin: -3, end: 3).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _shimmer = Tween<double>(begin: 0.03, end: 0.09).animate(_shimmerCtrl);

    Future.delayed(Duration(milliseconds: 120 * widget.index), () {
      if (mounted) _entranceCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _hoverCtrl.dispose();
    _floatCtrl.dispose();
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final isDark = AppTheme.surface.computeLuminance() < 0.5;

    return FadeTransition(
      opacity: _entranceFade,
      child: SlideTransition(
        position: _entranceSlide,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() => _hovered = true);
            _hoverCtrl.forward();
          },
          onExit: (_) {
            setState(() => _hovered = false);
            _hoverCtrl.reverse();
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedBuilder(
              animation:
                  Listenable.merge([_hoverCtrl, _floatCtrl, _shimmerCtrl]),
              builder: (_, __) => Transform.translate(
                offset: Offset(
                    0, _float.value * _hoverProgress.value),
                child: ScaleTransition(
                  scale: _hoverScale,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _hovered
                            ? AppTheme.accent.withOpacity(0.35)
                            : AppTheme.textSecondary.withOpacity(0.08),
                        width: _hovered ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(
                                  0.3 + 0.2 * _hoverProgress.value)
                              : Colors.grey.withOpacity(
                                  0.18 + 0.15 * _hoverProgress.value),
                          offset: Offset(
                              6 + 4 * _hoverProgress.value,
                              8 + 6 * _hoverProgress.value),
                          blurRadius: 16 + 12 * _hoverProgress.value,
                        ),
                        BoxShadow(
                          color: isDark
                              ? Colors.white.withOpacity(0.03)
                              : Colors.white.withOpacity(0.85),
                          offset: const Offset(-4, -4),
                          blurRadius: 10,
                        ),
                        if (_hovered)
                          BoxShadow(
                            color: AppTheme.accent.withOpacity(0.15),
                            blurRadius: 28,
                            spreadRadius: 1,
                          ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // Shimmer overlay
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppTheme.accent
                                        .withOpacity(_shimmer.value),
                                    Colors.transparent,
                                    AppTheme.accent.withOpacity(
                                        _shimmer.value * 0.5),
                                  ],
                                  stops: const [0.0, 0.55, 1.0],
                                ),
                              ),
                            ),
                          ),

                          // Content
                          Padding(
                            padding: const EdgeInsets.all(28),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Avatar with animated ring
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(
                                          milliseconds: 300),
                                      width: _hovered ? 80 : 72,
                                      height: _hovered ? 80 : 72,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _hovered
                                              ? AppTheme.accent
                                                  .withOpacity(0.5)
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    _Avatar(
                                      name: m.name,
                                      imageUrl: m.imageUrl,
                                      size: 64,
                                      fontSize: 20,
                                      glowRadius: _hovered ? 20 : 0,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Name
                                Text(
                                  m.name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                // Role
                                Text(
                                  m.role,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.accent,
                                    letterSpacing: 0.4,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Animated expanding divider
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 1,
                                  width: _hovered ? 60 : 32,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      AppTheme.accent.withOpacity(0.6),
                                      AppTheme.accent.withOpacity(0.1),
                                    ]),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),

                                const SizedBox(height: 14),

                                // Expand hint (appears on hover)
                                AnimatedOpacity(
                                  opacity: _hovered ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 200),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.open_in_full_rounded,
                                        size: 12,
                                        color:
                                            AppTheme.accent.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'View profile',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: AppTheme.accent
                                              .withOpacity(0.7),
                                          fontWeight: FontWeight.w500,
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Animated Section Header ──────────────────────────────────────────────────

class _AnimatedHeader extends StatefulWidget {
  const _AnimatedHeader();

  @override
  State<_AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<_AnimatedHeader>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final AnimationController _lineCtrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _lineCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _lineCtrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _lineCtrl.dispose();
    super.dispose();
  }

  Widget _reveal(Widget child,
      {double fromY = 0.25, double delay = 0.0}) {
    final delayed = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(delay, 1.0, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: delayed,
      child: SlideTransition(
        position: Tween<Offset>(
                begin: Offset(0, fromY), end: Offset.zero)
            .animate(delayed),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _reveal(
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.accent.withOpacity(0.3), width: 1),
            ),
            child: Text(
              'Our Team',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.accent,
                letterSpacing: 1.4,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        _reveal(
          Column(
            children: [
              Text(
                'The experts behind\nyour digital growth',
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _lineCtrl,
                builder: (_, __) {
                  final v = CurvedAnimation(
                          parent: _lineCtrl,
                          curve: Curves.easeOutExpo)
                      .value;
                  return Align(
                    child: Container(
                      height: 3,
                      width: 60 * v,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppTheme.accent,
                          AppTheme.accent.withOpacity(0.2),
                        ]),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          delay: 0.15,
        ),

        const SizedBox(height: 16),

        _reveal(
          Text(
            'A passionate, experienced team of marketers,\ncontent creators, and ad specialists.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.textSecondary,
              height: 1.6,
            ),
          ),
          fromY: 0.15,
          delay: 0.28,
        ),
      ],
    );
  }
}

// ─── Team Section ─────────────────────────────────────────────────────────────

class TeamSection extends StatefulWidget {
  const TeamSection({super.key});

  @override
  State<TeamSection> createState() => _TeamSectionState();
}

class _TeamSectionState extends State<TeamSection> {
  TeamMember? _expandedMember;

  void _openMember(TeamMember member) =>
      setState(() => _expandedMember = member);

  void _closeMember() => setState(() => _expandedMember = null);

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final hPad = wide ? 80.0 : 24.0;

    return Stack(
      children: [
        // ── Main section ──
        Container(
          color: AppTheme.surface,
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
          child: Column(children: [
            const _AnimatedHeader(),
            const SizedBox(height: 52),
            LayoutBuilder(builder: (_, c) {
              final w = c.maxWidth;
              final cardW = w > 1000
                  ? (w - 60) / 4
                  : (w > 640 ? (w - 20) / 2 : w);
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: AppData.team
                    .asMap()
                    .entries
                    .map((e) => SizedBox(
                          width: cardW,
                          child: _TeamCard(
                            member: e.value,       // ✅ TeamMember
                            index: e.key,
                            onTap: () => _openMember(e.value),
                          ),
                        ))
                    .toList(),
              );
            }),
          ]),
        ),

        // ── Full-screen overlay ──
        if (_expandedMember != null)
          Positioned.fill(
            child: _TeamOverlay(
              member: _expandedMember!,            // ✅ TeamMember
              onClose: _closeMember,
            ),
          ),
      ],
    );
  }
}