import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryBlue = Color(0xFF14123A); // Slightly adjusted blue
  static const Color secondaryBlue = Color(0xFF5dade2);
  static const Color backgroundColor = Color(0xFF201B51);
  static const Color textColor = Color(0xFFECF0F1); // Dark blue-gray for text
  static const Color inputFieldColor = Color(0xFFECF0F1);
  static const Color borderColor = Color(0xFFBDC3C7); // Light gray for borders
  static const Color buttonColor = Color(0xFF3498db); // Same as primaryBlue
  static const Color linkColor = Color(0xFF2980b9); // Darker blue for links
  static const Color mainColor = Color(0xFF2c3e50);
  static const Color secColor = Color(0xFFf1c40f); // Bright yellow for accents
  static const Color thirdColor = Color(0xFFe8daef);
  static const Color navColor = Color(0xFFECF0F1);
  static const Color secondaryText = Color(0xFF7f8c8d);
  static const Color successColor = Color(0xFF2ecc71);
  static const Color errorColor = Color(0xFFe74c3c); // Red for error messages
  static const Color warningColor = Color(0xFFf39c12); // Orange for warnings
  static const Color disabledColor = Color(0xFF95a5a6);

    static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, secondaryBlue],
  );
}
