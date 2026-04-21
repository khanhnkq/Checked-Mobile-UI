import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:locket/core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showShadow;

  const AppLogo({super.key, this.size = 120, this.showShadow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 40,
                  spreadRadius: 12,
                ),
              ]
            : null,
      ),
      child: SvgPicture.asset(
        'assets/logo/app_logo.svg',
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
