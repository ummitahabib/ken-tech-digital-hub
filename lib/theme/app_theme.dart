import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ─── Ken Digital Tech Hub — Design Token System ──────────────────────────────
///
///  Logo source of truth:
///    Green  #2EAA4A   →  primary brand colour
///    Blue   #3D5FA8   →  secondary / accent-alt
///    White  #FFFFFF   →  base
/// ─────────────────────────────────────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color green      = Color(0xFF2EAA4A); // logo green — primary
  static const Color greenDark  = Color(0xFF1F7D34); // hover / pressed state
  static const Color greenLight = Color(0xFFDDF3E4); // icon bg tint
  static const Color blue       = Color(0xFF3D5FA8); // logo blue — secondary
  static const Color blueLight  = Color(0xFFE4EBF8); // tag bg tint
  static const Color gold       = Color(0xFFFFB800); // star / badge

  // ── Legacy aliases (used by older widgets) ────────────────────────────────
  static const Color accent         = green;
  static const Color accentAlt      = blue;
  static const Color accentGold     = gold;
  static const Color accentDark     = greenDark;
  static const Color accentLight    = greenLight;
  static const Color accentAltLight = blueLight;

  // ── Light surfaces ────────────────────────────────────────────────────────
  static const Color background  = Color(0xFFFFFFFF);
  static const Color paper       = Color(0xFFFFFFFF); // card / surface white
  static const Color paperStripe = Color(0xFFF4F8F5); // subtle alternate row
  static const Color surface     = Color(0xFFF4F8F5);
  static const Color surfaceCard = Color(0xFFFFFFFF);

  // ── Dark surfaces (hero, stats, team, FAQ, footer) ────────────────────────
  static const Color darkBg         = Color(0xFF06110A);
  static const Color darkCard       = Color(0xFF0D1F12);
  static const Color darkCardBorder = Color(0xFF1A3D22);
  static const Color darkSurface    = Color(0xFF0D1F12); // same as darkCard
  static const Color darkStroke     = Color(0xFF1A3D22); // same as darkCardBorder

  // ── Text — light mode ─────────────────────────────────────────────────────
  static const Color ink       = Color(0xFF0A1A0F); // near-black headlines
  static const Color inkMid    = Color(0xFF3D5245); // body text
  static const Color inkLight  = Color(0xFF7A9B84); // captions / labels
  static const Color inkFaint  = Color(0xFFADC4B4); // disabled / placeholder
  static const Color darkTextHi = Color(0xFFFFFFFF); // dark-bg headlines
  static const Color darkTextLo = Color(0xFFADC4B4); // dark-bg body

  // ── Legacy text aliases ───────────────────────────────────────────────────
  static const Color textPrimary   = ink;
  static const Color textSecondary = inkMid;
  static const Color textLight     = inkLight;
  static const Color primary       = ink;

  // ── Borders / dividers ────────────────────────────────────────────────────
  static const Color stroke  = Color(0xFFDDEDE3); // card border
  static const Color divider = Color(0xFFDDEDE3); // rule line

  // ── Legacy tag aliases ─────────────────────────────────────────────────────
  static const Color tagCyan       = greenLight;
  static const Color tagCyanText   = Color(0xFF1A6B35);
  static const Color tagPurple     = blueLight;
  static const Color tagPurpleText = Color(0xFF2A4A8A);
  static const Color starColor     = gold;

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient brandGradient = LinearGradient(
    colors: [green, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkBg, darkCard, darkBg],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── MaterialApp ThemeData ─────────────────────────────────────────────────
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: green, brightness: Brightness.light),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge:  GoogleFonts.dmSerifDisplay(fontSize: 60, color: ink, height: 1.05),
        displayMedium: GoogleFonts.dmSerifDisplay(fontSize: 44, color: ink, height: 1.1),
        displaySmall:  GoogleFonts.dmSerifDisplay(fontSize: 34, color: ink, height: 1.2),
        headlineLarge: GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.w700, color: ink),
        headlineMedium:GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w600, color: ink),
        headlineSmall: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w600, color: ink),
        bodyLarge:     GoogleFonts.dmSans(fontSize: 16, color: inkMid, height: 1.7),
        bodyMedium:    GoogleFonts.dmSans(fontSize: 14, color: inkMid, height: 1.6),
        bodySmall:     GoogleFonts.dmSans(fontSize: 12, color: inkLight),
        labelLarge:    GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: ink),
      ),
    );
  }
}