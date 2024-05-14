import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import 'color/app_color_scheme.dart';
import 'text/app_text_theme.dart';
import 'text/app_typography.dart';

Future<ThemeData> createTheme({
  Color? color,
  required Brightness brightness,
}) async {
  final colorScheme = _getColorScheme(color: color, brightness: brightness);
  final dynamicColorScheme = await _getDynamicColors(brightness: brightness);
  final appColorScheme = _getAppColorScheme(
    color: color,
    colorScheme: colorScheme,
    dynamicColorScheme: dynamicColorScheme,
    brightness: brightness,
  );

  final appTypography =
      AppTypography.create(fontFamily: constants.theme.defaultFontFamily);
  final textTheme =
      _getTextTheme(appTypography: appTypography, brightness: brightness);

  final primaryColor = ElevationOverlay.colorWithOverlay(
      appColorScheme.surface, appColorScheme.primary, 3);
  final customOnPrimaryColor = appColorScheme.primary.withOpacity(0.5);

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
        brightness: brightness,
        primaryColor: primaryColor,
      ),
    ),
    splashFactory: InkRipple.splashFactory,
    scaffoldBackgroundColor: appColorScheme.surface,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: constants.theme.defaultElevation,
      highlightElevation: constants.theme.defaultElevation,
    ),
    iconTheme: IconThemeData(
      color: appColorScheme.primary,
    ),
    cardTheme: CardTheme(
      elevation: constants.theme.defaultElevation,
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            constants.theme.defaultBorderRadius,
          ),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
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
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: const BorderSide(
          style: BorderStyle.none,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: const BorderSide(
          style: BorderStyle.none,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: BorderSide(
          color: constants.palette.red.withOpacity(0.3),
          width: 4,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: BorderSide(
          color: constants.palette.red.withOpacity(0.3),
          width: 4,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: BorderSide(
          color: constants.palette.green.withOpacity(0.5),
          width: 4,
        ),
      ),
      filled: true,
      errorMaxLines: 2,
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
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
      thumbColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return customOnPrimaryColor;
        }
        return null;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return customOnPrimaryColor.withOpacity(0.7);
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
    systemNavigationBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  );
}

Future<ColorScheme?> _getDynamicColors({required Brightness brightness}) async {
  try {
    final corePalette = await DynamicColorPlugin.getCorePalette();

    return corePalette?.toColorScheme(brightness: brightness);
  } on PlatformException {
    return Future.value();
  }
}

ColorScheme _getColorScheme({
  Color? color,
  required Brightness brightness,
}) {
  return ColorScheme.fromSeed(
    seedColor: color ?? constants.theme.defaultThemeColor,
    brightness: brightness,
  );
}

AppColorScheme _getAppColorScheme({
  Color? color,
  required ColorScheme colorScheme,
  ColorScheme? dynamicColorScheme,
  required Brightness brightness,
}) {
  final isDark = brightness == Brightness.dark;

  return AppColorScheme.fromMaterialColorScheme(
    color != null
        ? colorScheme
        : constants.theme.tryToGetColorPaletteFromWallpaper
            ? dynamicColorScheme ?? colorScheme
            : colorScheme,
    disabled: constants.palette.grey,
    onDisabled: isDark ? constants.palette.white : constants.palette.black,
  );
}

AppTextTheme _getTextTheme({
  required AppTypography appTypography,
  required Brightness brightness,
}) {
  return brightness == Brightness.dark
      ? appTypography.white
      : appTypography.black;
}
