import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core colors
  static const Color primary = Color(0xFFDDF0C0);
  static const Color accent = Color(0xFFAAD887);
  static const Color background = Color(0xFFFFFFFF);
  
  // Surface / Card colors (Sắc độ xanh nhạt/trắng theo yêu cầu)
  static const Color surface = Color(0xFFF4F9EC);
  static const Color surfaceHighlight = Color(0xFFEAF4DC);

  // Text colors
  static const Color text = Color(0xFF1A1A1A); // Dark text for light theme
  static const Color textSecondary = Color(0xFF757575);
  
  // Other semantics
  static const Color error = Color(0xFFE57373);
  static const Color success = Color(0xFF81C784);
  static const Color divider = Color(0xFFE0E0E0);
}
