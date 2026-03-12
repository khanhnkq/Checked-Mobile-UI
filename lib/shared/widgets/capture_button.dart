import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const CaptureButton({
    super.key,
    required this.onTap,
    this.size = 84,
  });

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
      ..color = const Color(0xFFFFD35A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..isAntiAlias = true;
    
    canvas.drawCircle(center, size.width / 2 - 3, outerPaint);

    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    
    canvas.drawCircle(center, size.width / 2 - 11, innerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
