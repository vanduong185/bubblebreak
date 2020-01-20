import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:bubblesbreak/bubble-game.dart';

class StageWordType {
  final BubbleGame game;
  Rect rect;
  Sprite sprite;

  String type;

  StageWordType(this.game) {
    resize();
  }

  void setType(String type) {
    this.type = type;

    if (this.type == "verb") sprite = Sprite('playing/verbSubject.png');

    if (this.type == "adjective") sprite = Sprite('playing/adjectiveSubject.png');

    if (this.type == "noun") sprite = Sprite('playing/nounSubject.png');
  }

  void render(Canvas canvas) {
    rect = Rect.fromCenter(
        center: new Offset(game.screenSize.width / 2,
            game.screenSize.height - game.tileSize * 0.5),
        width: game.tileSize * 1.5,
        height: game.tileSize * 0.8);

    sprite.renderRect(canvas, rect);
  }

  void update(double t) {}

  void resize() {
    
  }
}
