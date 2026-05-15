import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color background = Color(0xFF0D0D0D); // Deep Black
  static const Color surface = Color(0xFF1A1A1A); // Charcoal
  static const Color surfaceLight = Color(0xFF262626); // Lighter Charcoal
  static const Color primary = Color(0xFFC5A365); // Muted Gold
  static const Color primaryDark = Color(0xFF8B7345);
  static const Color secondary = Color(0xFF1E3A5F); // Deep Blue
  static const Color accent = Color(0xFFE0E0E0); // Silver Accents
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF2F2F2);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textMuted = Color(0xFF616161);
  
  // Semantic
  static const Color error = Color(0xFFCF6679);
  static const Color success = Color(0xFF81C784);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cosmicGradient = LinearGradient(
    colors: [secondary, background],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
