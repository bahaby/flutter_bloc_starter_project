import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_starter_project/futures/app/models/auth_model.dart';
import 'package:flutter_bloc_starter_project/futures/auth/repositories/auth_repository.dart';
import '../../../../core/generated/translations.g.dart';
import '../../models/alert_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../../core/modules/dependency_injection/di.dart';
import '../../../../core/theme/app_theme.dart';
import '../../repositories/app_repository.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

@lazySingleton
class AppBloc extends Bloc<AppEvent, AppState> with WidgetsBindingObserver {
  final AppRepository _appRepository;
  final InternetConnection _networkInfo;
  StreamSubscription<InternetStatus>? _networkInfoSubscription;
  late StreamSubscription<GlobalState> _globalStateSubscription;
  late StreamSubscription<AuthModel?> _userSubscription;
  AppBloc({required this._appRepository, required this._networkInfo})
    : super(
        AppState.initial().copyWith(
          isFirstLaunch: _appRepository.isFirstLaunch,
          isFirstLogin: _appRepository.isFirstLogin,
          onboardingCompleted: _appRepository.onboardingCompleted,
          themeMode: _appRepository.themeMode,
          color: _appRepository.themeColor,
          locale: _appRepository.locale,
        ),
      ) {
    WidgetsBinding.instance.addObserver(this);
    _globalStateSubscription = _appRepository.globalState.listen((event) {
      add(AppEvent.globalStateChanged(event));
    });

    _userSubscription = _appRepository.loggedUser.listen((event) {
      add(AppEvent.loggedUserChanged(event));
    });

    _appRepository.authStatus.listen((event) {
      add(AppEvent.authStatusChanged(event));
    });

    on<AppEvent>((event, emit) async {
      switch (event) {
        case _Started():
          _appRepository.initializeAuthStatus();
          //await _appRepository.initializeTranslationOverrides();

          break;
        case _UserLogout():
          final result = await _appRepository.logout();
          result.fold((left) => emit(state.copyWith(alert: left)), (_) {});
          break;
        case _ChangeLocale(locale: AppLocale locale):
          _appRepository.setLocale(locale: locale);
          _changeLocale(locale, emit);
          break;
        case _ChangeThemeMode(mode: ThemeMode mode):
          _changeThemeMode(mode, emit);
          break;
        case _ChangeThemeColor(color: Color color):
          _changeThemeColor(color, emit);
          break;
        case _FirstLaunchCompleted():
          _appRepository.setFirstLaunch();
          emit(state.copyWith(isFirstLaunch: false));
          break;
        case _FirstLoginCompleted():
          _appRepository.setFirstLogin();
          emit(state.copyWith(isFirstLogin: false));
          break;
        case _OnboardingCompleted():
          _appRepository.setOnboardingCompleted();
          emit(state.copyWith(onboardingCompleted: true));
          break;
        case _InternetStatusChanged(isConnected: bool isConnected):
          emit(state.copyWith(isInternetConnected: isConnected));
          break;
        case _GlobalStateChanged(state: GlobalState globalState):
          emit(state.copyWith(globalState: globalState));
          break;
        case _LoggedUserChanged(user: AuthModel? user):
          emit(state.copyWith(currentUser: user));
          break;
        case _AuthStatusChanged(status: AuthStatus status):
          emit(state.copyWith(authStatus: status));
          break;
      }
    });
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    super.didChangePlatformBrightness();
    //_updateSystemOverlay();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _networkInfoSubscription = _networkInfo.onStatusChange.listen((event) {
          add(
            AppEvent.internetStatusChanged(event == InternetStatus.connected),
          );
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        _networkInfoSubscription?.cancel();
        _networkInfoSubscription = null;
        break;
    }
  }

  void _changeLocale(AppLocale locale, Emitter<AppState> emit) {
    LocaleSettings.setLocale(locale);
    emit(state.copyWith(locale: locale));
  }

  Future<void> _changeThemeMode(ThemeMode mode, Emitter<AppState> emit) async {
    _appRepository.setThemeMode(mode: mode);
    emit(state.copyWith(themeMode: mode));

    //_updateSystemOverlay();
  }

  void _changeThemeColor(Color color, Emitter<AppState> emit) {
    _appRepository.setThemeColor(color: color);
    emit(state.copyWith(color: color));
    //_updateSystemOverlay();
  }

  /* void _updateSystemOverlay() {
    final systemModeIsDark =
        PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    final isDark = state.theme.mode == ThemeMode.system
        ? systemModeIsDark
        : state.theme.mode == ThemeMode.dark;
    final colorScheme = isDark
        ? state.theme.dark.colorScheme
        : state.theme.light.colorScheme;
    final primaryColor = ElevationOverlay.colorWithOverlay(
      colorScheme.surface,
      colorScheme.primary,
      3,
    );

    SystemChrome.setSystemUIOverlayStyle(
      createOverlayStyle(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
      ),
    );
  } */

  @override
  Future<void> close() {
    _networkInfoSubscription?.cancel();
    _globalStateSubscription.cancel();
    _userSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
