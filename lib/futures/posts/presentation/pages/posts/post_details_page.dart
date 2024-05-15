import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/generated/translations.g.dart';
import '../../../../../core/utils/helpers/snack_bar_helper.dart';
import '../../../../app/presentation/blocs/generic_fetch_bloc/generic_fetch_bloc.dart';
import '../../../models/post_model.dart';
import '../../widgets/post_detail_shimmer.dart';

import '../../blocs/post_details_bloc.dart';

@RoutePage()
class PostDetailsPage extends StatefulWidget {
  final int postId;
  const PostDetailsPage({
    super.key,
    required this.postId,
  });

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  void initState() {
    context
        .read<PostDetailsBloc>()
        .add(GenericFetchEvent.refresh(widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostDetailsBloc, GenericFetchState<PostModel>>(
      listener: (context, state) {
        switch (state) {
          case Failed(:final alert):
            context.router.maybePop();
            SnackBarHelper.showAlert(
              context,
              alert: alert,
            );
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case Loaded(:final item):
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        item.body,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      Wrap(
                        spacing: 8.0,
                        children: item.tags
                            .map((tag) => Chip(label: Text(tag)))
                            .toList(),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '${context.tr.posts.reactions}: ${item.reactions}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            );
          case Loading():
            return const PostDetailsShimmer();
          case Failed():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.tr.core.errors.others.noItemFound),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<PostDetailsBloc>()
                          .add(GenericFetchEvent.refresh(widget.postId));
                    },
                    child: Text(context.tr.core.actions.retry),
                  ),
                ],
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
