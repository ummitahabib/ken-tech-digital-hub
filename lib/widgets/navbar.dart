import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AppNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final String activeSection;
  final void Function(String section) onNavTap;

  const AppNavbar({
    super.key,
    required this.scrollController,
    required this.activeSection,
    required this.onNavTap,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  bool _scrolled = false;
  bool _mobileMenuOpen = false;

  static const _navItems = [
    'Home', 'Services', 'Work', 'About', 'Blog', 'Contact',
  ];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final s = widget.scrollController.offset > 40;
    if (s != _scrolled) setState(() => _scrolled = s);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _handleTap(String section) {
    widget.onNavTap(section);
    if (_mobileMenuOpen) setState(() => _mobileMenuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 1024;
    final isMedium = w > 700;
    final hPad = isWide ? 80.0 : (isMedium ? 40.0 : 20.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Main bar ──────────────────────────────────────────────────────
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            // Always dark — transparent only over the hero's dark bg,
            // solid dark once scrolled or mobile menu is open
            color: _scrolled || _mobileMenuOpen
                ? AppTheme.darkBg.withOpacity(0.97)
                : AppTheme.darkBg.withOpacity(0.6),
            boxShadow: _scrolled
                ? [BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 24,
                    offset: const Offset(0, 2),
                  )]
                : [],
            border: Border(
              bottom: BorderSide(
                color: _scrolled
                    ? AppTheme.darkCardBorder.withOpacity(0.6)
                    : Colors.transparent,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Logo (always visible, no overflow) ──────────────────
              GestureDetector(
                onTap: () => _handleTap('Home'),
                child: _Logo(compact: !isMedium),
              ),

              // ── Nav items (desktop) ──────────────────────────────────
              if (isWide) ...[
                const Spacer(),
                ..._navItems.map((label) => _NavItem(
                      label: label,
                      isActive: widget.activeSection == label,
                      onTap: () => _handleTap(label),
                    )),
                const SizedBox(width: 24),
                _CtaButton(
                  label: 'Get Free Consultation',
                  onTap: () => _handleTap('Contact'),
                ),
              ] else ...[
                const Spacer(),
                // Hamburger / close
                GestureDetector(
                  onTap: () => setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _mobileMenuOpen ? Icons.close_rounded : Icons.menu_rounded,
                      key: ValueKey(_mobileMenuOpen),
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // ── Mobile drawer ─────────────────────────────────────────────────
        if (!isWide && _mobileMenuOpen)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.darkBg.withOpacity(0.98),
              border: Border(
                bottom: BorderSide(color: AppTheme.darkCardBorder.withOpacity(0.5)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: AppTheme.darkCardBorder.withOpacity(0.4), height: 1),
                const SizedBox(height: 8),
                ..._navItems.map((label) => _MobileNavItem(
                      label: label,
                      isActive: widget.activeSection == label,
                      onTap: () => _handleTap(label),
                    )),
                const SizedBox(height: 16),
                _CtaButton(
                  label: 'Get Free Consultation',
                  onTap: () => _handleTap('Contact'),
                  fullWidth: true,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ─── Logo ─────────────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  final bool compact;
  const _Logo({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // KD badge
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accent, AppTheme.accentAlt],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Center(
            child: Text(
              'KD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        if (!compact) ...[
          const SizedBox(width: 10),
          // Two-part logo text — overflow safe
          RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Ken Digital',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: ' Tech Hub',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Desktop Nav Item ─────────────────────────────────────────────────────────
class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = _hovered || widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: highlighted
                      ? AppTheme.accent
                      : Colors.white.withOpacity(0.8),
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 18 : 0,
                decoration: BoxDecoration(
                  color: AppTheme.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Mobile Nav Item ──────────────────────────────────────────────────────────
class _MobileNavItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.darkCardBorder.withOpacity(0.35),
            ),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 3,
              height: 18,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isActive ? AppTheme.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppTheme.accent : Colors.white.withOpacity(0.8),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: isActive
                  ? AppTheme.accent
                  : Colors.white.withOpacity(0.25),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── CTA Button ───────────────────────────────────────────────────────────────
class _CtaButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _CtaButton({
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hovered
                  ? [AppTheme.accentAlt, AppTheme.accent]
                  : [AppTheme.accent, AppTheme.accentAlt],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [BoxShadow(
                    color: AppTheme.accent.withOpacity(0.45),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  )]
                : [],
          ),
          child: Text(
            widget.label,
            textAlign: widget.fullWidth ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}