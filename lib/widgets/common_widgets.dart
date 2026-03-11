import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/app_data.dart';

// ─── Section Header ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool centered;
  final bool dark;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.centered = true,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    final align = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final tAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.accent.withOpacity(dark ? 0.15 : 0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
          ),
          child: Text(
            eyebrow.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.accent,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: tAlign,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: dark ? Colors.white : AppTheme.textPrimary,
            height: 1.2,
            letterSpacing: -0.8,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              subtitle!,
              textAlign: tAlign,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: dark ? Colors.white.withOpacity(0.6) : AppTheme.textSecondary,
                height: 1.65,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Primary Button ───────────────────────────────────────────────────────────
class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final IconData? icon;
  final bool dark;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.dark = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: widget.isOutlined
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: widget.dark ? Colors.white.withOpacity(0.3) : AppTheme.accent),
                color: _hovered ? AppTheme.accent.withOpacity(0.1) : Colors.transparent,
              )
            : BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.accent, AppTheme.accentAlt],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: _hovered
                    ? [BoxShadow(color: AppTheme.accent.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 6))]
                    : [],
              ),
        child: TextButton(
          onPressed: widget.onPressed ?? () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.isOutlined
                      ? (widget.dark ? Colors.white : AppTheme.accent)
                      : Colors.white,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: 16, color: widget.isOutlined ? AppTheme.accent : Colors.white),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Service Card ─────────────────────────────────────────────────────────────
class ServiceCard extends StatefulWidget {
  final Service service;
  final bool dark;

