import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/build_context_extensions.dart';

import '../../../../../core/utils/constants.dart';

class CustomContainerTransform extends StatelessWidget {
  const CustomContainerTransform({
    super.key,
    required this.closedBuilder,
    this.openWidget,
    this.closedBorderRadius,
  });

  final Widget Function(BuildContext, void Function()) closedBuilder;
  final Widget? openWidget;
  final double? closedBorderRadius;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: constants.theme.defaultElevation,
      openElevation: constants.theme.defaultElevation,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(
            closedBorderRadius ?? constants.theme.defaultBorderRadius)),
      ),
      closedColor: context.themeScheme.surface,
      openColor: context.themeScheme.surface,
      middleColor: context.themeScheme.surface,
      tappable: openWidget != null,
      openBuilder: (context, _) => openWidget ?? const SizedBox(),
      closedBuilder: closedBuilder,
    );
  }
}
