extension StringExtension on String? {
  bool isNotNullOrEmpty() {
    return this?.isNotEmpty == true;
  }

  bool? isAPhoneNumber() {
    //very simple check for a UK phone number
    final _numeric = RegExp(r'^-?[0-9]+$');
    return this != null && this!.isNotEmpty && _numeric.hasMatch(this!) && this!.length == 11;
  }

  String capitalize() {
    if (this != null && this!.isNotEmpty) {
      return '${this![0].toUpperCase()}${this!.substring(1)}';
    } else {
      return '';
    }
  }

  String removeLastCharacter() {
    if (this != null && this!.isNotEmpty) {
      return this!.substring(0, this!.length - 1);
    } else {
      return '';
    }
  }

  String toEmailUri({
    Map<String, dynamic>? queryParameters,
  }) {
    final stringBuffer = StringBuffer();
    if (queryParameters?.isNotEmpty == true) {
      queryParameters?.entries
          .map(
            (e) => stringBuffer.write(
              '${e.key}=${e.value.toString().replaceAll('=', 'EQUAL').replaceAll('&', 'AMP')}&',
            ),
          )
          .toString();
    }
    final uri = Uri(
      scheme: 'mailto',
      query: stringBuffer.toString().removeLastCharacter(),
      path: this,
    );
    return '$uri';
  }

  String toPhoneUri() {
    final uri = Uri(
      scheme: 'tel',
      path: this,
    );
    return uri.toString();
  }
}
