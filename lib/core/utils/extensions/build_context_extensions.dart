import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../futures/app/presentation/blocs/app_bloc.dart';

extension BuildContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  double get sliverAppBarHeight => statusBarHeight + kToolbarHeight;

  ColorScheme get themeScheme => Theme.of(this).colorScheme;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  TextTheme get textThemeScheme => Theme.of(this).textTheme;

  Color get primaryColorOverlay => ElevationOverlay.colorWithOverlay(
      themeScheme.surface, themeScheme.primary, 3);

  Color get customOnPrimaryColor => themeScheme.primary.withOpacity(0.5);

  bool get isUserLoggedIn {
    try {
      return read<AppBloc>().state.currentUser != null;
    } catch (_) {
      return false;
    }
  }
}
