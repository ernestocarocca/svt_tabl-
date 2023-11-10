import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AIColors {
  static final List<Color> primaryColors = [
    Vx.orange600,
    Vx.purple500,
    Vx.teal500,
    Vx.blue500,
    Vx.pink500,
    Vx.green500,
    Vx.red500,
    Vx.indigo500,
    Vx.cyan700,
    Vx.blue800,
    Vx.green800,
    Vx.purple800,
  ];

  Color getColor(int index) {
    if (index >= 0 && index < primaryColors.length) {
      return primaryColors[index];
    }
    return Colors.black;
  }
}
