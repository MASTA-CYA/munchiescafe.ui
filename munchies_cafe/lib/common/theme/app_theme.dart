import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/helpers/color_helper.dart';

/// The Munchies Café colour palette.
class AppColors {
  /// Chocolate brown, used for app bars, buttons and highlights.
  static final Color primary = ColorHelper.lighten(
    ColorHelper.fromHex('#3B1F11'),
  );

  /// Candy pink.
  static final Color secondary = ColorHelper.fromHex('#FF63E9');

  /// Lemon yellow, used for text and icons on primary and secondary colours.
  static final Color accent = ColorHelper.fromHex('#FFDE2E');

  /// Neutral grey for icons and supporting elements.
  static final Color grey = ColorHelper.fromHex('#A6A6A6');

  static const Color white = Colors.white;
}

/// The app's single theme.
class AppTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: FontFamily.secondary,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 20),
    ),
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.accent,
      secondary: AppColors.secondary,
      onSecondary: AppColors.accent,
      tertiary: AppColors.grey,
    ),
    dividerColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      titleTextStyle: const TextStyle(
        fontFamily: FontFamily.primary,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      toolbarTextStyle: const TextStyle(color: AppColors.white),
      iconTheme: const IconThemeData(color: AppColors.white),
      actionsIconTheme: const IconThemeData(color: AppColors.white),
    ),
    iconTheme: IconThemeData(color: AppColors.grey),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      filled: true,
      fillColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        surfaceTintColor: WidgetStateProperty.all<Color>(Colors.transparent),
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: AppColors.primary,
    ),
    cardTheme: const CardThemeData(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      shape: RoundedRectangleBorder(),
      color: AppColors.white,
      surfaceTintColor: Colors.transparent,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.white,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary,
      actionBackgroundColor: AppColors.grey,
      actionTextColor: AppColors.white,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.secondary,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(AppColors.white),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: AppColors.primary,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all<Color>(AppColors.white),
    ),
  );
}
