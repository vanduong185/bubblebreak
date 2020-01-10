import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPallet {
  static const white = Colors.white;
  static const orange = Color(0xFFF47B2A);
  static const grey = Color(0xFF545454);
}

class Theme {
  static const List<Shadow> textBubbleShadow = <Shadow>[
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(0, 1.5),
    ),
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(1.5, 0),
    ),
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(0, -1.5),
    ),
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(-1.5, 0),
    ),
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(1.5, -1.5),
    ),
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(-1.5, -1.5),
    ),
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(-1.5, 1.5),
    ),
    Shadow(
      color: ColorPallet.orange,
      offset: Offset(1.5, 1.5),
    ),
  ];
}
