



import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:responsive_builder/responsive_builder.dart';

DeviceScreenType getDeviceType(Size size, [ScreenBreakpoints? breakpoint]) {
  double deviceWidth = size.shortestSide;

  if (kIsWeb) {
    deviceWidth = size.width;
  }

  // Replaces the defaults with the user defined definitions
  if (breakpoint != null) {
    if (deviceWidth > breakpoint.desktop) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth > breakpoint.tablet) {
      return DeviceScreenType.tablet;
    }

    if (deviceWidth < breakpoint.watch) {
      return DeviceScreenType.watch;
    }
  } else {
    // If no user defined definitions are passed through use the defaults
    if (deviceWidth >= ResponsiveSizingConfig.instance.breakpoints.desktop) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth >= ResponsiveSizingConfig.instance.breakpoints.tablet) {
      return DeviceScreenType.tablet;
    }

    if (deviceWidth < ResponsiveSizingConfig.instance.breakpoints.watch) {
      return DeviceScreenType.watch;
    }
  }

  return DeviceScreenType.mobile;
}

enum DeviceScreenType {
  @Deprecated('Use lowercase version')
  Mobile,
  @Deprecated('Use lowercase version')
  Tablet,
  @Deprecated('Use lowercase version')
  Desktop,
  @Deprecated('Use lowercase version')
  Watch,
  mobile,
  tablet,
  desktop,
  watch
}

class ScreenBreakpoints {
  final double watch;
  final double tablet;
  final double desktop;

  const ScreenBreakpoints({
    required this.desktop,
    required this.tablet,
    required this.watch,
  });

  @override
  String toString() {
    return "Desktop: $desktop, Tablet: $tablet, Watch: $watch";
  }
}


enum RefinedSize { small, normal, large, extraLarge }