import 'package:flutter/widgets.dart';

extension TextStyleExtension on TextStyle {
  double get lineHeight => fontSize! * height!;

  TextStyle operator +(Color color) {
    return copyWith(color: color);
  }
}

class SimpleAACText {
  SimpleAACText._();

  // Subtitle

  static const subtitle1Style =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.875, fontFamily: 'Poppins');

  static const subtitle2Style =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal, height: 1.5, fontFamily: 'Poppins');

  static const subtitle3Style =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.625, fontFamily: 'Poppins');

  static const subtitle4Style =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, height: 1.375, fontFamily: 'Poppins');

  // Body

  static const body1Style =
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal, height: 1.625, fontFamily: 'Poppins');

  static const body2Style = TextStyle(fontSize: 16, fontWeight: FontWeight.w300, height: 1.625, fontFamily: 'Poppins');

  static const body3Style =
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.375, fontFamily: 'Poppins');

  static const body4Style = TextStyle(fontSize: 14, fontWeight: FontWeight.w300, height: 1.375, fontFamily: 'Poppins');

  static const body5Style =
      TextStyle(fontSize: 13, fontWeight: FontWeight.normal, height: 1.375, fontFamily: 'Poppins');

  // Caption

  static const captionStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.normal, height: 1.375, fontFamily: 'Poppins');

  // Header

  static const h1Style = TextStyle(fontSize: 48, fontWeight: FontWeight.normal, height: 4.125, fontFamily: 'Poppins');

  static const h2Style = TextStyle(fontSize: 34, fontWeight: FontWeight.normal, height: 3.188, fontFamily: 'Poppins');

  static const h3Style = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 2.375, fontFamily: 'Poppins');

  static const h4Style = TextStyle(fontSize: 24, fontWeight: FontWeight.normal, height: 1.2, fontFamily: 'Poppins');

  static const h5Style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal, height: 1.2, fontFamily: 'Poppins');

  static const h6Style = TextStyle(fontSize: 42, fontWeight: FontWeight.normal, height: 3.188, fontFamily: 'Poppins');

  // Button

  static const button1Style =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.875, fontFamily: 'Poppins');

  static const button2Style =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.625, fontFamily: 'Poppins');
}
