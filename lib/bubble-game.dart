import 'dart:ui';
import 'package:bubblesbreak/components/bubbles-world.dart';
import 'package:flame/animation.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:bubblesbreak/components/background.dart';

import 'package:flame/animation.dart' as animation;
import 'package:flame/sprite.dart';
import 'package:flame/position.dart';

class BubbleGame extends Game {
  final BubblesWorld world = new BubblesWorld();

  Size screenSize;
  double tileSize;
  Background background;

  BubbleGame() {
    initialize();
    world.initializeWorld();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    background = Background(this);
    world.resize(size);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    world.render(canvas);
  }

  @override
  void update(double t) {
    world.update(t);
  }

  void onTapDown(TapDownDetails d) {
    world.onTapDown(d);
  }
}