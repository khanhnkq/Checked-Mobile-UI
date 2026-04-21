import 'package:flutter/material.dart';
import 'painters.dart';
import 'package:locket/core/theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;
  final Color? color;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
    this.iconSize = 22,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        painter: CircleBackgroundPainter(
          color: color ?? AppColors.text.withValues(alpha: 0.15),
        ),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(
              icon,
              color: AppColors.text,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
