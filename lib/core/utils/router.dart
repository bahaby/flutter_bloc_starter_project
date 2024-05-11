import 'package:auto_route/auto_route.dart';
import 'constants.dart';
import 'package:injectable/injectable.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@singleton
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppWrapper.page,
          initial: true,
          children: [
            AutoRoute(page: AuthWrapper.page, children: [
              AutoRoute(page: LoginRoute.page, initial: true),
            ]),
            AutoRoute(page: PostsWrapper.page, children: [
              AutoRoute(page: PostsRoute.page, initial: true),
              CustomRoute(
                  page: PostDetailsRoute.page,
                  transitionsBuilder: TransitionsBuilders.fadeIn,
                  durationInMilliseconds:
                      constants.times.pageTransition.inMilliseconds),
            ]),
          ],
        ),
      ];
}
