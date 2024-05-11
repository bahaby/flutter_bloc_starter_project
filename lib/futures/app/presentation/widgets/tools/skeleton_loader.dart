import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/build_context_extensions.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    super.key,
    required this.child,
    this.isActive = true,
    this.baseColor,
    this.highlightColor,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(seconds: 2),
  });

  final Color? baseColor;
  final Widget child;
  final ShimmerDirection direction;
  final Color? highlightColor;
  final bool isActive;
  final Duration period;

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Shimmer.fromColors(
        baseColor: baseColor ?? context.themeScheme.primary.withOpacity(0.1),
        highlightColor:
            highlightColor ?? context.themeScheme.primary.withOpacity(0.25),
        direction: direction,
        period: period,
        child: child,
      );
    } else {
      return child;
    }
  }
}

class ShimmerBlock extends StatelessWidget {
  final double? height;
  final double width;
  final double radius;
  final double opacity;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double mb, mt, ml, mr;
  const ShimmerBlock({
    super.key,
    this.height,
    this.width = double.infinity,
    this.radius = 8,
    this.opacity = 0.7,
    this.child,
    this.margin,
    this.padding,
    this.mb = 0,
    this.mt = 0,
    this.ml = 0,
    this.mr = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? EdgeInsets.fromLTRB(ml, mt, mr, mb),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
