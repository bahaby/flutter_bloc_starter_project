import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/generated/translations.g.dart';
import '../../models/post_model.dart';

import '../../../../core/utils/router.gr.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(PostDetailsRoute(postId: post.id));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              post.body,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              '${context.tr.posts.reactions}: ${post.reactions}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: post.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
