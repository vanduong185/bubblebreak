import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:bubblesbreak/bubble-game.dart';

class StageWordTypeAni {
  final BubbleGame game;
  Rect rect;
  Sprite sprite;

  String type;

  double endPoint;
  bool isAtEndPoint;

  StageWordTypeAni(this.game) {
    resize();
    isAtEndPoint = false;
    endPoint = game.screenSize.height / 2 - game.tileSize * 2;
  }

  void setType(String type) {
    this.type = type;

    if (this.type == "verb") sprite = Sprite('playing/ani_verb.png');

    if (this.type == "adjective") sprite = Sprite('playing/ani_adjective.png');

    if (this.type == "noun") sprite = Sprite('playing/ani_noun.png');
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  void update(double t) {
    if (!isAtEndPoint) {
      rect = rect.translate(0, -2);

      if (rect.top < endPoint) {
        isAtEndPoint = true;
      }
    }
  }

  void resize() {
    rect = Rect.fromCenter(
        center:
            new Offset(game.screenSize.width / 2, game.screenSize.height / 2),
        width: game.tileSize * 2,
        height: game.tileSize);
  }
}
