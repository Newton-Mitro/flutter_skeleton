import 'package:flutter/material.dart';
import 'package:tafaling/configs/values/colors/app_colors.dart';

class AppColorsLight extends AppColors {
  @override
  Color get primary => Color(0xFF015266);

  @override
  Color get primaryVariant => Color(0xFF002b35);

  @override
  Color get secondary => Colors.green;

  @override
  Color get secondaryVariant => Colors.greenAccent;

  @override
  Color get background => Color.fromARGB(255, 1, 72, 90);

  @override
  Color get surface => Colors.grey[100]!;

  @override
  Color get error => Colors.red;

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get onSecondary => Colors.black;

  @override
  Color get onBackground => Colors.black;

  @override
  Color get onSurface => Colors.black;

  @override
  Color get onError => Colors.white;

  @override
  MaterialColor get gray => MaterialColor(50, {
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEEEEEE),
        300: Color(0xFFE0E0E0),
        350: Color(0xFFD6D6D6),
        400: Color(0xFFBDBDBD),
        500: Color(0xFF9E9E9E),
        600: Color(0xFF757575),
        700: Color(0xFF616161),
        800: Color(0xFF424242),
        850: Color(0xFF303030),
        900: Color(0xFF212121),
      });
}
