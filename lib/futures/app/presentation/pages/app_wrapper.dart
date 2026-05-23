import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_starter_project/core/generated/translations.g.dart';
import 'package:flutter_bloc_starter_project/core/utils/helpers/snack_bar_helper.dart';
import 'package:flutter_bloc_starter_project/futures/auth/repositories/auth_repository.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../../core/utils/router.gr.dart';
import '../blocs/app_bloc.dart';

@RoutePage()
class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppBloc>().add(const AppEvent.started());
    });

    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        return AbsorbPointer(
          absorbing: appState.globalState.isInteractionDisabled,
          child: Stack(
            children: [
              BlocListener<AppBloc, AppState>(
                listener: (context, state) {
                  if (state.authStatus == AuthStatus.authenticated) {
                    context.router.replace(const PostsWrapper());
                  } else if (state.authStatus == AuthStatus.unauthenticated) {
                    context.router.replace(const AuthWrapper());
                  }
                },
                child: RepaintBoundary(key: _key, child: const AutoRouter()),
              ),
              if (appState.globalState.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
