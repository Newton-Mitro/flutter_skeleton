import 'package:flutter/material.dart';
import 'package:tafaling/configs/values/colors/app_colors.dart';

class AppColorsDark extends AppColors {
  @override
  Color get primary => const Color(0xFF1F292E);

  @override
  Color get primaryVariant => const Color(0xFF0E1214);

  @override
  Color get secondary => const Color.fromARGB(255, 21, 31, 36);

  @override
  Color get secondaryVariant => Colors.tealAccent;

  @override
  Color get background => Colors.grey[900]!;

  @override
  Color get surface => Colors.grey[900]!;

  @override
  Color get error => Colors.redAccent;

  @override
  Color get onPrimary => const Color.fromARGB(255, 144, 183, 204);

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get onBackground => Colors.white;

  @override
  Color get onSurface => Colors.white;

  @override
  Color get onError => Colors.black;

  @override
  Color get disabled => const Color.fromARGB(255, 145, 153, 158);

  @override
  Color get selected => const Color.fromARGB(255, 169, 223, 252);

  @override
  Color get unSelected => const Color.fromARGB(255, 144, 183, 204);

  @override
  MaterialColor get gray => MaterialColor(50, {
        50: Color(0xFFEDEDED),
        100: Color(0xFFD6D6D6),
        200: Color(0xFFBDBDBD),
        300: Color(0xFF9E9E9E),
        350: Color(0xFF868686),
        400: Color(0xFF757575),
        500: Color(0xFF616161),
        600: Color(0xFF4E4E4E),
        700: Color(0xFF3B3B3B),
        800: Color(0xFF2C2C2C),
        850: Color(0xFF1F1F1F),
        900: Color(0xFF121212),
      });
}
