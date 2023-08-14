import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_aac/api/services/shared_preferences_service.dart';
import 'package:simple_aac/utils/constants.dart';

void main() {
  test('has related words enabled', () async {
    SharedPreferences.setMockInitialValues({
      Constants.RELATED_WORDS: false,
    });
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPreferencesService = SharedPreferencesService(sharedPreferences);
    sharedPreferencesService.addListener(() {
      expect(sharedPreferencesService.hasRelatedWordsEnabled, true);
    });
    final hasRelatedWordsEnabled = sharedPreferencesService.hasRelatedWordsEnabled;
    expect(hasRelatedWordsEnabled, false);
    sharedPreferencesService.setRelatedWordsEnabled(true);
  });
}