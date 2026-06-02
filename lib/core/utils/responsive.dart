import 'package:flutter/material.dart';

/// Breakpoints and responsive helpers for the app.
///
/// Mobile:  < 600
/// Tablet:  600 - 1023
/// Desktop: >= 1024
class Responsive {
  Responsive._();

  // ─── Breakpoints ────────────────────────────────────────────
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  // ─── Device Type Checks ─────────────────────────────────────
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  /// Returns the screen width.
  static double width(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  /// Returns the screen height.
  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  // ─── Grid Helpers ───────────────────────────────────────────

  /// Calculates grid cross-axis count based on screen width.
  static int gridCrossAxisCount(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 1200) return 5;
    if (w >= tabletBreakpoint) return 4;
    if (w >= mobileBreakpoint) return 3;
    return 2;
  }

  /// Returns the optimal child aspect ratio for the product grid.
  static double gridChildAspectRatio(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 0.68;
    if (w >= mobileBreakpoint) return 0.65;
    return 0.63;
  }

  // ─── Spacing / Padding ─────────────────────────────────────

  /// Horizontal padding that adapts to the screen.
  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 32;
    if (w >= mobileBreakpoint) return 24;
    return 16;
  }

  /// Content padding (used in details / settings pages).
  static double contentPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 40;
    if (w >= mobileBreakpoint) return 32;
    return 24;
  }

  /// Max width for content areas on wide screens (keeps content readable).
  static double maxContentWidth(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 720;
    if (w >= mobileBreakpoint) return 560;
    return double.infinity;
  }

  // ─── Details Screen Helpers ─────────────────────────────────

  /// Image height fraction for the details screen.
  static double detailsImageHeightFraction(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 0.38;
    if (w >= mobileBreakpoint) return 0.40;
    return 0.45;
  }

  // ─── Navigation Helpers ─────────────────────────────────────

  /// Whether to use a side navigation rail instead of bottom nav.
  static bool useNavigationRail(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobileBreakpoint;

  // ─── Typography Scale Factor ────────────────────────────────

  /// Returns a scale factor for font sizes on wider screens.
  static double fontScale(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 1.1;
    if (w >= mobileBreakpoint) return 1.05;
    return 1.0;
  }

  // ─── Responsive Value Picker ────────────────────────────────

  /// Returns the appropriate value based on the screen size.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return desktop ?? tablet ?? mobile;
    if (w >= mobileBreakpoint) return tablet ?? mobile;
    return mobile;
  }
}
