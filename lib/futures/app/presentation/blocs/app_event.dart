part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.started() = _Started;
  const factory AppEvent.changeThemeMode(ThemeMode mode) = _ChangeThemeMode;
  const factory AppEvent.changeThemeColor(Color color) = _ChangeThemeColor;
  const factory AppEvent.changeLocale(AppLocale locale) = _ChangeLocale;
  const factory AppEvent.userLogout() = _UserLogout;
  const factory AppEvent.firstLaunchCompleted() = _FirstLaunchCompleted;
  const factory AppEvent.firstLoginCompleted() = _FirstLoginCompleted;
  const factory AppEvent.onboardingCompleted() = _OnboardingCompleted;

  /// this should be a private event only accessable by the app bloc
  const factory AppEvent.internetStatusChanged(bool isConnected) =
      _InternetStatusChanged;

  /// this should be a private event only accessable by the app bloc
  const factory AppEvent.globalStateChanged(GlobalState state) =
      _GlobalStateChanged;

  /// this should be a private event only accessable by the app bloc
  const factory AppEvent.loggedUserChanged(UserModel? user) =
      _LoggedUserChanged;

  /// this should be a private event only accessable by the app bloc
  const factory AppEvent.authStatusChanged(AuthStatus status) =
      _AuthStatusChanged;
}
