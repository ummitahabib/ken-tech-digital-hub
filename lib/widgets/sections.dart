import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/app_data.dart';
import 'common_widgets.dart';

// ─── Partners Strip ───────────────────────────────────────────────────────────
class PartnersStrip extends StatelessWidget {
  const PartnersStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Container(
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 28),
      child: Column(
        children: [
          Text(
            'TRUSTED TOOLS & PLATFORMS WE USE',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textLight,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: AppData.partners.map((p) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Text(
                  p['name']!,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
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

// ─── Services Section ─────────────────────────────────────────────────────────
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'What We Do',
            title: 'Digital services that\ndrive real results',
            subtitle: 'From social media management to paid advertising, we offer everything your business needs to dominate the digital space.',
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (ctx, constraints) {
              int cols = constraints.maxWidth > 1000 ? 3 : (constraints.maxWidth > 650 ? 2 : 1);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  childAspectRatio: cols == 1 ? 1.4 : (cols == 2 ? 0.85 : 0.9),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: AppData.services.length,
                itemBuilder: (_, i) => ServiceCard(service: AppData.services[i]),
              );
            },
          ),
          const SizedBox(height: 48),
          PrimaryButton(text: 'View All Services', icon: Icons.arrow_forward_rounded, isOutlined: true),
        ],
      ),
    );
  }
}

// ─── Stats Banner ─────────────────────────────────────────────────────────────
class StatsBanner extends StatelessWidget {
  const StatsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.darkBg, AppTheme.darkCard, AppTheme.darkBg],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 60),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _DotPainter()),
          ),
          Wrap(
            spacing: 0,
            runSpacing: 0,
            alignment: WrapAlignment.center,
            children: AppData.stats.asMap().entries.map((entry) {
              final i = entry.key;
              final s = entry.value;
              final isLast = i == AppData.stats.length - 1;
              return IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      child: Column(
                        children: [
                          Icon(
                            s['icon'] as IconData,
                            size: 28,
                            color: AppTheme.accent,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            s['value'] as String,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s['label'] as String,
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 1,
                        height: 60,
                        color: AppTheme.darkCardBorder,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0xFF1E2A45).withOpacity(0.6);
    const spacing = 24.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─── Work / Portfolio Section ─────────────────────────────────────────────────
class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'Our Work',
            title: 'Campaigns that\ndelivered results',
            subtitle: 'Real projects. Real clients. Real outcomes. Here is a snapshot of what we have achieved.',
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (ctx, constraints) {
              int cols = constraints.maxWidth > 900 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: AppData.projects.length,
                itemBuilder: (_, i) => ProjectCard(project: AppData.projects[i]),
              );
            },
          ),
          const SizedBox(height: 48),
          PrimaryButton(text: 'See All Case Studies', icon: Icons.arrow_forward_rounded),
        ],
      ),
    );
  }
}

// ─── About / Why Us Section ───────────────────────────────────────────────────
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _AboutImage()),
                const SizedBox(width: 80),
                Expanded(flex: 5, child: _AboutContent()),
              ],
            )
          : Column(
              children: [
                _AboutContent(),
                const SizedBox(height: 48),
                _AboutImage(),
              ],
            ),
    );
  }
}

class _AboutImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 480,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 40, offset: const Offset(0, 16))],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            'https://images.unsplash.com/photo-1552664730-d307ca884978?w=700',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: AppTheme.surface),
          ),
        ),
        // Floating card
        Positioned(
          bottom: 24,
          right: -20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppTheme.darkCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.darkCardBorder),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 24, offset: const Offset(0, 8))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.location_on_rounded, color: AppTheme.accent, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Based in Nigeria', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('Serving clients nationwide', style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withOpacity(0.5))),
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

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          eyebrow: 'About Us',
          title: 'Years of experience in the digital landscape',
          centered: false,
        ),
        const SizedBox(height: 24),
        Text(
          'Ken Digital Tech Hub is a full-service digital marketing agency based in Nigeria. With years of experience helping businesses succeed online, we combine strategy, creativity, and data to deliver outstanding results for our clients.',
          style: GoogleFonts.inter(fontSize: 15, color: AppTheme.textSecondary, height: 1.75),
        ),
        const SizedBox(height: 16),
        Text(
          'From growing social media followings to running high-converting ad campaigns, we are dedicated to helping Nigerian businesses thrive in the digital age. We don\'t just run campaigns — we build lasting digital presences.',
          style: GoogleFonts.inter(fontSize: 15, color: AppTheme.textSecondary, height: 1.75),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _AboutPoint(icon: Icons.ads_click_rounded,        text: 'Strategy-first approach'),
            _AboutPoint(icon: Icons.bar_chart_rounded,         text: 'Data-driven decisions'),
            _AboutPoint(icon: Icons.support_agent_rounded,     text: 'Dedicated account managers'),
            _AboutPoint(icon: Icons.assessment_rounded,        text: 'Monthly performance reports'),
            _AboutPoint(icon: Icons.public_rounded,            text: 'Deep Nigerian market knowledge'),
            _AboutPoint(icon: Icons.bolt_rounded,              text: 'Agile & fast execution'),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            PrimaryButton(text: 'Meet the Team', icon: Icons.people_alt_rounded),
            const SizedBox(width: 16),
            PrimaryButton(text: 'Our Story', isOutlined: true),
          ],
        ),
      ],
    );
  }
}

