import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/constants.dart';

extension MediaQueryDataExtension on MediaQueryData {
  bool get isPortrait => size.width < size.height;
  bool get isLandscape => size.width > size.height;

  double get shortestSide => math.min(size.width, size.height);

  double get maxContentWidth => math.min(size.width, kMaxScreenWidth);
  bool get isNarrowScreen => size.width < kMinScreenWidth;
  bool get isWideScreen => size.width > kMaxScreenWidth;

  double get maxContentWidthInset => math.max((size.width - maxContentWidth) / 2, 1);
  double get minContentWidthInset => math.max((size.width - maxContentWidth) / 4, 1);
}
