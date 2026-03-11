import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onCtaPressed;
  const HeroSection({super.key, this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF060B18), Color(0xFF0F1629), Color(0xFF060B18)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background grid pattern
          Positioned.fill(child: _GridPattern()),
          // Glow orbs
          Positioned(top: -80, right: -80, child: _GlowOrb(color: AppTheme.accentAlt, size: 400)),
          Positioned(bottom: 50, left: -100, child: _GlowOrb(color: AppTheme.accent, size: 350)),
          // Content
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 120, hPad, 80),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: _HeroText(onCtaPressed: onCtaPressed)),
                      const SizedBox(width: 60),
                      Expanded(flex: 5, child: _HeroVisual()),
                    ],
                  )
                : Column(
                    children: [
                      _HeroText(onCtaPressed: onCtaPressed),
                      const SizedBox(height: 48),
                      _HeroVisual(),
                    ],
                  ),
          ),
          // Bottom fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppTheme.background.withOpacity(0.1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter());
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E2A45).withOpacity(0.35)
      ..strokeWidth = 0.5;

    const spacing = 50.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(0.18), Colors.transparent],
        ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final VoidCallback? onCtaPressed;
  const _HeroText({this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppTheme.accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppTheme.accent.withOpacity(0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(color: AppTheme.accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                'Nigeria\'s Premier Digital Hub',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.accent,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // Headline
        Text(
          'We Grow\nYour Brand\nOnline.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: w > 1100 ? 68 : (w > 600 ? 52 : 40),
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.05,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 10),
        // Accent line
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppTheme.accent, AppTheme.accentAlt],
          ).createShader(bounds),
          child: Text(
            'Digital. Strategic. Results.',
            style: GoogleFonts.spaceGrotesk(
              fontSize: w > 1100 ? 28 : (w > 600 ? 22 : 18),
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Ken Digital Tech Hub helps businesses across Nigeria succeed in the digital landscape — through expert social media management, paid advertising, content creation, and proven digital marketing strategies.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: Colors.white.withOpacity(0.65),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 40),
        // CTA buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _HeroCta(label: 'Start Growing Today', isPrimary: true, onTap: onCtaPressed),
            _HeroCta(label: 'View Our Work', isPrimary: false),
          ],
        ),
        const SizedBox(height: 48),
        // Social proof
        _SocialProof(),
      ],
    );
  }
}

class _HeroCta extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback? onTap;
  const _HeroCta({required this.label, required this.isPrimary, this.onTap});

  @override
  State<_HeroCta> createState() => _HeroCtaState();
}

class _HeroCtaState extends State<_HeroCta> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: widget.isPrimary
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.accent, AppTheme.accentAlt],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: _hovered
                    ? [BoxShadow(color: AppTheme.accent.withOpacity(0.5), blurRadius: 24, offset: const Offset(0, 8))]
                    : [],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
                color: _hovered ? Colors.white.withOpacity(0.08) : Colors.transparent,
              ),
        child: TextButton(
          onPressed: widget.onTap ?? () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              if (widget.isPrimary) ...[
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialProof extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatars
        SizedBox(
          width: 90,
          height: 38,
          child: Stack(
            children: List.generate(
              4,
              (i) => Positioned(
                left: i * 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.darkBg, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: AppTheme.darkCard,
                    backgroundImage: NetworkImage(
                      [
                        'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=80',
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80',
                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=80',
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80',
                      ][i],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ...List.generate(5, (_) => const Icon(Icons.star_rounded, size: 14, color: AppTheme.starColor)),
                const SizedBox(width: 6),
                Text('5.0', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
              ],
            ),
            Text(
              '200+ happy clients across Nigeria',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withOpacity(0.55)),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main stats card
        _StatsCard(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _MetricCard(value: '3.2M+', label: 'Reach Generated', icon: Icons.people_alt_rounded, color: AppTheme.accent)),
            const SizedBox(width: 16),
            Expanded(child: _MetricCard(value: '98%', label: 'Client Retention', icon: Icons.favorite_rounded, color: AppTheme.accentAlt)),
          ],
        ),
        const SizedBox(height: 16),
        _RecentWinCard(),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.darkCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text('Campaign Performance', style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withOpacity(0.6))),
              const Spacer(),
              Text('Live', style: GoogleFonts.inter(fontSize: 11, color: AppTheme.accent, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat('340%', 'Growth'),
              _Divider(),
              _MiniStat('₦50M+', 'Ad Spend'),
              _Divider(),
              _MiniStat('200+', 'Clients'),
            ],
          ),
          const SizedBox(height: 20),
          // Fake chart bars
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [0.3, 0.5, 0.4, 0.7, 0.6, 0.9, 0.8, 1.0, 0.85, 0.95, 0.88, 0.92].map((v) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    height: 60 * v,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.accent.withOpacity(0.3), AppTheme.accent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  const _MiniStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 2),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withOpacity(0.5))),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: AppTheme.darkCardBorder);
  }
}

class _MetricCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _MetricCard({required this.value, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.darkCardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
              Text(label, style: GoogleFonts.inter(fontSize: 10, color: Colors.white.withOpacity(0.5))),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentWinCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.darkCardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppTheme.accent, AppTheme.accentAlt]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recent Win', style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withOpacity(0.5))),
                Text(
                  'Grew client to 50K followers in 4 months',
                  style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.accent, size: 14),
        ],
      ),
    );
  }
}
