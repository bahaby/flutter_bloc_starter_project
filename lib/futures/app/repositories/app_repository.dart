import 'dart:async';

import 'package:flutter_bloc_starter_project/core/modules/storage/objectbox_storage.dart';
import 'package:flutter_bloc_starter_project/futures/posts/models/post_model.dart';

import '../../../core/utils/helpers/jwt_helper.dart';

import '../../../core/generated/translations.g.dart';
import '../../../core/modules/storage/app_preferences.dart';
import '../models/user_model.dart';
import '../presentation/blocs/app_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/exception_handler.dart';
import '../../../core/modules/token_refresh/dio_token_refresh.dart';
import '../models/alert_model.dart';
import '../sources/app_remote_data_source.dart';

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
  void setLoggedUser({required UserModel? user});
  void setLocale({required AppLocale locale});
  void setFirstLaunch();
  void setFirstLogin();
  void setOnboardingCompleted();

  Future<Either<AlertModel, void>> initializeLoggedUser();
  Future<Either<AlertModel, void>> initializeTranslationOverrides();
  Stream<GlobalState> get globalState;
  Stream<UserModel?> get loggedUser;
  Stream<AuthStatus> get authStatus;
  AppLocale get locale;
  bool get isFirstLaunch;
  bool get isFirstLogin;
  bool get onboardingCompleted;
}

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource _appRemoteDataSource;
  final DioTokenRefresh _dioTokenRefresh;
  final ObjectBoxStorage _objectBoxStorage;
  final AppPreferences _appPreferences;

  AppRepositoryImpl({
    required AppRemoteDataSource appRemoteDataSource,
    required DioTokenRefresh dioTokenRefresh,
    required ObjectBoxStorage objectBoxStorage,
    required AppPreferences appPreferences,
  })  : _appRemoteDataSource = appRemoteDataSource,
        _objectBoxStorage = objectBoxStorage,
        _appPreferences = appPreferences,
        _dioTokenRefresh = dioTokenRefresh;

  final _globalStateController = StreamController<GlobalState>.broadcast();
  final _loggedUserController = StreamController<UserModel?>.broadcast();
  final _authStatusController = StreamController<AuthStatus>.broadcast();

  @override
  Stream<GlobalState> get globalState => _globalStateController.stream;

  @override
  Stream<UserModel?> get loggedUser => _loggedUserController.stream;

  @override
  Stream<AuthStatus> get authStatus => _authStatusController.stream;

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
  Future<Either<AlertModel, void>> logout() async {
    return exceptionHandler(() async {
      var result = await _appRemoteDataSource.logout();
      setLoggedUser(user: null);
      await _clearUserData();
      return right(result);
    });
  }

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
  void setGlobalState({required GlobalState state}) {
    _globalStateController.add(state);
  }

  @override
  void setLoggedUser({required UserModel? user}) {
    _loggedUserController.add(user);
    _authStatusController.add(
        user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated);
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
  void setOnboardingCompleted() {
    _appPreferences.saveOnboardingCompleted(true);
  }

  @override
  Future<Either<AlertModel, void>> initializeLoggedUser() async {
    final authModel = await _dioTokenRefresh.fresh.token;
    final user = authModel?.user;
    final refreshToken = authModel?.refreshToken;

    if (user == null || JwtHelper.isTokenExpiring(refreshToken)) {
      await _clearUserData();
      setLoggedUser(user: null);
    } else {
      setLoggedUser(user: user);
    }

    return right(null);
  }

  Future<void> _clearUserData() async {
    await _dioTokenRefresh.fresh.clearToken();
    await _objectBoxStorage.clear<PostModel>();
  }
}
