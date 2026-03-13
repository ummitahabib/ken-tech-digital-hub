import 'package:flutter/material.dart';
import 'package:ken_tech_digital_hub/widgets/stats_banner.dart';
import 'package:ken_tech_digital_hub/widgets/team_section.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/sections.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scroll = ScrollController();

  final GlobalKey homeKey     = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey workKey     = GlobalKey();
  final GlobalKey aboutKey    = GlobalKey();
  final GlobalKey teamKey     = GlobalKey();
  final GlobalKey blogKey     = GlobalKey();
  final GlobalKey contactKey  = GlobalKey();

  String _active = 'Home';

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
    final offset = _scroll.offset;
    String next = 'Home';
    for (final e in [
      ('Home', homeKey), ('Services', servicesKey), ('Work', workKey),
      ('About', aboutKey), ('Team', teamKey), ('Blog', blogKey), ('Contact', contactKey),
    ]) {
      final ctx = e.$2.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final top = offset + box.localToGlobal(Offset.zero).dy - 74;
      if (top <= offset + 200) next = e.$1;
    }
    if (next != _active) setState(() => _active = next);
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx,
      duration: const Duration(milliseconds: 640),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(children: [
        SingleChildScrollView(
          controller: _scroll,
          child: Column(children: [
            HeroSection(key: homeKey, onCtaPressed: () => _scrollTo(contactKey)),
            const PartnersStrip(),
            ServicesSection(key: servicesKey),
            const StatsBanner(),
            WorkSection(key: workKey),
            AboutSection(key: aboutKey),
            TeamSection(key: teamKey),
            const TestimonialsSection(),
            const FaqSection(),
            BlogSection(key: blogKey),
            CtaBanner(key: contactKey),
            const FooterSection(),
          ]),
        ),
        Positioned(top: 0, left: 0, right: 0,
          child: AppNavbar(
            scrollController: _scroll,
            activeSection: _active,
            onNavTap: (s) {
              switch (s) {
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
      ]),
    );
  }
}