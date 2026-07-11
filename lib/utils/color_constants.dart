import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../main.dart';

/// SalaryUncle design system.
///
/// Brand direction: SalaryUncle's real identity — money-green primary with a
/// deep navy secondary, taken straight from the salaryuncle.com logo
/// ("SALARY" in green #509540, "UNCLE" in navy #0C2340). Clean white surfaces
/// with soft green-tinted cards.
///
/// The legacy int-based tokens (used as `Color(ColorConstants.primaryColor)`)
/// are preserved so existing screens keep compiling, while richer `Color`
/// tokens and gradients are added for the refreshed UI.
class ColorConstants {
  // ---------------------------------------------------------------------------
  // Legacy int tokens (kept for `Color(ColorConstants.xxx)` call-sites)
  // ---------------------------------------------------------------------------
  static const primaryColor = 0xFF509540; // SalaryUncle green
  static const primaryColorDark = 0xFF3D7A30;

  static const contrainerColorLight = 0xFFFFFFFF;
  static const contrainerColorDark = 0xFF17202E;

  static const textColorLight = 0xFF0C2340;
  static const textColorDark = 0xFFFFFFFF;

  static const secondaryColor = 0xFF0C2340; // navy (buttons / CTAs)
  static const tertiaryColor = 0xFF3D7A30; // deep green accent

  // ---------------------------------------------------------------------------
  // Rich color tokens (preferred for new code)
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF509540); // SalaryUncle green
  static const Color primaryDeep = Color(0xFF3D7A30); // deeper green
  static const Color primaryDarker = Color(0xFF2D5A22);
  static const Color navy = Color(0xFF0C2340); // brand navy (from "UNCLE")
  static const Color accent = Color(0xFF6DD05A); // fresh light green
  static const Color accentSoft = Color(0xFF7BC96F);
  static const Color gold = Color(0xFFD4A017); // rich gold (dashboard accent)
  static const Color goldLight = Color(0xFFE3B93A);
  static const Color goldText = Color(0xFFF3CE6B); // gold text on dark cards
  static const Color goldSoft = Color(0xFFFBF3DC);
  static const Color success = Color(0xFF12B76A);
  static const Color danger = Color(0xFFC0392B);
  static const Color warning = Color(0xFFF79009);

  // Dashboard deep-green tokens (from the reference mockup)
  static const Color greenDeep = Color(0xFF0B3D2E);
  static const Color green2 = Color(0xFF14523E);
  static const Color greenSoft = Color(0xFFE8F3EE);

  /// Deep-green loan-card gradient (matches the reference dashboard).
  static const LinearGradient loanCardGradient = LinearGradient(
    colors: [Color(0xFF14523E), Color(0xFF0B3D2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gold CTA gradient (Repay button / FAB).
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFE3B93A), Color(0xFFD4A017)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color ink = Color(0xFF0C2340); // headings (brand navy)
  static const Color body = Color(0xFF33415A); // body text
  static const Color muted = Color(0xFF6B7686); // captions / hints
  static const Color border = Color(0xFFDDE7DA);

  static const Color scaffoldLight = Color(0xFFF5FAF3);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardTintLight = Color(0xFFEEF7EB);

  static const Color scaffoldDark = Color(0xFF0B1220);
  static const Color surfaceDark = Color(0xFF17202E);
  static const Color cardTintDark = Color(0xFF1E2A22);

  /// Primary brand gradient (app bars, hero sections, primary CTAs).
  /// Green → navy, echoing the SalaryUncle logo.
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF509540), Color(0xFF0C2340)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Soft accent gradient (badges, progress, secondary highlights).
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF6DD05A), Color(0xFF3D7A30)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Soft card shadow used across cards / sheets.
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: const Color(0xFF509540).withOpacity(0.10),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  // ---------------------------------------------------------------------------
  // Themes
  // ---------------------------------------------------------------------------
  static ThemeData themeLight = ThemeData(
    useMaterial3: false,
    fontFamily: 'Roboto',
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldLight,
    highlightColor: surfaceLight,
    shadowColor: const Color(0x14509540),
    dividerColor: border,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: surfaceLight,
      error: danger,
    ),
    textTheme: TextTheme(
      /// big screen headings
      headlineLarge: TextStyle(
        color: ink,
        fontSize: 18.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),

      /// heading For General
      headlineMedium: TextStyle(
        fontSize: 15.5.sp,
        color: muted,
        fontWeight: FontWeight.w500,
      ),

      /// Sub heading For General
      titleSmall: TextStyle(
        letterSpacing: 0.2.sp,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: ink,
      ),

      /// TextField Text
      titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: ink),

      /// hint text
      titleLarge: TextStyle(
        letterSpacing: 0.sp,
        fontSize: 16.sp,
        color: muted,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primary,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
    ),
  );

  static ThemeData themeDark = ThemeData(
    useMaterial3: false,
    fontFamily: 'Roboto',
    highlightColor: surfaceDark,
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldDark,
    shadowColor: Colors.black,
    dividerColor: const Color(0xFF2C3A5A),
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: surfaceDark,
      error: danger,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primaryDeep,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
      headlineMedium: TextStyle(
        fontSize: 15.5.sp,
        color: const Color(0XFF9AA6C0),
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        letterSpacing: 0.2.sp,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: Colors.white),
      titleLarge: TextStyle(
        letterSpacing: 0.sp,
        fontSize: 16.sp,
        color: const Color(0XFF9AA6C0),
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static getBrightColorARD(BuildContext context) {
    if ((prefs.getBool(SharedConstants.THEME) ?? false)) {
      return Brightness.light;
    } else {
      return Brightness.light;
    }
  }

  static getBrightColorIOS(BuildContext context) {
    if ((prefs.getBool(SharedConstants.THEME) ?? false)) {
      return Brightness.dark;
    } else {
      return Brightness.dark;
    }
  }
}
