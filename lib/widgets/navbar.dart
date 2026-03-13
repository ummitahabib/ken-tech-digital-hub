import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AppNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final String activeSection;
  final void Function(String) onNavTap;
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
  bool _menuOpen = false;
  static const _items = ['Home', 'Services', 'Work', 'About', 'Blog', 'Contact'];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_listen);
  }

  void _listen() {
    final s = widget.scrollController.offset > 20;
    if (s != _scrolled) setState(() => _scrolled = s);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_listen);
    super.dispose();
  }

  void _tap(String s) {
    widget.onNavTap(s);
    if (_menuOpen) setState(() => _menuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final wide = w >= 900;
    final med  = w > 600;
    final hPad = wide ? 72.0 : (med ? 36.0 : 18.0);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        decoration: BoxDecoration(
          color: _menuOpen
              ? AppTheme.background
              : AppTheme.background.withOpacity(_scrolled ? 0.98 : 1.0),
          border: Border(
            bottom: BorderSide(
              color: _scrolled ? AppTheme.divider : AppTheme.stroke,
              width: 1,
            ),
          ),
          boxShadow: _scrolled
              ? [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 16, offset: const Offset(0, 2))]
              : [],
        ),
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _tap('Home'),
              child: _Logo(compact: !med),
            ),
            if (wide) ...[
              const Spacer(),
              ..._items.map((l) => _NavItem(
                label: l,
                active: widget.activeSection == l,
                onTap: () => _tap(l),
              )),
              const SizedBox(width: 20),
              _CtaButton(label: 'Free Consultation', onTap: () => _tap('Contact')),
            ] else ...[
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _menuOpen = !_menuOpen),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _menuOpen ? Icons.close_rounded : Icons.menu_rounded,
                    key: ValueKey(_menuOpen),
                    color: AppTheme.ink,
                    size: 24,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      // Mobile drawer
      AnimatedSize(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubic,
        child: !wide && _menuOpen
            ? Container(
                width: double.infinity,
                color: AppTheme.background,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Divider(color: AppTheme.divider, height: 1),
                  const SizedBox(height: 4),
                  ..._items.map((l) => _MobileNavItem(
                    label: l,
                    active: widget.activeSection == l,
                    onTap: () => _tap(l),
                  )),
                  const SizedBox(height: 16),
                  _CtaButton(label: 'Free Consultation', onTap: () => _tap('Contact'), fullWidth: true),
                ]),
              )
            : const SizedBox.shrink(),
      ),
    ]);
  }
}

// ── Logo ──────────────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  final bool compact;
  const _Logo({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          'assets/images/logo.jpg',
          width: 36, height: 36, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 36, height: 36,
            decoration: BoxDecoration(gradient: AppTheme.brandGradient, borderRadius: BorderRadius.circular(7)),
            child: const Center(child: Text('KD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13))),
          ),
        ),
      ),
      if (!compact) ...[
        const SizedBox(width: 9),
        RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(children: [
            TextSpan(
              text: 'Ken Digital ',
              style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.ink),
            ),
            TextSpan(
              text: 'TechHub',
              style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.green),
            ),
          ]),
        ),
      ],
    ]);
  }
}

// ── Desktop nav item ──────────────────────────────────────────────────────────
class _NavItem extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.active, required this.onTap});
  @override State<_NavItem> createState() => _NavItemState();
}
class _NavItemState extends State<_NavItem> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) {
    final hi = _hov || widget.active;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: widget.active ? FontWeight.w600 : FontWeight.w400,
                color: hi ? AppTheme.green : AppTheme.inkMid,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: widget.active ? 14 : 0,
              decoration: BoxDecoration(color: AppTheme.green, borderRadius: BorderRadius.circular(2)),
            ),
          ]),
        ),
      ),
    );
  }
}

// ── Mobile nav item ───────────────────────────────────────────────────────────
class _MobileNavItem extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _MobileNavItem({required this.label, required this.active, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 2),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppTheme.divider.withOpacity(0.7))),
        ),
        child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 3, height: 16,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: active ? AppTheme.green : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(label, style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active ? AppTheme.green : AppTheme.ink,
          )),
          const Spacer(),
          Icon(Icons.chevron_right_rounded, size: 16,
              color: active ? AppTheme.green : AppTheme.inkFaint),
        ]),
      ),
    );
  }
}

// ── CTA Button ────────────────────────────────────────────────────────────────
class _CtaButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;
  const _CtaButton({required this.label, required this.onTap, this.fullWidth = false});
  @override State<_CtaButton> createState() => _CtaButtonState();
}
class _CtaButtonState extends State<_CtaButton> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: _hov ? AppTheme.greenDark : AppTheme.green,
            borderRadius: BorderRadius.circular(7),
            boxShadow: _hov
                ? [BoxShadow(color: AppTheme.green.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))]
                : [],
          ),
          child: Text(
            widget.label,
            textAlign: widget.fullWidth ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}