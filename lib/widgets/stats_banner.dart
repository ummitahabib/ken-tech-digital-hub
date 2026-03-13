// ─── Stats Banner (Animated + Responsive) ────────────────────────────────────
// Fix: replaced GridView fixed mainAxisExtent with intrinsic-height Wrap rows.
// Responsive across all screen sizes. All animations preserved.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ken_tech_digital_hub/models/app_data.dart';
import 'package:ken_tech_digital_hub/theme/app_theme.dart';

// ─── Single Stat Tile ─────────────────────────────────────────────────────────

class _AnimatedStatTile extends StatefulWidget {
  final Map<String, dynamic> stat;
  final int index;
  final int cols;
  final bool showRight;
  final bool showBottom;

  const _AnimatedStatTile({
    required this.stat,
    required this.index,
    required this.cols,
    required this.showRight,
    required this.showBottom,
  });

  @override
  State<_AnimatedStatTile> createState() => _AnimatedStatTileState();
}

class _AnimatedStatTileState extends State<_AnimatedStatTile>
    with TickerProviderStateMixin {
  late final AnimationController _dropCtrl;
  late final AnimationController _countCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _hoverCtrl;

  late final Animation<double> _fade;
  late final Animation<Offset> _drop;
  late final Animation<double> _dropScale;
  late final Animation<double> _count;
  late final Animation<double> _glow;
  late final Animation<double> _hoverScale;

  late final double _numericEnd;
  late final String _prefix;
  late final String _suffix;

  @override
  void initState() {
    super.initState();
    _parseValue();

    _dropCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _countCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _hoverCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _drop = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _dropCtrl, curve: Curves.easeOutBack));

    _fade = CurvedAnimation(parent: _dropCtrl, curve: Curves.easeOut);

    _dropScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _dropCtrl, curve: Curves.easeOutBack),
    );

    _count = CurvedAnimation(parent: _countCtrl, curve: Curves.easeOutCubic);

    _glow = Tween<double>(begin: 0.4, end: 1.0).animate(_glowCtrl);

    _hoverScale = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _hoverCtrl, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: 180 * widget.index), () {
      if (!mounted) return;
      _dropCtrl.forward().then((_) {
        if (mounted) _countCtrl.forward();
      });
    });
  }

  @override
  void dispose() {
    _dropCtrl.dispose();
    _countCtrl.dispose();
    _glowCtrl.dispose();
    _hoverCtrl.dispose();
    super.dispose();
  }

  void _parseValue() {
    final raw = widget.stat['value'] as String;
    _prefix = RegExp(r'^[^\d]*').firstMatch(raw)?.group(0) ?? '';
    _suffix = RegExp(r'[^\d]+$').firstMatch(raw)?.group(0) ?? '';
    final numMatch = RegExp(r'[\d.]+').firstMatch(raw);
    _numericEnd =
        numMatch != null ? double.tryParse(numMatch.group(0)!) ?? 0 : 0;
  }

  String _buildDisplayValue(double progress) {
    if (_numericEnd == 0) return widget.stat['value'] as String;
    final current = _numericEnd * progress;
    final display = current == current.roundToDouble()
        ? current.toInt().toString()
        : current.toStringAsFixed(1);
    return '$_prefix$display$_suffix';
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    // Responsive font sizing
    final valueFontSize = screenW < 360 ? 24.0 : screenW < 480 ? 28.0 : 34.0;
    final labelFontSize = screenW < 360 ? 11.0 : 13.0;
    final iconSize = screenW < 360 ? 18.0 : 22.0;

    return MouseRegion(
      onEnter: (_) => _hoverCtrl.forward(),
      onExit: (_) => _hoverCtrl.reverse(),
      child: ScaleTransition(
        scale: _hoverScale,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: widget.showRight
                  ? BorderSide(color: Colors.white.withOpacity(0.07))
                  : BorderSide.none,
              bottom: widget.showBottom
                  ? BorderSide(color: Colors.white.withOpacity(0.07))
                  : BorderSide.none,
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: screenW < 480 ? 20 : 28,
            horizontal: 8,
          ),
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _drop,
              child: ScaleTransition(
                scale: _dropScale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Pulsing icon
                    AnimatedBuilder(
                      animation: _glowCtrl,
                      builder: (_, child) => Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accent
                                  .withOpacity(0.15 + 0.20 * _glow.value),
                              blurRadius: 18 + 10 * _glow.value,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: child,
                      ),
                      child: Icon(
                        widget.stat['icon'] as IconData,
                        size: iconSize,
                        color: AppTheme.accent,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Counting number
                    AnimatedBuilder(
                      animation: _count,
                      builder: (_, __) => Text(
                        _buildDisplayValue(_count.value),
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: valueFontSize,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Label
                    Text(
                      widget.stat['label'] as String,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: labelFontSize,
                        color: Colors.white.withOpacity(0.45),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Stats Banner ─────────────────────────────────────────────────────────────

class StatsBanner extends StatelessWidget {
  const StatsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final wide = screenW > 700;
    final hPad = wide ? 80.0 : 24.0;
    final vPad = wide ? 60.0 : 40.0;

    return Container(
      color: AppTheme.primary,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: LayoutBuilder(builder: (_, constraints) {
        final cols = constraints.maxWidth > 680 ? 4 : 2;
        final count = AppData.stats.length;

        // Build rows manually so height is intrinsic (no overflow)
        final rows = <Widget>[];
        for (int rowStart = 0; rowStart < count; rowStart += cols) {
          final rowItems = <Widget>[];
          final rowEnd = (rowStart + cols).clamp(0, count);
          final isLastRow = rowEnd >= count;

          for (int i = rowStart; i < rowEnd; i++) {
            final isLastInRow = (i == rowEnd - 1);
            rowItems.add(
              Expanded(
                child: _AnimatedStatTile(
                  stat: AppData.stats[i],
                  index: i,
                  cols: cols,
                  showRight: !isLastInRow,
                  showBottom: !isLastRow,
                ),
              ),
            );
          }

          // Pad incomplete last row so items keep correct width
          if (rowEnd - rowStart < cols) {
            rowItems.add(Expanded(
              flex: cols - (rowEnd - rowStart),
              child: const SizedBox.shrink(),
            ));
          }

          rows.add(IntrinsicHeight(child: Row(children: rowItems)));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: rows,
        );
      }),
    );
  }
}