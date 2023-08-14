import 'dart:ui';

// import '../api/models/content_locale.dart';

class LocaleService {
  static const defaultCountryCode = 'GB';
  static const defaultLanguageCode = 'en';

  Locale getLocale() {
    return Locale(
      window.locale.languageCode,
      window.locale.countryCode ?? defaultCountryCode,
    );
  }

  // ContentLocale getContentLocale() {
  //   return ContentLocale((b) => b
  //     ..countryCode = window.locale.countryCode ?? defaultCountryCode
  //     ..languageCode = window.locale.languageCode);
  // }
}
