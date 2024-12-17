import 'package:flutter/material.dart';

class AppStyles {
  static Color bgColor = const Color(0xFFE3F2FD);
  static Color primary = const Color(0xFF0D47A1);
  static Color secondary = const Color(0xFF448AFF);
  static Color tertiary = const Color(0xFFBBDEFB);
  static Color blocked = const Color(0xFF424242);
  // static Color borderColor = const Color(0xFF90CAF9);
  static TextStyle headLineStyle1 =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w700);
  static TextStyle headLineStyle2 = const TextStyle(fontSize: 25);
  static TextStyle headLineStyle2_0 = const TextStyle(fontSize: 20);
  static TextStyle headLineStyle3 = const TextStyle(fontSize: 17);
  static TextStyle headLineStyle3_0 =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static TextStyle headLineStyle4 = const TextStyle(fontSize: 15);

  static BoxDecoration inputBoxShadowStyle = BoxDecoration(
    // color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ],
  );

  static BoxDecoration dropDownShadowStyle = BoxDecoration(
    color: Colors.white,
    // borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 4,
        offset: const Offset(0, 4),
      ),
    ],
  );

// errorBorder: const

  static OutlineInputBorder errorBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  // static BoxDecoration searchBoxStyle = BoxDecoration(
  //   color: Colors.white,
  //   boxShadow: const [
  //     BoxShadow(
  //       color: Colors.grey,
  //       spreadRadius: 1,
  //       blurRadius: 5, // Increased blur radius
  //       offset: Offset(0, 3),
  //     ),
  //   ],
  //   borderRadius: BorderRadius.circular(8),
  // );

}