class _AboutPoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AboutPoint({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppTheme.tagCyan,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: AppTheme.tagCyanText),
        ),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
      ],
    );
  }
}

// ─── Team Section ─────────────────────────────────────────────────────────────
class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.darkBg, AppTheme.darkCard],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'Our Team',
            title: 'The experts behind\nyour digital growth',
            subtitle: 'A passionate, experienced team of digital marketers, content creators, and ad specialists.',
            dark: true,
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (ctx, constraints) {
              final w = constraints.maxWidth;
              // Card width: 4-up on wide, 2-up on medium, full-width on mobile
              final double cardWidth = w > 1000
                  ? (w - 60) / 4   // 4 cols, 3 gaps of 20
                  : w > 640
                      ? (w - 20) / 2  // 2 cols, 1 gap of 20
                      : w;            // 1 col

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: AppData.team
                    .map((m) => SizedBox(
                          width: cardWidth,
                          child: TeamCard(member: m),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Testimonials Section ─────────────────────────────────────────────────────
class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'Client Stories',
            title: 'What our clients say\nabout working with us',
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (ctx, constraints) {
              int cols = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
              if (cols == 1) {
                return SizedBox(
                  height: 360,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.testimonials.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 20),
                    itemBuilder: (_, i) => SizedBox(
                      width: 320,
                      child: TestimonialCard(testimonial: AppData.testimonials[i]),
                    ),
                  ),
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AppData.testimonials
                    .map((t) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TestimonialCard(testimonial: t),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── FAQ Section ──────────────────────────────────────────────────────────────
class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.darkBg, AppTheme.darkCard],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 96),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'FAQ',
            title: 'Frequently asked questions',
            subtitle: 'Everything you need to know before partnering with Ken Digital Tech Hub.',
            dark: true,
          ),
          const SizedBox(height: 56),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: AppData.faqs.map((f) => FaqTile(item: f, dark: true)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Blog Section ─────────────────────────────────────────────────────────────
class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      color: AppTheme.surface,
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
                  title: 'Digital marketing\ntips & insights',
                  centered: false,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: AppTheme.accent),
                label: Text('All Articles', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.accent)),
              ),
            ],
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (ctx, constraints) {
              int cols = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
              if (cols == 1) {
                return SizedBox(
                  height: 420,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.blogPosts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 20),
                    itemBuilder: (_, i) => SizedBox(width: 300, child: BlogCard(post: AppData.blogPosts[i])),
                  ),
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AppData.blogPosts
                    .map((p) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: BlogCard(post: p),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── CTA Banner ───────────────────────────────────────────────────────────────
class CtaBanner extends StatelessWidget {
  const CtaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: hPad, vertical: 64),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.accent, AppTheme.accentAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppTheme.accent.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 16)),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomPaint(painter: _WavePainter()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 56),
            child: isWide
                ? Row(
                    children: [
                      Expanded(child: _CtaContent()),
                      const SizedBox(width: 40),
                      _CtaForm(),
                    ],
                  )
                : Column(
                    children: [
                      _CtaContent(),
                      const SizedBox(height: 32),
                      _CtaForm(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(0.06);
    final path1 = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.3, size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.6)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path1, p);

    final path2 = Path()
      ..moveTo(0, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.1, size.width * 0.6, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.6, size.width, size.height * 0.4)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path2, Paint()..color = Colors.white.withOpacity(0.04));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _CtaContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ready to grow your\nbusiness online?',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Book a free strategy call with our team. No commitments, just a real conversation about how we can help.',
          style: GoogleFonts.inter(fontSize: 15, color: Colors.white.withOpacity(0.8), height: 1.6),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: ['Free consultation', 'No contracts', '48h response', 'Nigeria-based team']
              .map((t) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 16, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(t, style: GoogleFonts.inter(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500)),
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _CtaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 32, offset: const Offset(0, 12))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Get Your Free Consultation',
              style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
          const SizedBox(height: 20),
          _FormField(hint: 'Your full name', icon: Icons.person_outline_rounded),
          const SizedBox(height: 12),
          _FormField(hint: 'Email address', icon: Icons.email_outlined),
          const SizedBox(height: 12),
          _FormField(hint: 'WhatsApp number', icon: Icons.phone_outlined),
          const SizedBox(height: 12),
          _FormField(hint: 'Tell us about your business', icon: Icons.business_outlined, lines: 2),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.accent, AppTheme.accentAlt]),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Book Free Call', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final int lines;

  const _FormField({required this.hint, required this.icon, this.lines = 1});

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
          prefixIcon: Icon(icon, size: 18, color: AppTheme.textLight),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: lines > 1 ? 14 : 12, horizontal: lines > 1 ? 16 : 0),
        ),
      ),
    );
  }
}

