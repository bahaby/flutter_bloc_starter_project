import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_starter_project/futures/app/models/auth_model.dart';
import 'package:flutter_bloc_starter_project/futures/auth/repositories/auth_repository.dart';

import '../../../core/generated/translations.g.dart';
import '../../../core/modules/hive_storage/hive_storage.dart';
import '../../../core/modules/storage/app_preferences.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/exception_handler.dart';
import '../models/alert_model.dart';
import '../data_sources/app_remote_data_source.dart';

enum GlobalState {
  loading,
  loadingInteractionDisabled,
  loaded;

  bool get isLoading =>
      this == GlobalState.loading ||
      this == GlobalState.loadingInteractionDisabled;
  bool get isInteractionDisabled =>
      this == GlobalState.loadingInteractionDisabled;
  bool get isLoaded => this == GlobalState.loaded;
}

abstract interface class AppRepository {
  Future<Either<AlertModel, void>> logout();
  void setGlobalState({required GlobalState state});
  void setLocale({required AppLocale locale});
  void setThemeMode({required ThemeMode mode});
  void setThemeColor({required Color color});
  void setFirstLaunch();
  void setFirstLogin();
  void setOnboardingCompleted();
  void initializeAuthStatus();

  Future<Either<AlertModel, void>> initializeTranslationOverrides();
  Stream<GlobalState> get globalState;
  Stream<AuthModel?> get loggedUser;
  Stream<AuthStatus> get authStatus;
  AppLocale get locale;
  ThemeMode get themeMode;
  Color get themeColor;
  bool get isFirstLaunch;
  bool get isFirstLogin;
  bool get onboardingCompleted;
}

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource _appRemoteDataSource;
  final AppPreferences _appPreferences;
  final AuthRepository _authRepository;
  final HiveStorage _hiveStorage;

  AppRepositoryImpl({
    required this._appRemoteDataSource,
    required this._appPreferences,
    required this._authRepository,
    required this._hiveStorage,
  });

  final _globalStateController = StreamController<GlobalState>.broadcast();

  @override
  Stream<GlobalState> get globalState => _globalStateController.stream;

  @override
  bool get isFirstLaunch => _appPreferences.isFirstLaunchApp;

  @override
  bool get isFirstLogin => _appPreferences.isFirstLogin;

  @override
  bool get onboardingCompleted => _appPreferences.onboardingCompleted;

  @override
  AppLocale get locale {
    final languageCode = _appPreferences.languageCode;
    return AppLocaleUtils.parseLocaleParts(languageCode: languageCode);
  }

  @override
  ThemeMode get themeMode => _appPreferences.themeMode;

  @override
  Color get themeColor => _appPreferences.themeColor;

  @override
  Future<Either<AlertModel, void>> initializeTranslationOverrides() async {
    return exceptionHandler(() async {
      for (var locale in AppLocale.values) {
        final result = await _appRemoteDataSource.translateOverrides(locale);
        LocaleSettings.overrideTranslationsFromMap(
          locale: locale,
          isFlatMap: false,
          map: result,
        );
      }
      return right(null);
    });
  }

  @override
  Stream<AuthModel?> get loggedUser {
    return _authRepository.loggedUser;
  }

  @override
  Stream<AuthStatus> get authStatus => _authRepository.authStatus;

  @override
  void setGlobalState({required GlobalState state}) {
    _globalStateController.add(state);
  }

  @override
  void setLocale({required AppLocale locale}) {
    _appPreferences.saveLanguageCode(locale.languageCode);
  }

  @override
  void setFirstLaunch() {
    _appPreferences.saveIsFirsLaunchApp(false);
  }

  @override
  void setFirstLogin() {
    _appPreferences.saveIsFirstLogin(false);
  }

  @override
  void setThemeMode({required ThemeMode mode}) {
    _appPreferences.saveThemeMode(mode);
  }

  @override
  void setThemeColor({required Color color}) {
    _appPreferences.saveThemeColor(color);
  }

  @override
  void setOnboardingCompleted() {
    _appPreferences.saveOnboardingCompleted(true);
  }

  @override
  void initializeAuthStatus() {
    _authRepository.initializeAuthStatus();
  }

  @override
  Future<Either<AlertModel, void>> logout() async {
    _hiveStorage.clearAll();
    return _authRepository.logout();
  }
}
