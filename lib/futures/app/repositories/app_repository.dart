import 'dart:async';

import '../../../core/generated/translations.g.dart';
import '../../../core/modules/hive_storage/hive_storage.dart';
import '../../../core/modules/storage/app_preferences.dart';
import '../models/user_model.dart';
import '../presentation/blocs/app_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/exception_handler.dart';
import '../../../core/modules/token_refresh/dio_token_refresh.dart';
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
  void setLoggedUser({required UserModel? user});
  void setLocale({required AppLocale locale});
  void setIsFirstLaunch({required bool isFirstLaunch});
  void setIsFirstLogin({required bool isFirstLogin});
  void setOnboardingCompleted({required bool onboardingCompleted});

  Future<Either<AlertModel, void>> initializeLoggedUser();
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
  final HiveStorage _hiveStorage;
  final AppPreferences _appPreferences;

  AppRepositoryImpl({
    required AppRemoteDataSource appRemoteDataSource,
    required DioTokenRefresh dioTokenRefresh,
    required HiveStorage hiveStorage,
    required AppPreferences appPreferences,
  })  : _appRemoteDataSource = appRemoteDataSource,
        _hiveStorage = hiveStorage,
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
      await _dioTokenRefresh.fresh.clearToken();
      await _hiveStorage.clearAll();
      return right(result);
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
  void setIsFirstLaunch({required bool isFirstLaunch}) {
    _appPreferences.saveIsFirsLaunchApp(isFirstLaunch);
  }

  @override
  void setIsFirstLogin({required bool isFirstLogin}) {
    _appPreferences.saveIsFirstLogin(isFirstLogin);
  }

  @override
  void setOnboardingCompleted({required bool onboardingCompleted}) {
    _appPreferences.saveOnboardingCompleted(onboardingCompleted);
  }

  @override
  Future<Either<AlertModel, void>> initializeLoggedUser() async {
    final token = await _dioTokenRefresh.fresh.token;
    final user = token?.user;
    if (user != null) {
      _loggedUserController.add(user);
      _authStatusController.add(AuthStatus.authenticated);
    } else {
      _authStatusController.add(AuthStatus.unauthenticated);
    }
    return right(null);
  }
}
