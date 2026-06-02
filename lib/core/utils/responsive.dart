import 'package:flutter/material.dart';

// Mobile:  < 600
// Tablet:  600 - 1023
// Desktop: >= 1024

class Responsive {
  Responsive._();

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static int gridCrossAxisCount(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 1200) return 5;
    if (w >= tabletBreakpoint) return 4;
    if (w >= mobileBreakpoint) return 3;
    return 2;
  }

  static double gridChildAspectRatio(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 0.68;
    if (w >= mobileBreakpoint) return 0.65;
    return 0.63;
  }

  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 32;
    if (w >= mobileBreakpoint) return 24;
    return 16;
  }

  static double contentPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 40;
    if (w >= mobileBreakpoint) return 32;
    return 24;
  }

  static double maxContentWidth(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 720;
    if (w >= mobileBreakpoint) return 560;
    return double.infinity;
  }

  static double detailsImageHeightFraction(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 0.38;
    if (w >= mobileBreakpoint) return 0.40;
    return 0.45;
  }

  static bool useNavigationRail(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobileBreakpoint;

  static double fontScale(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= tabletBreakpoint) return 1.1;
    if (w >= mobileBreakpoint) return 1.05;
    return 1.0;
  }

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
