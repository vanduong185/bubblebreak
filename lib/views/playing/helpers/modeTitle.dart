import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:bubblesbreak/bubble-game.dart';

class ModeTitle {
  final BubbleGame game;
  Rect rect;
  Sprite sprite;

  String type;

  ModeTitle(this.game) {
    sprite = Sprite('playing/trainingTitle.png');
    resize();
  }

  void setType(String type) {
    this.type = type;
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromCenter(
      center: new Offset(game.screenSize.width / 2, game.tileSize),
      width: game.tileSize * 4,
      height: game.tileSize*0.5);
  }
}
