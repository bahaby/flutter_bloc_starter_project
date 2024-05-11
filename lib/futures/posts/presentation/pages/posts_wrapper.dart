import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/generated/translations.g.dart';
import '../blocs/post_details_bloc.dart';
import '../blocs/posts_list_bloc.dart';

import '../../../../core/modules/dependency_injection/di.dart';
import '../../../app/presentation/pages/app_drawer.dart';
import '../../../app/presentation/widgets/default_app_bar.dart';

@RoutePage()
class PostsWrapper extends StatelessWidget {
  const PostsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<PostsListBloc>()),
        BlocProvider(create: (context) => di<PostDetailsBloc>()),
      ],
      child: Scaffold(
        appBar: DefaultAppBar(title: context.tr.posts.posts),
        endDrawer: const AppDrawer(),
        body: const AutoRouter(),
      ),
    );
  }
}
