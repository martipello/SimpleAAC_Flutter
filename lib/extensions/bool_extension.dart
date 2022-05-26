extension BoolExtensions on bool? {
  bool isFalseOrNull() {
    return this == null || this == false;
  }
}
