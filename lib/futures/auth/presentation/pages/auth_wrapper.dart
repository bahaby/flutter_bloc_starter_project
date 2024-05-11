import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../app/presentation/pages/app_drawer.dart';
import '../../../app/presentation/widgets/default_app_bar.dart';

@RoutePage()
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: AppDrawer(),
      appBar: DefaultAppBar(),
      body: AutoRouter(),
    );
  }
}
