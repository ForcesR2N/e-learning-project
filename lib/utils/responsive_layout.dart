import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
  });

  static bool isMobile(BuildContext context) => 
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) => 
      MediaQuery.of(context).size.width >= 600;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}

extension ResponsiveSize on BuildContext {
  double get spacing => Responsive.isLandscape(this) 
      ? (Responsive.isMobile(this) ? 12.0 : 16.0)
      : (Responsive.isMobile(this) ? 16.0 : 24.0);

  double get radius => Responsive.isLandscape(this)
      ? (Responsive.isMobile(this) ? 12.0 : 15.0)
      : (Responsive.isMobile(this) ? 15.0 : 20.0);

  double get iconSize => Responsive.isLandscape(this)
      ? (Responsive.isMobile(this) ? 20.0 : 24.0)
      : (Responsive.isMobile(this) ? 24.0 : 28.0);

  double get fontSize => Responsive.isLandscape(this)
      ? (Responsive.isMobile(this) ? 14.0 : 16.0)
      : (Responsive.isMobile(this) ? 16.0 : 18.0);
}