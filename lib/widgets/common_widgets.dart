import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/app_data.dart';

// ─── Section Header ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String eyebrow, title;
  final String? subtitle;
  final bool centered, dark;

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
    final ta    = centered ? TextAlign.center          : TextAlign.start;

    return Column(crossAxisAlignment: align, children: [
      // Eyebrow pill
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: dark ? AppTheme.accent.withOpacity(0.15) : AppTheme.tagCyan,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
        ),
        child: Text(eyebrow.toUpperCase(),
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700,
              color: AppTheme.tagCyanText, letterSpacing: 1.4)),
      ),
      const SizedBox(height: 16),
      Text(title, textAlign: ta,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 38, fontWeight: FontWeight.w700,
          color: dark ? Colors.white : AppTheme.textPrimary,
          height: 1.15, letterSpacing: -0.8,
        )),
      if (subtitle != null) ...[
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(subtitle!, textAlign: ta,
            style: GoogleFonts.inter(fontSize: 16,
                color: dark ? Colors.white.withOpacity(0.6) : AppTheme.textSecondary,
                height: 1.68)),
        ),
      ],
    ]);
  }
}

// ─── Primary Button ───────────────────────────────────────────────────────────
class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined, dark;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.dark = false,
  });

  @override
  State<PrimaryButton> createState() => _PBState();
}

class _PBState extends State<PrimaryButton> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: widget.isOutlined
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: widget.dark ? Colors.white.withOpacity(0.3) : AppTheme.accent),
                color: _hov ? AppTheme.accent.withOpacity(0.08) : Colors.transparent,
              )
            : BoxDecoration(
                color: _hov ? AppTheme.accentDark : AppTheme.accent,
                borderRadius: BorderRadius.circular(8),
                boxShadow: _hov
                    ? [BoxShadow(color: AppTheme.accent.withOpacity(0.35),
                            blurRadius: 18, offset: const Offset(0, 5))]
                    : [],
              ),
        child: TextButton(
          onPressed: widget.onPressed ?? () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(widget.text,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                  color: widget.isOutlined
                      ? (widget.dark ? Colors.white : AppTheme.accent)
                      : Colors.white)),
            if (widget.icon != null) ...[
              const SizedBox(width: 7),
              Icon(widget.icon, size: 15,
                  color: widget.isOutlined
                      ? (widget.dark ? Colors.white : AppTheme.accent)
                      : Colors.white),
            ],
          ]),
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
  State<ServiceCard> createState() => _SCState();
}

class _SCState extends State<ServiceCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: widget.dark ? AppTheme.darkCard : AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hov
                ? AppTheme.accent.withOpacity(0.5)
                : (widget.dark ? AppTheme.darkCardBorder : AppTheme.divider),
            width: _hov ? 1.5 : 1,
          ),
          boxShadow: _hov
              ? [BoxShadow(color: AppTheme.accent.withOpacity(0.1),
                      blurRadius: 24, offset: const Offset(0, 6))]
              : [BoxShadow(color: Colors.black.withOpacity(0.04),
                      blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppTheme.accent.withOpacity(0.2)),
              ),
              child: Icon(widget.service.icon, size: 22, color: AppTheme.accent),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.tagPurple,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(widget.service.tag,
                style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600,
                    color: AppTheme.tagPurpleText)),
            ),
          ]),
          const SizedBox(height: 18),
          Text(widget.service.title,
            style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w700,
                color: widget.dark ? Colors.white : AppTheme.textPrimary, height: 1.3)),
          const SizedBox(height: 8),
          Text(widget.service.description,
            style: GoogleFonts.inter(fontSize: 13,
                color: widget.dark ? Colors.white.withOpacity(0.55) : AppTheme.textSecondary,
                height: 1.6),
            maxLines: 3, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 16),
          ...widget.service.features.take(3).map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Row(children: [
              Container(width: 16, height: 16,
                decoration: BoxDecoration(
                    color: AppTheme.accent.withOpacity(0.12), shape: BoxShape.circle),
                child: const Icon(Icons.check, size: 10, color: AppTheme.accent)),
              const SizedBox(width: 7),
              Expanded(child: Text(f,
                style: GoogleFonts.inter(fontSize: 12,
                    color: widget.dark
                        ? Colors.white.withOpacity(0.55)
                        : AppTheme.textSecondary))),
            ]),
          )),
          const SizedBox(height: 14),
          Row(children: [
            Text('Learn more',
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600,
                  color: AppTheme.accent)),
            const SizedBox(width: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(_hov ? 4 : 0, 0, 0),
              child: const Icon(Icons.arrow_forward_rounded, size: 13, color: AppTheme.accent),
            ),
          ]),
        ]),
      ),
    );
  }
}

