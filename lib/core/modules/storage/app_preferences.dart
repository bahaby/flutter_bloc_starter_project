import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

@lazySingleton
class AppPreferences {
  AppPreferences(this._sharedPreference);

  final SharedPreferences _sharedPreference;

  String get languageCode =>
      _sharedPreference.getString(constants.cacheKeys.languageCode) ?? '';

  bool get isFirstLogin =>
      _sharedPreference.getBool(constants.cacheKeys.isFirstLogin) ?? true;

  bool get isFirstLaunchApp =>
      _sharedPreference.getBool(constants.cacheKeys.isFirstLaunchApp) ?? true;

  bool get onboardingCompleted =>
      _sharedPreference.getBool(constants.cacheKeys.onboardingCompleted) ??
      false;

  Future<bool> saveLanguageCode(String languageCode) {
    return _sharedPreference.setString(
        constants.cacheKeys.languageCode, languageCode);
  }

  Future<bool> saveIsFirstLogin(bool isFirstLogin) {
    return _sharedPreference.setBool(
        constants.cacheKeys.isFirstLogin, isFirstLogin);
  }

  Future<bool> saveIsFirsLaunchApp(bool isFirstLaunchApp) {
    return _sharedPreference.setBool(
        constants.cacheKeys.isFirstLaunchApp, isFirstLaunchApp);
  }

  Future<bool> saveOnboardingCompleted(bool onboardingCompleted) {
    return _sharedPreference.setBool(
        constants.cacheKeys.onboardingCompleted, onboardingCompleted);
  }
}
