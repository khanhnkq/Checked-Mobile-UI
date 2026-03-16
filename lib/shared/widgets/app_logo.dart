import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  
  const AppLogo({
    super.key,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD35A),
        borderRadius: BorderRadius.circular(size * 0.3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD35A).withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: 15,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.favorite,
          size: size * 0.6,
          color: const Color(0xFF12110B).withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
