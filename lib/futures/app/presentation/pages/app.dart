import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../../core/generated/translations.g.dart';
import '../blocs/app_bloc.dart';
import '../../../../core/modules/observers/custom_route_observer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/modules/dependency_injection/di.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/methods/aliases.dart';
import '../../../auth/presentation/blocs/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // add singleton blocs here
      providers: [
        BlocProvider(
          create: (context) => di<AppBloc>(),
        ),
        BlocProvider(
          create: (context) => di<AuthBloc>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => p.theme != c.theme || p.locale != c.locale,
        builder: (context, state) {
          return MaterialApp.router(
            /// Theme configuration.
            theme: state.theme.light,
            darkTheme: state.theme.dark,
            themeMode: state.theme.mode,

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
