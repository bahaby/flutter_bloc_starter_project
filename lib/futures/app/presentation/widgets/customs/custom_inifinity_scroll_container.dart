import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';

class CustomInfinityScrollContainer extends StatelessWidget {
  final bool isLoading;
  final bool hasMore;
  final VoidCallback onLoading;
  final Widget child;

  const CustomInfinityScrollContainer({
    super.key,
    required this.isLoading,
    required this.hasMore,
    required this.child,
    required this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent -
                constants.device.defaultLoadMoreOffset) {
          if (!isLoading && hasMore) {
            onLoading();
          }
        }
        return false;
      },
      child: child,
    );
  }
}
