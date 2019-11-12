import 'dart:ui';
import 'package:bubblesbreak/models/word.dart';
import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';

import 'package:bubblesbreak/bubble-game.dart';

class LearningDialog {
  final BubbleGame game;
  Rect dialogRect;
  Sprite dialogSprite;

  Rect overlayRect;

  Rect nextBtnRect;

  Animation nextButtonAni = Animation.sequenced("playing/nextButton.png", 3,
      textureHeight: 104, textureWidth: 500, stepTime: 0.1);

  Word word;

  LearningDialog(this.game, this.word) {

    dialogSprite = Sprite('playing/learningBG.png');
  }

  void render(Canvas canvas) {
    overlayRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    Paint overlayPaint = Paint();
    overlayPaint.color = Color(0xFF545454).withOpacity(0.5);

    canvas.drawRect(overlayRect, overlayPaint);

    dialogRect = Rect.fromCenter(
      center: new Offset(game.screenSize.width / 2,
          game.screenSize.height / 2),
      width: game.tileSize * 6,
      height: game.tileSize * 8);

    dialogSprite.renderRect(canvas, dialogRect);

    nextBtnRect = Rect.fromCenter(
      center: new Offset(game.screenSize.width / 2,
          game.screenSize.height / 2 + game.tileSize * 3),
      width: game.tileSize * 4,
      height: game.tileSize);

    nextButtonAni.getSprite().renderRect(canvas, nextBtnRect, overridePaint: Paint());
  }

  void update(double t) {
    nextButtonAni.update(t);
  }
}
