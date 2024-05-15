import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_starter_project/core/modules/dependency_injection/di.dart';
import '../../../app/presentation/pages/app_drawer.dart';
import '../../../app/presentation/widgets/default_app_bar.dart';
import '../blocs/auth_bloc.dart';

@RoutePage()
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthBloc>(),
      child: const Scaffold(
        endDrawer: AppDrawer(),
        appBar: DefaultAppBar(),
        body: AutoRouter(),
      ),
    );
  }
}
