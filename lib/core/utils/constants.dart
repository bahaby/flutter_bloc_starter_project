import 'package:flutter/material.dart';

final constants = Constants();

@immutable
class Constants {
  final appTitle = 'Flutter Starter App';

  /// Theme defaults.
  final theme = _Theme();

  /// Animation durations.
  final times = _Times();

  /// Rounded edge corner radiuses.
  final corners = _Corners();

  /// Padding and margin values.
  final insets = _Insets();

  /// Text shadows.
  final shadows = _Shadows();

  /// Color constants.palette.
  final palette = _Palette();

  /// API configuration.
  final api = _API();

  /// Validation configuration.
  final validation = _Validation();

  /// Device configuration.
  final device = _Device();

  /// Cache keys.
  final cacheKeys = _CacheKeys();

  /// Debug configuration.
  final debug = _Debug();
/* 
  /// Navigation configuration.
   final navigation = _Navigation(); */
}

@immutable
class _Validation {
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  final passwordMinLength = 6;
  final passwordMaxLength = 128;

  final nameMinLength = 2;
  final nameMaxLength = 64;

  final titleMaxLength = 128;
  final shortnameMaxLength = 256;
  final descriptionMaxLength = 1024;

  final questionTitleMaxLength = 256;

  final usernameMaxLength = 64;
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  final double sm = 4;
  final double md = 8;
  final double lg = 32;
}

@immutable
class _Insets {
  final double xxs = 4;
  final double xs = 8;
  final double sm = 16;
  final double md = 24;
  final double lg = 32;
  final double xl = 48;
  final double xxl = 56;
  final double offset = 80;
}

class _CacheKeys {
  final String isFirstLogin = 'isFirstLogin';
  final String isFirstLaunchApp = 'isFirstLaunchApp';
  final String languageCode = 'languageCode';
  final String onboardingCompleted = 'onboardingCompleted';
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
      color: Colors.black.withOpacity(0.25),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];
  final text = [
    Shadow(
      color: Colors.black.withOpacity(0.6),
      offset: const Offset(0, 2),
      blurRadius: 2,
    ),
  ];
  final textStrong = [
    Shadow(
      color: Colors.black.withOpacity(0.6),
      offset: const Offset(0, 4),
      blurRadius: 6,
    ),
  ];
}

@immutable
class _Palette {
  final List<Color> themes = [
    const Color(0xFFFF0000),
    const Color(0xFFFF8000),
    const Color(0xFFFCCC1A),
    const Color(0xFF66B032),
    const Color(0xFF00FFFF),
    const Color(0xFF0000FF),
    const Color(0xFF0080FF),
    const Color(0xFFFF00FF),
  ];

  final white = const Color(0xFFFFFFFF);
  final black = const Color(0xFF000000);
  final grey = const Color(0xFF9E9E9E);
  final red = const Color(0xFFFF0000);
  final orange = const Color(0xFFFF8000);
  final yellow = const Color(0xFFFCCC1A);
  final green = const Color(0xFF66B032);
  final cyan = const Color(0xFF00FFFF);
  final blue = const Color(0xFF0000FF);
  final purple = const Color(0xFF0080FF);
  final magenta = const Color(0xFFFF00FF);
}

@immutable
class _Theme {
  final tryToGetColorPaletteFromWallpaper = true;
  final defaultThemeColor = const Color(0xFF0000FF);
  final defaultFontFamily = 'Ubuntu';
  final double defaultElevation = 0;
  final double defaultBorderRadius = 24;
}

@immutable
class _API {
  final maxItemToBeFetchedAtOneTime = 5;
  final timeOutDuration = const Duration(seconds: 10);
}

@immutable
class _Device {
  final designDeviceWidth = 375.0;
  final designDeviceHeight = 667.0;

  final maxMobileWidth = 450;
  final maxTabletWidth = 900;

  final maxMobileWidthForDeviceType = 550;

  final defaultLoadMoreOffset = 200;
}

@immutable
class _Debug {
  final int maxLogLines = 140;
}
