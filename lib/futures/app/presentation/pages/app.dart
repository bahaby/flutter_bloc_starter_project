import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';
import 'package:flutter_bloc_starter_project/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../../core/generated/translations.g.dart';
import '../blocs/app_bloc.dart';
import '../../../../core/modules/observers/custom_route_observer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/methods/aliases.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AppBloc>(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            /// Theme configuration.
            theme: createTheme(color: state.color, mode: state.themeMode),
            darkTheme: createTheme(color: state.color, mode: ThemeMode.dark),
            themeMode: state.themeMode,

            /// Environment configuration.
            title: constants.appTitle,
            debugShowCheckedModeBanner: env.debugShowCheckedModeBanner,
            debugShowMaterialGrid: env.debugShowMaterialGrid,
            routerConfig: appRouter.config(
              navigatorObservers: () => [
                CustomRouteObserver(),
                SentryNavigatorObserver(),
              ],
            ),
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          );
        },
      ),
    );
  }
}
