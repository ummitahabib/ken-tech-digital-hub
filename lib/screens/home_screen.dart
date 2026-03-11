import 'package:flutter/material.dart';
import 'package:ken_tech_digital_hub/theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/sections.dart';
import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/sections.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scroll = ScrollController();

  // ── Section keys ─────────────────────────────────────────────────────────
  final GlobalKey homeKey      = GlobalKey();
  final GlobalKey servicesKey  = GlobalKey();
  final GlobalKey workKey      = GlobalKey();
  final GlobalKey aboutKey     = GlobalKey();
  final GlobalKey teamKey      = GlobalKey();
  final GlobalKey blogKey      = GlobalKey();
  final GlobalKey contactKey   = GlobalKey();

  // Active section tracking
  String _activeSection = 'Home';

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Determine which section is currently in view
    final offset = _scroll.offset;
    String newActive = 'Home';

    final checks = [
      ('Home',     homeKey),
      ('Services', servicesKey),
      ('Work',     workKey),
      ('About',    aboutKey),
      ('Team',     teamKey),
      ('Blog',     blogKey),
      ('Contact',  contactKey),
    ];

    for (final entry in checks) {
      final ctx = entry.$2.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      // Section is considered "active" when its top is within upper half of screen
      final sectionTop = offset + pos.dy - 74; // subtract navbar height
      if (sectionTop <= offset + 200) {
        newActive = entry.$1;
      }
    }

    if (newActive != _activeSection) {
      setState(() => _activeSection = newActive);
    }
  }

  /// Scrolls smoothly to the section identified by [key].
  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg, // ← matches hero background, kills white flash
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scroll,
            child: Column(
              children: [
                // ── Hero (handles navbar offset via its own top padding) ──
                HeroSection(key: homeKey, onCtaPressed: () => _scrollTo(contactKey)),

                // ── Partners ─────────────────────────────────────────────
                const PartnersStrip(),

                // ── Services ─────────────────────────────────────────────
                ServicesSection(key: servicesKey),

                // ── Stats ─────────────────────────────────────────────────
                const StatsBanner(),

                // ── Work ─────────────────────────────────────────────────
                WorkSection(key: workKey),

                // ── About ─────────────────────────────────────────────────
                AboutSection(key: aboutKey),

                // ── Team ─────────────────────────────────────────────────
                TeamSection(key: teamKey),

                // ── Testimonials ──────────────────────────────────────────
                const TestimonialsSection(),

                // ── FAQ ───────────────────────────────────────────────────
                const FaqSection(),

                // ── Blog ─────────────────────────────────────────────────
                BlogSection(key: blogKey),

                // ── CTA / Contact ─────────────────────────────────────────
                CtaBanner(key: contactKey),

                // ── Footer ───────────────────────────────────────────────
                const FooterSection(),
              ],
            ),
          ),

          // ── Sticky Navbar ─────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavbar(
              scrollController: _scroll,
              activeSection: _activeSection,
              onNavTap: (section) {
                switch (section) {
                  case 'Home':     _scrollTo(homeKey);     break;
                  case 'Services': _scrollTo(servicesKey); break;
                  case 'Work':     _scrollTo(workKey);     break;
                  case 'About':    _scrollTo(aboutKey);    break;
                  case 'Team':     _scrollTo(teamKey);     break;
                  case 'Blog':     _scrollTo(blogKey);     break;
                  case 'Contact':  _scrollTo(contactKey);  break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}