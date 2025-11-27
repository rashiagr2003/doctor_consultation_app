import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double responsiveFontSize(BuildContext context, double baseSize) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) {
      return baseSize;
    } else if (width < tabletBreakpoint) {
      return baseSize * 1.1;
    } else {
      return baseSize * 1.2;
    }
  }

  static double responsivePadding(BuildContext context, double basePadding) {
    if (isMobile(context)) {
      return basePadding;
    } else if (isTablet(context)) {
      return basePadding * 1.5;
    } else {
      return basePadding * 2;
    }
  }

  static double responsiveSpacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) {
      return baseSpacing;
    } else if (isTablet(context)) {
      return baseSpacing * 1.3;
    } else {
      return baseSpacing * 1.5;
    }
  }

  static double getCardWidth(BuildContext context) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) {
      return width * 0.9;
    } else if (width < tabletBreakpoint) {
      return 500;
    } else {
      return 600;
    }
  }

  static int getGridCrossAxisCount(BuildContext context) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) {
      return 1;
    } else if (width < tabletBreakpoint) {
      return 2;
    } else {
      return 3;
    }
  }

  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }
}