  const ServiceCard({super.key, required this.service, this.dark = false});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: widget.dark
              ? (_hovered ? AppTheme.darkCardBorder : AppTheme.darkCard)
              : (_hovered ? Colors.white : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppTheme.accent.withOpacity(0.5)
                : (widget.dark ? AppTheme.darkCardBorder : AppTheme.divider),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(widget.dark ? 0.1 : 0.12),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                ]
              : (widget.dark
                  ? []
                  : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.accent.withOpacity(0.2)),
                  ),
                  child: Center(
                    child: Icon(widget.service.icon, size: 24, color: AppTheme.accent),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentAlt.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.accentAlt.withOpacity(0.3)),
                  ),
                  child: Text(
                    widget.service.tag,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentAlt,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.service.title,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: widget.dark ? Colors.white : AppTheme.textPrimary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.service.description,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: widget.dark ? Colors.white.withOpacity(0.55) : AppTheme.textSecondary,
                height: 1.65,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            ...widget.service.features.take(3).map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppTheme.accent.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, size: 10, color: AppTheme.accent),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          f,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: widget.dark ? Colors.white.withOpacity(0.6) : AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Learn more',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accent,
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(_hovered ? 4 : 0, 0, 0),
                  child: const Icon(Icons.arrow_forward_rounded, size: 14, color: AppTheme.accent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Project Card ─────────────────────────────────────────────────────────────
class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.15 : 0.06),
              blurRadius: _hovered ? 32 : 12,
              offset: Offset(0, _hovered ? 12 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Image
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  widget.project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppTheme.darkCard,
                    child: const Icon(Icons.image, size: 48, color: AppTheme.textLight),
                  ),
                ),
              ),
              // Overlay
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(_hovered ? 0.9 : 0.75),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Category badge
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.project.category,
                    style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.darkBg),
                  ),
                ),
              ),
              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.client,
                        style: GoogleFonts.inter(fontSize: 12, color: AppTheme.accent, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.project.title,
                        style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Text(
                          '🏆 ${widget.project.result}',
                          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ],
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

// ─── Testimonial Card ─────────────────────────────────────────────────────────
class TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;
  final bool dark;

  const TestimonialCard({super.key, required this.testimonial, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: dark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dark ? AppTheme.darkCardBorder : AppTheme.divider),
        boxShadow: dark
            ? []
            : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stars
          Row(children: List.generate(5, (_) => const Icon(Icons.star_rounded, size: 16, color: AppTheme.starColor))),
          const SizedBox(height: 16),
          Text(
            '"${testimonial.content}"',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: dark ? Colors.white.withOpacity(0.7) : AppTheme.textSecondary,
              height: 1.7,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(testimonial.imageUrl),
                backgroundColor: AppTheme.surface,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: dark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    '${testimonial.role}, ${testimonial.company}',
                    style: GoogleFonts.inter(fontSize: 12, color: dark ? Colors.white.withOpacity(0.5) : AppTheme.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── FAQ Tile ─────────────────────────────────────────────────────────────────
class FaqTile extends StatefulWidget {
  final FaqItem item;
  final bool dark;

  const FaqTile({super.key, required this.item, this.dark = false});

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: widget.dark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _expanded
              ? AppTheme.accent.withOpacity(0.5)
              : (widget.dark ? AppTheme.darkCardBorder : AppTheme.divider),
          width: _expanded ? 1.5 : 1.0,
        ),
        boxShadow: _expanded
            ? [BoxShadow(
                color: AppTheme.accent.withOpacity(widget.dark ? 0.08 : 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              )]
            : [],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggle,
          splashColor: AppTheme.accent.withOpacity(0.06),
          highlightColor: AppTheme.accent.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Question row ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.question,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: widget.dark ? Colors.white : AppTheme.textPrimary,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Animated +/− icon button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _expanded
                            ? AppTheme.accent
                            : AppTheme.accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Icon(
                            _expanded
                                ? Icons.remove_rounded
                                : Icons.add_rounded,
                            key: ValueKey(_expanded),
                            size: 16,
                            color: _expanded
                                ? Colors.white
                                : AppTheme.accent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Answer — animates open/close smoothly ───────────────
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: _expanded
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: widget.dark
                                  ? AppTheme.darkCardBorder
                                  : AppTheme.divider,
                              height: 1,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.item.answer,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: widget.dark
                                    ? Colors.white.withOpacity(0.65)
                                    : AppTheme.textSecondary,
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Team Card ────────────────────────────────────────────────────────────────
class TeamCard extends StatefulWidget {
  final TeamMember member;

  const TeamCard({super.key, required this.member});

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppTheme.darkCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppTheme.accent.withOpacity(0.4)
                : AppTheme.darkCardBorder,
          ),
          boxShadow: _hovered
              ? [BoxShadow(
                  color: AppTheme.accent.withOpacity(0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                )]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,          // ← shrink-wrap height
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Photo ────────────────────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 1.1,                  // ← proportional, never clips
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.member.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : Container(
                              color: AppTheme.darkCardBorder,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppTheme.accent,
                                ),
                              ),
                            ),
                      errorBuilder: (_, __, ___) => Container(
                        color: AppTheme.darkCardBorder,
                        child: const Icon(
                          Icons.person_rounded,
                          size: 64,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ),
                    // Bottom gradient
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Color(0xCC060B18)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Info ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.member.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.member.role,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.accent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.member.bio,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.55),
                      height: 1.55,
                    ),
                    // No maxLines — let text wrap naturally inside card
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _SocialChip(icon: Icons.link_rounded,        label: 'LinkedIn'),
                      _SocialChip(icon: Icons.camera_alt_outlined, label: 'Instagram'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white.withOpacity(0.6)),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.inter(fontSize: 10, color: Colors.white.withOpacity(0.6))),
        ],
      ),
    );
  }
}

// ─── Blog Card ────────────────────────────────────────────────────────────────
class BlogCard extends StatefulWidget {
  final BlogPost post;

  const BlogCard({super.key, required this.post});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _hovered ? AppTheme.accent.withOpacity(0.3) : AppTheme.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.1 : 0.04),
              blurRadius: _hovered ? 24 : 8,
              offset: Offset(0, _hovered ? 8 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                widget.post.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(height: 180, color: AppTheme.surface),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.tagCyan,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(widget.post.category,
                            style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.tagCyanText)),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.post.readMin} min read',
                        style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLight),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.post.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.post.excerpt,
                    style: GoogleFonts.inter(fontSize: 13, color: AppTheme.textSecondary, height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.post.date, style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLight)),
                      Row(
                        children: [
                          Text('Read more', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.accent)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_rounded, size: 13, color: AppTheme.accent),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}