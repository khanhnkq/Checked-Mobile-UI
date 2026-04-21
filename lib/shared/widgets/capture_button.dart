import 'package:flutter/material.dart';
import 'package:locket/core/theme/app_colors.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const CaptureButton({super.key, required this.onTap, this.size = 84});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        size: Size(size, size),
        painter: CaptureButtonPainter(),
      ),
    );
  }
}

class CaptureButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final outerPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..isAntiAlias = true;

    canvas.drawCircle(center, size.width / 2 - 3, outerPaint);

    final innerPaint = Paint()
      ..color = AppColors.text
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawCircle(center, size.width / 2 - 11, innerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
