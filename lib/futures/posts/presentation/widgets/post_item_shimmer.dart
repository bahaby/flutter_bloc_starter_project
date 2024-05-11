import 'package:flutter/material.dart';
import '../../../app/presentation/widgets/tools/skeleton_loader.dart';

class PostItemShimmer extends StatelessWidget {
  const PostItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: ShimmerBlock(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        opacity: 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBlock(height: 16, width: 250, opacity: 1, mb: 10),
            for (var i = 0; i < 5; i++) const ShimmerBlock(height: 14, mb: 5),
            const ShimmerBlock(height: 14, width: 250, mb: 10),
            const ShimmerBlock(height: 14, width: 100, opacity: 1, mb: 10),
            Row(
              children: [
                for (var i = 0; i < 3; i++)
                  const ShimmerBlock(height: 36, width: 80, mr: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