// ─── Project Card ─────────────────────────────────────────────────────────────
class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});
  @override
  State<ProjectCard> createState() => _PCState();
}

class _PCState extends State<ProjectCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(_hov ? 0.14 : 0.06),
              blurRadius: _hov ? 28 : 10,
              offset: Offset(0, _hov ? 10 : 3))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(children: [
            SizedBox(height: 280, width: double.infinity,
              child: Image.network(widget.project.imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppTheme.surface,
                  child: const Icon(Icons.image_outlined, size: 48, color: AppTheme.textLight)))),
            Positioned.fill(child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(_hov ? 0.88 : 0.72)],
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
              )),
            )),
            Positioned(top: 14, left: 14, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                  color: AppTheme.accent, borderRadius: BorderRadius.circular(5)),
              child: Text(widget.project.category,
                style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700,
                    color: Colors.white)),
            )),
            Positioned(bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.project.client,
                    style: GoogleFonts.inter(fontSize: 11, color: AppTheme.accent,
                        fontWeight: FontWeight.w600)),
                  const SizedBox(height: 3),
                  Text(widget.project.title,
                    style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700,
                        color: Colors.white)),
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white.withOpacity(0.2))),
                    child: Text('🏆  ${widget.project.result}',
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  ),
                ]),
              )),
          ]),
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
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: dark ? AppTheme.darkCard : AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: dark ? AppTheme.darkCardBorder : AppTheme.divider),
        boxShadow: dark
            ? []
            : [BoxShadow(color: Colors.black.withOpacity(0.04),
                    blurRadius: 14, offset: const Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: List.generate(5, (_) =>
            const Icon(Icons.star_rounded, size: 15, color: AppTheme.starColor))),
        const SizedBox(height: 14),
        Text('"${testimonial.content}"',
          style: GoogleFonts.inter(fontSize: 14, fontStyle: FontStyle.italic,
              color: dark ? Colors.white.withOpacity(0.7) : AppTheme.textSecondary,
              height: 1.7)),
        const SizedBox(height: 20),
        Row(children: [
          CircleAvatar(radius: 20,
              backgroundImage: NetworkImage(testimonial.imageUrl),
              backgroundColor: AppTheme.surface),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(testimonial.name,
              style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w700,
                  color: dark ? Colors.white : AppTheme.textPrimary)),
            Text('${testimonial.role}, ${testimonial.company}',
              style: GoogleFonts.inter(fontSize: 11,
                  color: dark ? Colors.white.withOpacity(0.5) : AppTheme.textLight)),
          ]),
        ]),
      ]),
    );
  }
}

// ─── FAQ Tile ─────────────────────────────────────────────────────────────────
class FaqTile extends StatefulWidget {
  final FaqItem item;
  final bool dark;

  const FaqTile({super.key, required this.item, this.dark = false});

  @override
  State<FaqTile> createState() => _FaqState();
}

class _FaqState extends State<FaqTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: widget.dark ? AppTheme.darkCard : AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _open
              ? AppTheme.accent.withOpacity(0.5)
              : (widget.dark ? AppTheme.darkCardBorder : AppTheme.divider),
          width: _open ? 1.5 : 1,
        ),
        boxShadow: _open
            ? [BoxShadow(color: AppTheme.accent.withOpacity(0.07),
                    blurRadius: 14, offset: const Offset(0, 4))]
            : [],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _open = !_open),
          splashColor: AppTheme.accent.withOpacity(0.05),
          highlightColor: AppTheme.accent.withOpacity(0.03),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(child: Text(widget.item.question,
                  style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w600,
                      color: widget.dark ? Colors.white : AppTheme.textPrimary, height: 1.3))),
                const SizedBox(width: 14),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 230),
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: _open ? AppTheme.accent : AppTheme.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
                    child: Icon(
                      _open ? Icons.remove_rounded : Icons.add_rounded,
                      key: ValueKey(_open), size: 15,
                      color: _open ? Colors.white : AppTheme.accent,
                    ),
                  ),
                ),
              ]),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOutCubic,
              child: _open
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Divider(
                            color: widget.dark
                                ? AppTheme.darkCardBorder
                                : AppTheme.divider,
                            height: 1),
                        const SizedBox(height: 14),
                        Text(widget.item.answer,
                          style: GoogleFonts.inter(fontSize: 14,
                              color: widget.dark
                                  ? Colors.white.withOpacity(0.65)
                                  : AppTheme.textSecondary,
                              height: 1.7)),
                      ]),
                    )
                  : const SizedBox.shrink(),
            ),
          ]),
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
  State<TeamCard> createState() => _TCState();
}

