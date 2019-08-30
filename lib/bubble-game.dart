import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:bubblesbreak/components/background.dart';

class BubbleGame extends Game {
  Size screenSize;
  double tileSize;
  Background background;


  BubbleGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    background = Background(this);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
  }

  @override
  void update(double t) {
  }

}