// ─── Newsletter + Footer ──────────────────────────────────────────────────────
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? 80.0 : 24.0;

    return Container(
      color: AppTheme.darkBg,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        children: [
          const SizedBox(height: 60),
          // Newsletter
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.darkCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.darkCardBorder),
            ),
            child: isWide
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Subscribe to our Newsletter',
                                style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                            const SizedBox(height: 6),
                            Text('Get weekly digital marketing tips & industry insights.',
                                style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(child: _NewsletterInput()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Subscribe to our Newsletter',
                          style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                      const SizedBox(height: 6),
                      Text('Get weekly digital marketing tips.',
                          style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.5))),
                      const SizedBox(height: 20),
                      _NewsletterInput(),
                    ],
                  ),
          ),
          const SizedBox(height: 60),
          const Divider(color: AppTheme.darkCardBorder),
          const SizedBox(height: 48),
          // Footer links
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _FooterBrand()),
                    const SizedBox(width: 40),
                    Expanded(child: _FooterCol('Services', ['Social Media', 'Paid Ads', 'Content', 'SEO', 'Training'])),
                    Expanded(child: _FooterCol('Company', ['About Us', 'Our Team', 'Portfolio', 'Blog', 'Careers'])),
                    Expanded(child: _FooterCol('Contact', ['WhatsApp', 'Email Us', 'LinkedIn', 'Instagram', 'Free Consultation'])),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FooterBrand(),
                    const SizedBox(height: 36),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _FooterCol('Services', ['Social Media', 'Paid Ads', 'Content', 'SEO'])),
                        Expanded(child: _FooterCol('Company', ['About', 'Team', 'Portfolio', 'Blog'])),
                        Expanded(child: _FooterCol('Contact', ['WhatsApp', 'Email', 'LinkedIn', 'Instagram'])),
                      ],
                    ),
                  ],
                ),
          const SizedBox(height: 48),
          const Divider(color: AppTheme.darkCardBorder),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 Ken Digital Tech Hub. All rights reserved.',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withOpacity(0.35)),
              ),
              Text(
                'Empowering businesses in the digital landscape 🇳🇬',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withOpacity(0.35)),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _NewsletterInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.darkCardBorder),
            ),
            child: TextField(
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Enter your email address',
                hintStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.35), fontSize: 13),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 48,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [AppTheme.accent, AppTheme.accentAlt]),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 22)),
            child: Text('Subscribe', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.accent, AppTheme.accentAlt]),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Center(child: Text('KD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13))),
            ),
            const SizedBox(width: 10),
            Text('Ken Digital Tech Hub',
                style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Helping Nigerian businesses\nsucceed in the digital landscape.',
          style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.45), height: 1.6),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: const [
            _SocialIcon(icon: Icons.facebook_rounded,      tooltip: 'Facebook'),
            _SocialIcon(icon: Icons.work_outline_rounded,  tooltip: 'LinkedIn'),
            _SocialIcon(icon: Icons.photo_camera_outlined, tooltip: 'Instagram'),
            _SocialIcon(icon: Icons.tag_rounded,           tooltip: 'Twitter / X'),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  const _SocialIcon({required this.icon, required this.tooltip});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () {},
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _hovered
                  ? AppTheme.accent.withOpacity(0.15)
                  : Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _hovered
                    ? AppTheme.accent.withOpacity(0.5)
                    : Colors.white.withOpacity(0.1),
              ),
            ),
            child: Icon(
              widget.icon,
              size: 16,
              color: _hovered ? AppTheme.accent : Colors.white.withOpacity(0.55),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterCol extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterCol(this.title, this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 16),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  item,
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.45)),
                ),
              ),
            )),
      ],
    );
  }
}