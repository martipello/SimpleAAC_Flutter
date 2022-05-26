enum Flavor {
  dev,
  uat,
  prod,
}

// ignore_for_file: avoid_classes_with_only_static_members
class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Simple AAC DEV';
      case Flavor.uat:
        return 'Simple AAC UAT';
      case Flavor.prod:
        return 'Simple AAC';
      default:
        return 'Simple AAC';
    }
  }
}
