import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../../ui/theme/adaptive_theme.dart';

/// A Hive data type adapter for enum [ThemeMode].
class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  ThemeMode read(final BinaryReader reader) {
    final index = reader.readInt();
    return ThemeMode.values[index];
  }

  @override
  void write(final BinaryWriter writer, final ThemeMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 150;
}

/// A Hive data type adapter for class [Color].
class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(final BinaryReader reader) {
    final value = reader.readInt();
    return Color(value);
  }

  @override
  void write(final BinaryWriter writer, final Color obj) {
    writer.writeInt(obj.value);
  }

  @override
  int get typeId => 151;
}

/// A Hive data type adapter for enum [FlexScheme].
class FlexSchemeAdapter extends TypeAdapter<FlexScheme> {
  @override
  FlexScheme read(final BinaryReader reader) {
    final index = reader.readInt();
    return FlexScheme.values[index];
  }

  @override
  void write(final BinaryWriter writer, final FlexScheme obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 152;
}

/// A Hive data type adapter for enum [FlexSurfaceMode].
class FlexSurfaceModeAdapter extends TypeAdapter<FlexSurfaceMode> {
  @override
  FlexSurfaceMode read(final BinaryReader reader) {
    final index = reader.readInt();
    return FlexSurfaceMode.values[index];
  }

  @override
  void write(final BinaryWriter writer, final FlexSurfaceMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 153;
}

/// A Hive data type adapter for enum [FlexInputBorderType].
class FlexInputBorderTypeAdapter extends TypeAdapter<FlexInputBorderType> {
  @override
  FlexInputBorderType read(final BinaryReader reader) {
    final index = reader.readInt();
    return FlexInputBorderType.values[index];
  }

  @override
  void write(final BinaryWriter writer, final FlexInputBorderType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 154;
}

/// A Hive data type adapter for enum [FlexAppBarStyle].
class FlexAppBarStyleAdapter extends TypeAdapter<FlexAppBarStyle> {
  @override
  FlexAppBarStyle read(final BinaryReader reader) {
    final index = reader.readInt();
    return FlexAppBarStyle.values[index];
  }

  @override
  void write(final BinaryWriter writer, final FlexAppBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 155;
}

/// A Hive data type adapter for enum [FlexTabBarStyle], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class FlexTabBarStyleAdapter extends TypeAdapter<FlexTabBarStyle?> {
  @override
  FlexTabBarStyle? read(final BinaryReader reader) {
    final index = reader.readInt();
    if (index < 0 || index >= FlexTabBarStyle.values.length) {
      return null;
    } else {
      return FlexTabBarStyle.values[index];
    }
  }

  @override
  void write(final BinaryWriter writer, final FlexTabBarStyle? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 156;
}

/// A Hive data type adapter for enum [FlexSystemNavBarStyle].
class FlexSystemNavBarStyleAdapter extends TypeAdapter<FlexSystemNavBarStyle> {
  @override
  FlexSystemNavBarStyle read(final BinaryReader reader) {
    final index = reader.readInt();
    return FlexSystemNavBarStyle.values[index];
  }

  @override
  void write(final BinaryWriter writer, final FlexSystemNavBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 157;
}

/// A Hive data type adapter for enum [SchemeColor], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class FlexSchemeColorAdapter extends TypeAdapter<SchemeColor?> {
  @override
  SchemeColor? read(final BinaryReader reader) {
    final index = reader.readInt();
    if (index < 0 || index >= SchemeColor.values.length) {
      return null;
    } else {
      return SchemeColor.values[index];
    }
  }

  @override
  void write(final BinaryWriter writer, final SchemeColor? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 158;
}

/// A Hive data type adapter for enum [NavigationDestinationLabelBehavior].
class NavigationDestinationLabelBehaviorAdapter
    extends TypeAdapter<NavigationDestinationLabelBehavior> {
  @override
  NavigationDestinationLabelBehavior read(final BinaryReader reader) {
    final index = reader.readInt();
    return NavigationDestinationLabelBehavior.values[index];
  }

  @override
  void write(final BinaryWriter writer, final NavigationDestinationLabelBehavior obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 159;
}

/// A Hive data type adapter for enum [NavigationRailLabelType].
class NavigationRailLabelTypeAdapter
    extends TypeAdapter<NavigationRailLabelType> {
  @override
  NavigationRailLabelType read(final BinaryReader reader) {
    final index = reader.readInt();
    return NavigationRailLabelType.values[index];
  }

  @override
  void write(final BinaryWriter writer, final NavigationRailLabelType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 160;
}

/// A Hive data type adapter for enum [FlexSliderIndicatorType], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class FlexSliderIndicatorTypeAdapter
    extends TypeAdapter<FlexSliderIndicatorType?> {
  @override
  FlexSliderIndicatorType? read(final BinaryReader reader) {
    final index = reader.readInt();
    if (index < 0 || index >= FlexSliderIndicatorType.values.length) {
      return null;
    } else {
      return FlexSliderIndicatorType.values[index];
    }
  }

  @override
  void write(final BinaryWriter writer, final FlexSliderIndicatorType? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 161;
}

/// A Hive data type adapter for enum [ShowValueIndicator], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class ShowValueIndicatorAdapter extends TypeAdapter<ShowValueIndicator?> {
  @override
  ShowValueIndicator? read(final BinaryReader reader) {
    final index = reader.readInt();
    if (index < 0 || index >= ShowValueIndicator.values.length) {
      return null;
    } else {
      return ShowValueIndicator.values[index];
    }
  }

  @override
  void write(final BinaryWriter writer, final ShowValueIndicator? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 162;
}

// Value typeId => 163 was used before for enum FlexTint that was removed.
// Value typeId => 164 was used before for enum FlexShadow that was removed.
// Not using them to avoid type conversion issues with previous file data.

/// A Hive data type adapter for enum [TabBarIndicatorSize], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class TabBarIndicatorSizeAdapter extends TypeAdapter<TabBarIndicatorSize?> {
  @override
  TabBarIndicatorSize? read(final BinaryReader reader) {
    final index = reader.readInt();
    if (index < 0 || index >= TabBarIndicatorSize.values.length) {
      return null;
    } else {
      return TabBarIndicatorSize.values[index];
    }
  }

  @override
  void write(final BinaryWriter writer, final TabBarIndicatorSize? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 165;
}

/// A Hive data type adapter for enum [AdaptiveTheme], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class AdaptiveThemeAdapter extends TypeAdapter<AdaptiveTheme?> {
  @override
  AdaptiveTheme? read(final BinaryReader reader) {
    final index = reader.readInt();
    if (index < 0 || index >= AdaptiveTheme.values.length) {
      return null;
    } else {
      return AdaptiveTheme.values[index];
    }
  }

  @override
  void write(final BinaryWriter writer, final AdaptiveTheme? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 166;
}
