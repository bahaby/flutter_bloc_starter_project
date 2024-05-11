import 'package:flutter/material.dart';

import '../../../app/presentation/widgets/tools/skeleton_loader.dart';

class PostDetailsShimmer extends StatelessWidget {
  const PostDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Column(
        children: [
          ShimmerBlock(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(20),
            radius: 28,
            opacity: 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBlock(
                    height: 28, width: 250, opacity: 1, mb: 10), // Title
                const SizedBox(height: 16.0),
                const ShimmerBlock(
                    height: 28, width: 200, opacity: 1, mb: 10), // Title
                const SizedBox(height: 16.0),
                for (var i = 0; i < 8; i++)
                  const ShimmerBlock(height: 16, mb: 5), // Body
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    for (var i = 0; i < 3; i++)
                      const ShimmerBlock(height: 32, width: 80, mr: 10), // Tags
                  ],
                ),
                const SizedBox(height: 20.0),
                const ShimmerBlock(
                    height: 14, width: 100, opacity: 1, mb: 10), // Reactions
              ],
            ),
          ),
        ],
      ),
    );
  }
}
