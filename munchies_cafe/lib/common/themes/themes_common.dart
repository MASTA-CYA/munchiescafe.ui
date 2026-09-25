import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';

class ThemesCommon {
  // Color Scheme
  static final Color primaryColor = ColorHelper.lighten(
    ColorHelper.fromHex('#3B1F11'),
  );
  static final Color secondaryColor = ColorHelper.fromHex('#FF63E9');
  static const Color lightTertiaryColor = Colors.white;
  static final Color lightAuxillaryColor = ColorHelper.fromHex('#A6A6A6');
  static final Color lightAccentColor = ColorHelper.fromHex('#FFDE2E');
  static const Color darkTertiaryColor = Colors.white;
  static const Color lightScaffoldBackgroundColor = Colors.white;
  static const Color darkScaffoldBackgroundColor = Colors.black;

  // Text
  static const primaryText = FontFamily.PRIMARY;
  static const secondaryText = FontFamily.SECONDARY;

  // Methods
  static MaterialStateProperty<Color?> buildCheckboxCheckColor() {
    return MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) =>
          // Thumb icon when the switch is selected.
          ThemesCommon.darkTertiaryColor,
    );
  }

  static MaterialStateProperty<Color?> buildSwitchThumbColor() {
    return MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Thumb icon when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return ThemesCommon.darkTertiaryColor;
        }
        return ThemesCommon.lightTertiaryColor;
      },
    );
  }
}
