import 'package:flutter/material.dart';

class AppStyles {
  static Color bgColor = const Color(0xFFE3F2FD);
  static Color primary = const Color(0xFF0D47A1);
  static Color secondary = const Color(0xFF448AFF);
  static Color tertiary = const Color(0xFFBBDEFB);
  static TextStyle headLineStyle1 =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w700);
  static TextStyle headLineStyle2 = const TextStyle(fontSize: 25);
  static TextStyle headLineStyle2_0 = const TextStyle(fontSize: 20);
  static TextStyle headLineStyle3 = const TextStyle(fontSize: 17);
  static TextStyle headLineStyle3_0 =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  // static Container searchBoxStyle = Container(
  //   height: 50,
  //   decoration:
  // );

  static BoxDecoration searchBoxStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  );
}
