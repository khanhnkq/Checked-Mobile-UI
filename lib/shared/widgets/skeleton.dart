import 'package:flutter/material.dart';
import 'package:locket/core/theme/app_colors.dart';

class SkeletonBox extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;

  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
    );

    if (margin != null) {
      child = Padding(padding: margin!, child: child);
    }

    return child;
  }
}

class SkeletonButton extends StatelessWidget {
  final double height;
  final double borderRadius;

  const SkeletonButton({super.key, this.height = 54, this.borderRadius = 28});

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: double.infinity,
      height: height,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}
