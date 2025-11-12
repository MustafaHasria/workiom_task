import 'package:flutter/widgets.dart';

// Single breakpoint approach: mobile < 600, desktop >= 600
const double kDesktopMinWidth = 600;

enum AppSizeClass { mobile, desktop }

// Backward-compatible API (still available if used elsewhere)
AppSizeClass sizeClassFor(BoxConstraints constraints) =>
    constraints.maxWidth < kDesktopMinWidth ? AppSizeClass.mobile : AppSizeClass.desktop;

// Simpler bool helpers
bool isDesktopLayout(BoxConstraints constraints) => constraints.maxWidth >= kDesktopMinWidth;
bool isMobileLayout(BoxConstraints constraints) => constraints.maxWidth < kDesktopMinWidth;

// Optional context-based helpers
bool isDesktopContext(BuildContext context) => MediaQuery.sizeOf(context).width >= kDesktopMinWidth;
bool isMobileContext(BuildContext context) => MediaQuery.sizeOf(context).width < kDesktopMinWidth;
