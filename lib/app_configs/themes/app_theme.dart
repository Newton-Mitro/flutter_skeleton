import 'package:flutter/material.dart';
import 'package:tafaling/app_configs/values/colors/dark_colors.dart';
import 'package:tafaling/app_configs/values/colors/light_colors.dart';

class AppTheme {
  ThemeData get dark => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColorsDark().background,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColorsDark().primary,
      onPrimary: AppColorsDark().onPrimary,
      primaryContainer: AppColorsDark().primaryContainer,
      onPrimaryContainer: AppColorsDark().onPrimaryContainer,
      primaryFixed: AppColorsDark().primaryFixed,
      primaryFixedDim: AppColorsDark().primaryFixedDim,
      onPrimaryFixed: AppColorsDark().onPrimaryFixed,
      onPrimaryFixedVariant: AppColorsDark().onPrimaryFixedVariant,
      secondary: AppColorsDark().secondary,
      onSecondary: AppColorsDark().onSecondary,
      secondaryContainer: AppColorsDark().secondaryContainer,
      onSecondaryContainer: AppColorsDark().onSecondaryContainer,
      secondaryFixed: AppColorsDark().secondaryFixed,
      secondaryFixedDim: AppColorsDark().secondaryFixedDim,
      onSecondaryFixed: AppColorsDark().onSecondaryFixed,
      onSecondaryFixedVariant: AppColorsDark().onSecondaryFixedVariant,
      tertiary: AppColorsDark().tertiary,
      onTertiary: AppColorsDark().onTertiary,
      tertiaryContainer: AppColorsDark().tertiaryContainer,
      onTertiaryContainer: AppColorsDark().onTertiaryContainer,
      tertiaryFixed: AppColorsDark().tertiaryFixed,
      tertiaryFixedDim: AppColorsDark().tertiaryFixedDim,
      onTertiaryFixed: AppColorsDark().onTertiaryFixed,
      onTertiaryFixedVariant: AppColorsDark().onTertiaryFixedVariant,
      error: AppColorsDark().error,
      onError: AppColorsDark().onError,
      errorContainer: AppColorsDark().errorContainer,
      onErrorContainer: AppColorsDark().onErrorContainer,
      surface: AppColorsDark().surface,
      onSurface: AppColorsDark().onSurface,
      surfaceDim: AppColorsDark().surfaceDim,
      surfaceBright: AppColorsDark().surfaceBright,
      surfaceContainerLowest: AppColorsDark().surfaceContainerLowest,
      surfaceContainerLow: AppColorsDark().surfaceContainerLow,
      surfaceContainer: AppColorsDark().surfaceContainer,
      surfaceContainerHigh: AppColorsDark().surfaceContainerHigh,
      surfaceContainerHighest: AppColorsDark().surfaceContainerHighest,
      onSurfaceVariant: AppColorsDark().onSurfaceVariant,
      outline: AppColorsDark().outline,
      outlineVariant: AppColorsDark().outlineVariant,
      shadow: AppColorsDark().shadow,
      scrim: AppColorsDark().scrim,
      inverseSurface: AppColorsDark().inverseSurface,
      onInverseSurface: AppColorsDark().onInverseSurface,
      inversePrimary: AppColorsDark().inversePrimary,
      surfaceTint: AppColorsDark().surfaceTint,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color?>(
          AppColorsDark().secondary,
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColorsDark().surface,
      textStyle: _textTheme.bodyMedium,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColorsDark().primary),
      trackColor: WidgetStateProperty.all(AppColorsDark().onSurface),
    ),
    textTheme: _textTheme,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsDark().primary,
      titleTextStyle: TextStyle(fontSize: 18, color: AppColorsDark().onPrimary),
      elevation: 0,
      iconTheme: IconThemeData(color: AppColorsDark().onPrimary),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColorsDark().error,
      dividerColor: AppColorsDark().primaryVariant,
      labelColor: AppColorsDark().selected,
      unselectedLabelColor: AppColorsDark().unSelected,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorsDark().primary,
      unselectedItemColor: AppColorsDark().unSelected,
      selectedItemColor: AppColorsDark().selected,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColorsLight().background,
    colorScheme: ColorScheme.light(
      primary: AppColorsLight().primary,
      onPrimaryFixed: AppColorsLight().onPrimary,
      secondary: AppColorsLight().secondary,
      surface: AppColorsLight().surface,
      error: AppColorsLight().error,
      onPrimary: AppColorsLight().onPrimary,
      onSecondary: AppColorsLight().onSecondary,
      onSurface: AppColorsLight().onSurface,
      onError: AppColorsLight().onError,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColorsLight().surface,
      textStyle: _textTheme.bodyMedium,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColorsLight().primary),
      trackColor: WidgetStateProperty.all(AppColorsLight().onSurface),
    ),
    textTheme: _textTheme,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsLight().primary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColorsLight().onBackground),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorsLight().primary,
      unselectedItemColor: AppColorsLight().onPrimary,
      selectedItemColor: AppColorsLight().secondary,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final TextTheme _textTheme = TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
      height: 1.5,
      color: AppColorsDark().onPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.4,
      color: AppColorsDark().onPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      height: 1.3,
      color: AppColorsDark().onPrimary,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      height: 1.4,
      color: AppColorsDark().onPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.3,
      color: AppColorsDark().onPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
      height: 1.2,
      color: AppColorsDark().onPrimary,
    ),
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.8,
      height: 1.6,
      color: AppColorsDark().onPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.7,
      height: 1.5,
      color: AppColorsDark().onPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      height: 1.4,
      color: AppColorsDark().onPrimary,
    ),
  );

  final PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
