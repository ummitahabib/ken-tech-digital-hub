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

  static const _navItems = [
    'Home',
    'Services',
    'Work',
    'About',
    'Blog',
    'Contact',
  ];

  void _handleTap(String section) {
    widget.onNavTap(section);
    if (_mobileMenuOpen) setState(() => _mobileMenuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;
    final hPad = isWide ? 80.0 : 20.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Main bar ──────────────────────────────────────────────────────
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: (_scrolled || _mobileMenuOpen)
                ? AppTheme.darkBg.withOpacity(0.97)
                : Colors.transparent,
            boxShadow: _scrolled
                ? [BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 4),
                  )]
                : [],
            border: (_scrolled || _mobileMenuOpen)
                ? Border(
                    bottom: BorderSide(
                      color: AppTheme.darkCardBorder.withOpacity(0.5),
                      width: 1,
                    ),
                  )
                : const Border(bottom: BorderSide(color: Colors.transparent)),
          ),
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 18),
          child: Row(
            children: [
              // Logo — tapping scrolls to top
              GestureDetector(
                onTap: () => _handleTap('Home'),
                child: const _Logo(),
              ),
              const Spacer(),
              if (isWide) ...[
                ..._navItems.map(
                  (label) => _NavItem(
                    label: label,
                    isActive: widget.activeSection == label,
                    onTap: () => _handleTap(label),
                  ),
                ),
                const SizedBox(width: 28),
                _CtaButton(
                  label: 'Get Free Consultation',
                  onTap: () => _handleTap('Contact'),
                ),
              ] else
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _mobileMenuOpen ? Icons.close_rounded : Icons.menu_rounded,
                      key: ValueKey(_mobileMenuOpen),
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  onPressed: () => setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                ),
            ],
          ),
        ),

        // ── Mobile drawer ─────────────────────────────────────────────────
        if (!isWide && _mobileMenuOpen)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.darkBg.withOpacity(0.98),
              border: Border(
                bottom: BorderSide(color: AppTheme.darkCardBorder.withOpacity(0.6)),
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
                const Divider(color: AppTheme.darkCardBorder, height: 1),
                const SizedBox(height: 16),
                ..._navItems.map(
                  (label) => _MobileNavItem(
                    label: label,
                    isActive: widget.activeSection == label,
                    onTap: () => _handleTap(label),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: _CtaButton(
                    label: 'Get Free Consultation',
                    onTap: () => _handleTap('Contact'),
                  ),
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
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accent, AppTheme.accentAlt],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'KD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Ken Digital',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: ' Tech Hub',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.accent,
                ),
              ),
            ],
          ),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
              color: highlighted ? AppTheme.accent : Colors.white.withOpacity(0.75),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.label),
                const SizedBox(height: 3),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: widget.isActive ? 20 : 0,
                  decoration: BoxDecoration(
                    color: AppTheme.accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
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
            bottom: BorderSide(color: AppTheme.darkCardBorder.withOpacity(0.4)),
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
              color: isActive ? AppTheme.accent : Colors.white.withOpacity(0.3),
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

  const _CtaButton({required this.label, required this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
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
