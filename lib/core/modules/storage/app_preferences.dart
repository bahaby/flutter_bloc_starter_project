import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

@lazySingleton
class AppPreferences {
  AppPreferences(this._sharedPreference);

  final SharedPreferences _sharedPreference;

  String get languageCode =>
      _sharedPreference.getString(constants.cacheKeys.languageCode) ?? '';

  Color get themeColor {
    final colorInt = _sharedPreference.getInt(constants.cacheKeys.themeColor);
    if (colorInt != null) {
      return Color(colorInt);
    } else {
      return constants.theme.defaultThemeColor;
    }
  }

  ThemeMode get themeMode {
    final modeIndex = _sharedPreference.getInt(constants.cacheKeys.themeMode);
    if (modeIndex != null) {
      return ThemeMode.values[modeIndex];
    } else {
      return ThemeMode.light;
    }
  }

  bool get isFirstLogin =>
      _sharedPreference.getBool(constants.cacheKeys.isFirstLogin) ?? true;

  bool get isFirstLaunchApp =>
      _sharedPreference.getBool(constants.cacheKeys.isFirstLaunchApp) ?? true;

  bool get onboardingCompleted =>
      _sharedPreference.getBool(constants.cacheKeys.onboardingCompleted) ??
      false;

  Future<bool> saveLanguageCode(String languageCode) {
    return _sharedPreference.setString(
      constants.cacheKeys.languageCode,
      languageCode,
    );
  }

  Future<Color> saveThemeColor(Color color) {
    return _sharedPreference
        .setInt(constants.cacheKeys.themeColor, color.toARGB32())
        .then((success) {
          return success ? color : constants.theme.defaultThemeColor;
        });
  }

  Future<ThemeMode> saveThemeMode(ThemeMode mode) {
    return _sharedPreference
        .setInt(constants.cacheKeys.themeMode, mode.index)
        .then((success) {
          return success ? mode : ThemeMode.light;
        });
  }

  Future<bool> saveIsFirstLogin(bool isFirstLogin) {
    return _sharedPreference.setBool(
      constants.cacheKeys.isFirstLogin,
      isFirstLogin,
    );
  }

  Future<bool> saveIsFirsLaunchApp(bool isFirstLaunchApp) {
    return _sharedPreference.setBool(
      constants.cacheKeys.isFirstLaunchApp,
      isFirstLaunchApp,
    );
  }

  Future<bool> saveOnboardingCompleted(bool onboardingCompleted) {
    return _sharedPreference.setBool(
      constants.cacheKeys.onboardingCompleted,
      onboardingCompleted,
    );
  }
}
