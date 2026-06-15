import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

Future<void> setupCrashReporting() async {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
}

void recordZonedError(Object error, StackTrace stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, reason: 'Zoned Error');
}
