import 'package:flutter/material.dart';

class ThemeColor {
  static Color kCyberPurple = Color(0xFF783C9A);
  static Color kCyberPink = Color(0xFFC5213F);
  static Color kCyberYellow = Color(0xFFF4AA2F);
  static Color kCyberBlue = Color(0xFF15324B);
}
class GlobalTheme {
  static Map<int, Color> kPinkSwatch = {
    50: Color(0xFFFFF0F1),
    100: Color(0xFFFF9Db5),
    200: Color(0xFFFB9099),
    300: Color(0xFFFB8099),
    400: Color(0xFFFB7599),
    500: Color(0xFFFB7299),
    600: Color(0xFFFB3299),
    700: Color(0xFFFB2299),
    800: Color(0xFFFB1299),
    900: Color(0xFFFB0099),
  };
  static Color biliPink = MaterialColor(500, kPinkSwatch);
  static ThemeData buildTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: kPinkSwatch[600],
      textSelectionColor: ThemeColor.kCyberPink,
      buttonTheme: primaryButtonTheme,
      backgroundColor: Color(0xFF0d0d0d),
      scaffoldBackgroundColor: Color(0xFF000000)
    );
  }

  static ButtonThemeData primaryButtonTheme = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    disabledColor: kPinkSwatch[100],
    height: 44,
    padding: EdgeInsets.all(0)
  );

  static List<BoxShadow> commonShadow({Color color = Colors.black12, double opacity = 0.08, Offset offset = const Offset(0.0, 3), double radius = 3.0}) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        offset: offset,
        blurRadius: 15,
      ),
    ];
  }

  static Border commonBorder ({Color color = Colors.black12}) {
    return Border.all(color: color, width: 1);
  }


  static BorderRadius commonRadius({double radius = 20}) {
    return BorderRadius.only(topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius));
  }
}