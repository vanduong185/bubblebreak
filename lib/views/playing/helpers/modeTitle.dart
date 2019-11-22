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
    rect = Rect.fromCenter(
      center: new Offset(game.screenSize.width / 2, game.tileSize / 2),
      width: game.tileSize * 4,
      height: game.tileSize / 2);

    sprite.renderRect(canvas, rect);
  }

  void update(double t) {}

  void resize() {
    
  }
}
