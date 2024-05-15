import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/generated/translations.g.dart';
import '../../models/user_model.dart';
import '../../models/alert_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../models/theme_model.dart';
import '../../../../core/modules/dependency_injection/di.dart';
import '../../../../core/theme/app_theme.dart';
import '../../repositories/app_repository.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

@lazySingleton
class AppBloc extends HydratedBloc<AppEvent, AppState>
    with WidgetsBindingObserver {
  final AppRepository _appRepository;
  final InternetConnection _networkInfo;
  StreamSubscription<InternetStatus>? _networkInfoSubscription;
  late StreamSubscription<GlobalState> _globalStateSubscription;
  late StreamSubscription<UserModel?> _userSubscription;
  AppBloc({
    required AppRepository appRepository,
    required InternetConnection networkInfo,
  })  : _appRepository = appRepository,
        _networkInfo = networkInfo,
        super(AppState.initial()) {
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
          final locale = _appRepository.locale;
          _changeLocale(locale, emit);
          emit(state.copyWith(
            isFirstLaunch: _appRepository.isFirstLaunch,
            isFirstLogin: _appRepository.isFirstLogin,
            onboardingCompleted: _appRepository.onboardingCompleted,
          ));
          await _appRepository.initializeLoggedUser();
          await _appRepository.initializeTranslationOverrides();

          break;
        case _UserLogout():
          final result = await _appRepository.logout();
          result.fold(
            (left) => emit(state.copyWith(alert: left)),
            (_) {},
          );
          break;
        case _ChangeLocale(locale: AppLocale locale):
          _appRepository.setLocale(locale: locale);
          _changeLocale(locale, emit);
          break;
        case _ChangeThemeMode(mode: ThemeMode mode):
          await _changeThemeMode(mode, emit);
          break;
        case _ChangeThemeColor(color: Color color):
          await _changeThemeColor(color, emit);
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
        case _LoggedUserChanged(user: UserModel? user):
          emit(state.copyWith(currentUser: user));
          break;
        case _AuthStatusChanged(status: AuthStatus status):
          emit(state.copyWith(authStatus: status));
          break;
      }
    });
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    try {
      final themeModel = ThemeModel.fromJson(json['theme']);
      return state.copyWith(theme: themeModel);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      'theme': state.theme.toJson(),
    };
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    super.didChangePlatformBrightness();
    _updateSystemOverlay();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _networkInfoSubscription = _networkInfo.onStatusChange.listen((event) {
          add(AppEvent.internetStatusChanged(
              event == InternetStatus.connected));
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
    if (mode == ThemeMode.system) {
      final theme = ThemeModel(
        mode: ThemeMode.system,
        light: await createTheme(brightness: Brightness.light),
        dark: await createTheme(brightness: Brightness.dark),
      );
      emit(state.copyWith(theme: theme));
    } else {
      emit(state.copyWith(theme: state.theme.copyWith(mode: mode)));
    }

    _updateSystemOverlay();
  }

  Future<void> _changeThemeColor(Color color, Emitter<AppState> emit) async {
    final theme = ThemeModel(
      mode: state.theme.mode,
      light: await createTheme(color: color, brightness: Brightness.light),
      dark: await createTheme(color: color, brightness: Brightness.dark),
    );

    emit(state.copyWith(theme: theme));
    _updateSystemOverlay();
  }

  _updateSystemOverlay() {
    final systemModeIsDark =
        PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    final isDark = state.theme.mode == ThemeMode.system
        ? systemModeIsDark
        : state.theme.mode == ThemeMode.dark;
    final colorScheme =
        isDark ? state.theme.dark.colorScheme : state.theme.light.colorScheme;
    final primaryColor = ElevationOverlay.colorWithOverlay(
        colorScheme.surface, colorScheme.primary, 3);

    SystemChrome.setSystemUIOverlayStyle(
      createOverlayStyle(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
      ),
    );
  }

  @override
  Future<void> close() {
    _networkInfoSubscription?.cancel();
    _globalStateSubscription.cancel();
    _userSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
