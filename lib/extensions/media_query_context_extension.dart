import 'dart:math' as math;

import 'package:flutter/material.dart';

const double kMaxScreenWidth = 700;
const double kLargeScreenWidth = 960;
const double kMediumScreenHeight = 720;
const double kLargeScreenHeight = 960;

extension MediaQueryDataExtension on MediaQueryData {
  bool get isLargeScreen => size.width > kLargeScreenWidth;

  bool get isTallScreen => size.height > kMediumScreenHeight;

  double get fullSizeImageScreenWidth => math.min(size.width, kLargeScreenWidth) / 1.3;

  double get shortestSide => math.min(size.width, size.height);

  double get singleFilterBottomSheetHeight =>
      isTallScreen ? kMediumScreenHeight / 2 : math.min(size.height, kMediumScreenHeight / 2.5) - 32;

  double get filterBottomSheetHeight =>
      isTallScreen ? kLargeScreenHeight / 2 : math.min(size.height, kLargeScreenHeight / 2.5) - 32;
}