class _TCState extends State<TeamCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    // FIX: use widget.member (not bare 'member')
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: _hov ? AppTheme.accent.withOpacity(0.4) : AppTheme.divider),
          boxShadow: _hov
              ? [BoxShadow(color: AppTheme.accent.withOpacity(0.1),
                      blurRadius: 22, offset: const Offset(0, 6))]
              : [BoxShadow(color: Colors.black.withOpacity(0.04),
                      blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Photo ──────────────────────────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: AspectRatio(
                aspectRatio: 1.1,
                child: Stack(fit: StackFit.expand, children: [
                  Image.network(
                    widget.member.imageUrl,   // ← widget.member  ✓
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, prog) => prog == null
                        ? child
                        : Container(color: AppTheme.surface,
                            child: const Center(child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppTheme.accent))),
                    errorBuilder: (_, __, ___) => Container(
                        color: AppTheme.surface,
                        child: const Icon(Icons.person_rounded, size: 60,
                            color: AppTheme.textLight)),
                  ),
                  const DecoratedBox(decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Color(0xCC06110A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 1.0],
                    ),
                  )),
                ]),
              ),
            ),
            // ── Info ───────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.member.name,   // ← widget.member  ✓
                    style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary)),
                  const SizedBox(height: 3),
                  Text(widget.member.role,   // ← widget.member  ✓
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500,
                        color: AppTheme.accent)),
                  const SizedBox(height: 9),
                  Text(widget.member.bio,    // ← widget.member  ✓
                    style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textSecondary,
                        height: 1.55)),
                  const SizedBox(height: 14),
                  const Wrap(spacing: 7, runSpacing: 7, children: [
                    _SocialChip(icon: Icons.link_rounded,        label: 'LinkedIn'),
                    _SocialChip(icon: Icons.camera_alt_outlined, label: 'Instagram'),
                  ]),
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
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 11, color: AppTheme.textLight),
        const SizedBox(width: 4),
        Text(label,
          style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLight)),
      ]),
    );
  }
}

// ─── Blog Card ────────────────────────────────────────────────────────────────
class BlogCard extends StatefulWidget {
  final BlogPost post;
  const BlogCard({super.key, required this.post});

  @override
  State<BlogCard> createState() => _BCState();
}

class _BCState extends State<BlogCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    // FIX: use widget.post (not bare 'post')
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: _hov ? AppTheme.accent.withOpacity(0.3) : AppTheme.divider),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(_hov ? 0.08 : 0.03),
              blurRadius: _hov ? 22 : 8,
              offset: Offset(0, _hov ? 6 : 1))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.network(
              widget.post.imageUrl,           // ← widget.post  ✓
              height: 172, width: double.infinity, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(height: 172, color: AppTheme.surface)),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: AppTheme.tagCyan, borderRadius: BorderRadius.circular(4)),
                  child: Text(widget.post.category,   // ← widget.post  ✓
                    style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700,
                        color: AppTheme.tagCyanText)),
                ),
                const Spacer(),
                Text('${widget.post.readMin} min read',  // ← widget.post  ✓
                  style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLight)),
              ]),
              const SizedBox(height: 11),
              Text(widget.post.title,                    // ← widget.post  ✓
                style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary, height: 1.35),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 7),
              Text(widget.post.excerpt,                  // ← widget.post  ✓
                style: GoogleFonts.inter(fontSize: 13, color: AppTheme.textSecondary, height: 1.5),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(widget.post.date,                   // ← widget.post  ✓
                  style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLight)),
                Row(children: [
                  Text('Read',
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600,
                        color: AppTheme.accent)),
                  const SizedBox(width: 3),
                  const Icon(Icons.arrow_forward_rounded, size: 12, color: AppTheme.accent),
                ]),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}