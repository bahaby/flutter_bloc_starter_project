import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import 'color/app_color_scheme.dart';
import 'text/app_text_theme.dart';
import 'text/app_typography.dart';

ThemeData createTheme({Color? color, required ThemeMode mode}) {
  final colorScheme = _getColorScheme(color: color, mode: mode);
  final appColorScheme = _getAppColorScheme(
    color: color,
    colorScheme: colorScheme,
    mode: mode,
  );

  final appTypography = AppTypography.create(
    fontFamily: constants.theme.defaultFontFamily,
  );
  final textTheme = _getTextTheme(appTypography: appTypography, mode: mode);

  final primaryColor = ElevationOverlay.colorWithOverlay(
    appColorScheme.surface,
    appColorScheme.primary,
    3,
  );
  final customOnPrimaryColor = appColorScheme.primary.withValues(alpha: 0.5);

  return ThemeData(
    textTheme: textTheme.materialTextTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: appColorScheme.materialColorScheme,
    brightness: appColorScheme.brightness,
    typography: appTypography.materialTypography,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      elevation: constants.theme.defaultElevation,
      systemOverlayStyle: createOverlayStyle(
        brightness: appColorScheme.brightness,
        primaryColor: primaryColor,
      ),
    ),
    splashFactory: InkRipple.splashFactory,
    scaffoldBackgroundColor: appColorScheme.surface,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: constants.theme.defaultElevation,
      highlightElevation: constants.theme.defaultElevation,
    ),
    iconTheme: IconThemeData(color: appColorScheme.primary),
    cardTheme: CardThemeData(
      elevation: constants.theme.defaultElevation,
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(constants.theme.defaultBorderRadius),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return customOnPrimaryColor;
        }
        return null;
      }),
    ),
    inputDecorationTheme: InputDecorationTheme(
      disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(constants.theme.defaultBorderRadius),
        ),
        borderSide: const BorderSide(style: BorderStyle.none),
      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(constants.theme.defaultBorderRadius),
        ),
        borderSide: const BorderSide(style: BorderStyle.none),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(constants.theme.defaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: constants.palette.red.withValues(alpha: 0.3),
          width: 4,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(constants.theme.defaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: constants.palette.red.withValues(alpha: 0.3),
          width: 4,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(constants.theme.defaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: constants.palette.green.withValues(alpha: 0.5),
          width: 4,
        ),
      ),
      filled: true,
      errorMaxLines: 2,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return customOnPrimaryColor;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return customOnPrimaryColor;
        }
        return null;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return customOnPrimaryColor.withValues(alpha: 0.7);
        }
        return null;
      }),
    ),
  );
}

SystemUiOverlayStyle createOverlayStyle({
  required Brightness brightness,
  required Color primaryColor,
}) {
  final isDark = brightness == Brightness.dark;

  return SystemUiOverlayStyle(
    systemNavigationBarColor: primaryColor,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness: isDark
        ? Brightness.light
        : Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  );
}

ColorScheme _getColorScheme({Color? color, required ThemeMode mode}) {
  return ColorScheme.fromSeed(
    seedColor: color ?? constants.theme.defaultThemeColor,
    brightness: mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
  );
}

AppColorScheme _getAppColorScheme({
  Color? color,
  required ColorScheme colorScheme,
  required ThemeMode mode,
}) {
  final isDark = mode == ThemeMode.dark;

  return AppColorScheme.fromMaterialColorScheme(
    colorScheme,
    disabled: constants.palette.grey,
    onDisabled: isDark ? constants.palette.white : constants.palette.black,
  );
}

AppTextTheme _getTextTheme({
  required AppTypography appTypography,
  required ThemeMode mode,
}) {
  return mode == ThemeMode.dark ? appTypography.white : appTypography.black;
}
