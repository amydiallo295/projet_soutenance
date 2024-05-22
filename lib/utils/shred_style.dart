// Flutter imports:
import 'package:flutter/material.dart';

// Box Decorations

BoxDecoration fieldDecortaion =
    BoxDecoration(borderRadius: defaultBorderRadius, color: Colors.grey[200]);

BoxDecoration disabledFieldDecortaion =
    BoxDecoration(borderRadius: defaultBorderRadius, color: Colors.grey[100]);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables
const TextStyle buttonTitleTextStyle =
    TextStyle(fontWeight: FontWeight.w700, color: Colors.white);

// Border Variables
const double chipBorder = 20;
const Radius defaultRadius = Radius.circular(1);
BorderRadius defaultBorderRadius = BorderRadius.circular(1);
BorderRadius defaultInputBorderRadius = BorderRadius.circular(3);
