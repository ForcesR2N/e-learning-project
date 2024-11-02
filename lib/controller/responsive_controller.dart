// responsive_layout.dart
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= 768) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

// Extension methods for consistent spacing and sizing
extension ResponsiveSpacing on BuildContext {
  double get spacing => Responsive.isTablet(this) ? 16.0 : 12.0;
  double get radius => Responsive.isTablet(this) ? 16.0 : 12.0;
  double get fontSize => Responsive.isTablet(this) ? 16.0 : 14.0;
  double get iconSize => Responsive.isTablet(this) ? 24.0 : 20.0;
}
