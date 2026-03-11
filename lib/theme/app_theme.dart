import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary        = Color(0xFF0A0E1A);
  static const Color accent         = Color(0xFF00D4FF);
  static const Color accentAlt      = Color(0xFF7B2FFF);
  static const Color accentGold     = Color(0xFFFFB800);
  static const Color background     = Color(0xFFFFFFFF);
  static const Color surface        = Color(0xFFF4F6FA);
  static const Color surfaceCard    = Color(0xFFFFFFFF);
  static const Color darkBg         = Color(0xFF060B18);
  static const Color darkCard       = Color(0xFF0F1629);
  static const Color darkCardBorder = Color(0xFF1E2A45);
  static const Color textPrimary    = Color(0xFF0A0E1A);
  static const Color textSecondary  = Color(0xFF5A6478);
  static const Color textLight      = Color(0xFFADB5C7);
  static const Color divider        = Color(0xFFE8ECF4);
  static const Color tagCyan        = Color(0xFFE0FAFE);
  static const Color tagCyanText    = Color(0xFF006B80);
  static const Color tagPurple      = Color(0xFFF0E8FF);
  static const Color tagPurpleText  = Color(0xFF5B21B6);
  static const Color starColor      = Color(0xFFFFB800);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.light),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.spaceGroteskTextTheme().copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(fontSize: 60, fontWeight: FontWeight.w700, color: textPrimary, height: 1.05, letterSpacing: -2),
        displayMedium: GoogleFonts.spaceGrotesk(fontSize: 44, fontWeight: FontWeight.w700, color: textPrimary, height: 1.1, letterSpacing: -1.5),
        displaySmall: GoogleFonts.spaceGrotesk(fontSize: 34, fontWeight: FontWeight.w700, color: textPrimary, height: 1.2),
        headlineLarge: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700, color: textPrimary),
        headlineMedium: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w600, color: textPrimary),
        headlineSmall: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: textSecondary, height: 1.7),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: textSecondary, height: 1.6),
        bodySmall: GoogleFonts.inter(fontSize: 12, color: textLight),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary),
      ),
    );
  }
}
