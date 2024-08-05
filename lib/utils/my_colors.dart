import 'package:flutter/material.dart';

class MyColors {
  static const Color primaryGreen = Color.fromRGBO(159, 255, 87, 0.32);
  static const Color darkBackground = Color.fromRGBO(42, 43, 42, 1);
  static const Color green = Color.fromRGBO(159, 255, 87, 1);
  static const Color lightGreen = Color.fromRGBO(159, 255, 87, 1);
  static const Color grey = Color.fromRGBO(255, 255, 255, 0.64);
  static const List<Color> connectedButtonColorList = [
    Colors.green,
    Colors.greenAccent
  ];
  static List<Color> disConnectedButtonColorList = [
    Colors.black.withOpacity(0.4),
    Colors.grey
  ];
}
