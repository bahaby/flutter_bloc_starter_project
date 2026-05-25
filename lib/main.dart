import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/generated/translations.g.dart';
import 'futures/app/presentation/pages/app.dart';
import 'core/modules/observers/custom_bloc_observer.dart';
import 'core/modules/dependency_injection/di.dart';
import 'core/modules/sentry/sentry_module.dart';
import 'core/theme/dimens/app_dimen.dart';
import 'core/utils/constants.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      // Preserve splash screen until authentication complete.
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Use device locale.
      LocaleSettings.useDeviceLocale();

      // Configures dependency injection to init modules and singletons.

      await configureDependencyInjection();
      await di.allReady();

      if (Platform.isAndroid || Platform.isIOS) {
        // Sets up allowed device orientations and other settings for the app.
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }

      // Sets system overylay style.
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
      );

      // Inits sentry for error tracking.
      await initializeSentry();

      // Set bloc observer
      Bloc.observer = CustomBlocObserver();

      return runApp(
        // Sentry's performance tracing for AssetBundles.
        DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: ScreenUtilInit(
            designSize: Size(
              constants.device.designDeviceWidth,
              constants.device.designDeviceHeight,
            ),
            builder: (context, child) {
              AppDimen.of(context);
              return TranslationProvider(child: const App());
            },
          ),
        ),
      );
    },
    (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    },
  );
}
