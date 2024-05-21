// Flutter imports:
import 'package:flutter/material.dart';

const Color lightGrey = Color.fromARGB(255, 61, 63, 69);
const Color darkGrey = Color.fromARGB(255, 18, 18, 19);
const Color backgroundColor = Color.fromARGB(255, 26, 27, 30);

// Candidate colors
const Color primaryColor = 
Colors.blue;
const appBarColor= Colors.redAccent;

//  Colors.orangeAccent;
//  Color.fromARGB(255, 19, 7, 110);

// // Pallete
class Palette {
  static const Color scaffold = Color(0xFFF0F2F5);

  static const Color facebookBlue = Color(0xFF1777F2);

  static const LinearGradient iconsGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 108, 104, 234),
      Color.fromARGB(255, 68, 64, 176),
      Color.fromARGB(255, 25, 10, 92),
      Color.fromARGB(255, 5, 2, 42),
    ],
  );

  static const LinearGradient indicatorGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 31, 4, 119),
      Color.fromARGB(255, 6, 1, 61),
    ],
  );
  static const LinearGradient appBarGradien = LinearGradient(
    colors: [appBarColor, Colors.orangeAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}

// Shades
const MaterialColor primaryColorLightShades = MaterialColor(
  0xFFF99622,
  <int, Color>{
    50: Color(0xFFfdd4b1),
    100: Color(0xFFffbf86),
    200: Color(0xFFffbf86),
  },
);
