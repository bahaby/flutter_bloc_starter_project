part of 'app_bloc.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    AuthModel? currentUser,
    required bool isFirstLaunch,
    required bool isFirstLogin,
    required bool onboardingCompleted,
    required AuthStatus authStatus,
    required GlobalState globalState,
    required bool isInternetConnected,
    required AppLocale locale,

    required Color color,
    required ThemeMode themeMode,

    AlertModel? alert,
  }) = _AppState;

  factory AppState.initial() => _AppState(
    isFirstLaunch: true,
    isFirstLogin: true,
    onboardingCompleted: false,
    authStatus: AuthStatus.initial,
    color: Colors.blue,
    themeMode: ThemeMode.dark,
    globalState: GlobalState.loaded,
    isInternetConnected: true,
    locale: AppLocale.en,
  );
}
