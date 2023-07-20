import 'package:flutter/widgets.dart';

extension TextStyleExtension on TextStyle {
  double get lineHeight => fontSize! * height!;

  TextStyle operator +(final Color color) {
    return copyWith(color: color);
  }
}

class SimpleAACText {
  SimpleAACText._();

  // Subtitle

  static const subtitle1Style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.875,
    fontFamily: 'Antipasto',
  );

  static const subtitle2Style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: 'Antipasto',
  );

  static const subtitle3Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: 'Antipasto',
  );

  static const subtitle4Style = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.375,
    fontFamily: 'Antipasto',
  );

  // Body

  static const body1Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1,
    fontFamily: 'Antipasto',
  );

  static const body2Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    height: 1.625,
    fontFamily: 'Antipasto',
  );

  static const body3Style = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.375,
    fontFamily: 'Antipasto',
  );

  static const body4Style = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.375,
    fontFamily: 'Antipasto',
  );

  static const body5Style = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    height: 1.375,
    fontFamily: 'Antipasto',
  );

  // Caption

  static const captionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.375,
    fontFamily: 'Antipasto',
  );

  // Header

  static const h1Style = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.normal,
    height: 4.125,
    fontFamily: 'Antipasto',
  );

  static const h2Style = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.normal,
    height: 3.188,
    fontFamily: 'Antipasto',
  );

  static const h3Style = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 2.375,
    fontFamily: 'Antipasto',
  );

  static const h4Style = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    height: 1.2,
    fontFamily: 'Antipasto',
  );

  static const h5Style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.2,
    fontFamily: 'Antipasto',
  );

  static const h6Style = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.normal,
    height: 3.188,
    fontFamily: 'Antipasto',
  );

  // Button

  static const button1Style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.875,
    fontFamily: 'Antipasto',
  );

  static const button2Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.625,
    fontFamily: 'Antipasto',
  );
}
