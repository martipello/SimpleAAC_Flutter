import 'package:intl/intl.dart';

extension DoubleExtension on double? {
  bool isNotNullNotEmptyAndNotNegative() {
    final value = this;
    if (value != null) {
      return value.toString().isNotEmpty && !value.isNegative;
    } else {
      return false;
    }
  }

  bool isNotNullEmptyOrZero() {
    final value = this;
    if (value != null) {
      return value.toString().isNotEmpty && value.toString() != '0.0';
    } else {
      return false;
    }
  }

  String displayName() {
    if (isNotNullEmptyOrZero()) {
      return toStringWithoutTrailingZeros();
    }
    return '';
  }

  String toStringWithoutTrailingZeros() {
    if (this == null) return '';
    return this?.truncateToDouble() == this ? this?.toInt().toString() ?? '' : toString();
  }

  double? formatToTwoDecimalPlaces() {
    if (this == null) return null;
    final formatter = NumberFormat()
      ..minimumFractionDigits = 2
      ..maximumFractionDigits = 2;
    return double.tryParse(formatter.format(this));
  }
}
