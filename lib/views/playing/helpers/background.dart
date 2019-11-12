import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:bubblesbreak/bubble-game.dart';

class Background {
  final BubbleGame game;
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite = Sprite('playing/background.png');

    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 15),
      game.tileSize * 7,
      game.tileSize * 15,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
