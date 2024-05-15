import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/build_context_extensions.dart';

import '../../../../../core/utils/constants.dart';

class MaterialSplashTappable extends StatelessWidget {
  const MaterialSplashTappable(
      {super.key, this.radius, this.onTap, required this.child});

  final double? radius;
  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(
            radius ?? constants.theme.defaultBorderRadius,
          ),
        ),
        overlayColor: WidgetStateProperty.all(
            context.customOnPrimaryColor.withOpacity(0.1)),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
