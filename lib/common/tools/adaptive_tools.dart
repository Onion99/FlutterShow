import 'package:flutter/material.dart';

enum DisplayType {
  desktop,
  tablet,
  mobile,
}

const kLimitWidthScreen = 1400.0;
const _desktopBreakpointWstH = 1024.0; // Width is smaller than Height
const _desktopBreakpointWgtH = 700.0; // Width is greater than Height
