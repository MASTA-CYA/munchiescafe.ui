import 'package:munchies_cafe/common/themes/themes_common.dart';
import 'package:flutter/material.dart';

class LightThemes {
  static final ThemeData lightThemeDefault = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: ThemesCommon.secondaryText,
    textTheme: const TextTheme().copyWith(
      bodyMedium: const TextStyle().copyWith(fontSize: 20),
      // bodyLarge: const TextStyle().copyWith(fontSize: 22),
      // titleMedium: const TextStyle().copyWith(
      //   fontSize: 22,
      //   fontWeight: FontWeight.bold,
      // ),
      // titleLarge: const TextStyle().copyWith(fontSize: 26),
    ),
    scaffoldBackgroundColor: ThemesCommon.lightScaffoldBackgroundColor,
    primaryColor: ThemesCommon.primaryColor,
    colorScheme: ColorScheme.light(
        primary: ThemesCommon.primaryColor,
        // shadow: ThemesCommon.lightAccentColor,
        onPrimary: ThemesCommon.lightAccentColor,
        secondary: ThemesCommon.secondaryColor,
        onSecondary: ThemesCommon.lightAccentColor,
        tertiary: ThemesCommon.lightAuxillaryColor),
    dividerColor: ThemesCommon.darkTertiaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ThemesCommon.primaryColor,
      foregroundColor: ThemesCommon.darkTertiaryColor,
      titleTextStyle: const TextStyle(
        fontFamily: ThemesCommon.primaryText,
        fontWeight: FontWeight.bold,
        color: ThemesCommon.darkTertiaryColor,
        // fontSize: 26,
      ),
      toolbarTextStyle: const TextStyle(color: ThemesCommon.darkTertiaryColor),
      iconTheme: const IconThemeData(color: ThemesCommon.darkTertiaryColor),
      actionsIconTheme:
          const IconThemeData(color: ThemesCommon.darkTertiaryColor),
    ),
    iconTheme: IconThemeData(color: ThemesCommon.lightAuxillaryColor),
    inputDecorationTheme: const InputDecorationTheme().copyWith(
      labelStyle: const TextStyle().copyWith(fontSize: 20),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      filled: true,
      fillColor: ThemesCommon.lightScaffoldBackgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        surfaceTintColor: MaterialStateProperty.all<Color>(Colors.transparent),
        backgroundColor:
            MaterialStateProperty.all<Color>(ThemesCommon.primaryColor),
        foregroundColor:
            MaterialStateProperty.all<Color>(ThemesCommon.lightTertiaryColor),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: ThemesCommon.primaryColor,
    ),
    cardTheme: const CardTheme(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      shape: RoundedRectangleBorder(),
      color: ThemesCommon.lightScaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemesCommon.lightScaffoldBackgroundColor,
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: ThemesCommon.primaryColor,
        actionBackgroundColor: ThemesCommon.lightAuxillaryColor,
        actionTextColor: ThemesCommon.lightTertiaryColor),
    sliderTheme: SliderThemeData(
      activeTrackColor: ThemesCommon.primaryColor,
      inactiveTrackColor: ThemesCommon.secondaryColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: ThemesCommon.buildSwitchThumbColor(),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ThemesCommon.lightScaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: ThemesCommon.primaryColor,
    ),
    textButtonTheme: const TextButtonThemeData(),
    checkboxTheme: CheckboxThemeData(
      checkColor: ThemesCommon.buildCheckboxCheckColor(),
    ),
  );
}
