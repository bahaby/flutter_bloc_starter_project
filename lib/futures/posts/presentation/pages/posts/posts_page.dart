import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/presentation/blocs/generic_list_bloc/generic_list_bloc.dart';
import '../../../models/post_model.dart';
import '../../blocs/posts_list_bloc.dart';
import '../../../../app/presentation/widgets/customs/custom_inifinity_scroll_container.dart';
import '../../widgets/post_item.dart';

import '../../widgets/post_item_shimmer.dart';

@RoutePage()
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    context
        .read<PostsListBloc>()
        .add(const GenericListEvent<PostModel>.refresh());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsListBloc, GenericListState<PostModel>>(
      builder: (context, state) {
        switch (state) {
          case Loading():
            return _buildPostsShimmer();
          case LoadingMore(:final items):
            return _buildPosts(items, isLoadingMore: true);
          case Loaded(:final items, :final hasMore):
            return _buildPosts(items, hasMore: hasMore);
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildPostsShimmer() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return const PostItemShimmer();
      },
    );
  }

  Widget _buildPosts(List<PostModel> posts,
      {bool isLoadingMore = false, bool hasMore = true}) {
    return CustomInfinityScrollContainer(
      hasMore: hasMore,
      onLoading: () {
        context.read<PostsListBloc>().add(GenericListEvent.loadMore(posts));
      },
      isLoading: isLoadingMore,
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<PostsListBloc>().add(const GenericListEvent.refresh());
        },
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: posts.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == posts.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final post = posts[index];
            return PostItem(post: post);
          },
        ),
      ),
    );
  }
}
