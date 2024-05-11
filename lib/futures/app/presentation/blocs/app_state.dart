part of 'app_bloc.dart';

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated;
}

@freezed
class AppState with _$AppState {
  const factory AppState({
    UserModel? currentUser,
    required bool isFirstLaunch,
    required bool isFirstLogin,
    required bool onboardingCompleted,
    required AuthStatus authStatus,
    required GlobalState globalState,
    required bool isInternetConnected,
    required AppLocale locale,
    required ThemeModel theme,
    AlertModel? alert,
  }) = _AppState;

  factory AppState.initial() => _AppState(
        isFirstLaunch: true,
        isFirstLogin: true,
        onboardingCompleted: false,
        authStatus: AuthStatus.initial,
        theme: di<ThemeModel>(),
        globalState: GlobalState.loaded,
        isInternetConnected: true,
        locale: AppLocale.en,
      );
}
