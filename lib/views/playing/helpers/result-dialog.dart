import 'dart:ui';
import 'package:bubblesbreak/configs/configs.dart';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart' as flamePosition;
import 'package:flame/text_config.dart';

import 'package:bubblesbreak/bubble-game.dart';
import 'package:bubblesbreak/models/word.dart';

class ResultDialog {
  final BubbleGame game;
  Rect dialogRect;
  Sprite dialogSprite;

  Rect overlayRect;

  Rect replayBtnRect;
  Animation replayButtonAni;

  ResultDialog(this.game) {
    dialogSprite = Sprite('playing/resultBG2.png');

    replayButtonAni = Animation.sequenced("playing/resultButton.png", 3,
        textureHeight: 104, textureWidth: 504, stepTime: 0.1);
  }

  void render(Canvas canvas) {
    overlayRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    Paint overlayPaint = Paint();
    overlayPaint.color = Color(0xFF545454).withOpacity(0.5);

    canvas.drawRect(overlayRect, overlayPaint);

    dialogRect = Rect.fromCenter(
        center:
            new Offset(game.screenSize.width / 2, game.screenSize.height / 2),
        width: game.tileSize * 5,
        height: game.tileSize * 8);

    dialogSprite.renderRect(canvas, dialogRect);

    replayBtnRect = Rect.fromCenter(
        center: new Offset(game.screenSize.width / 2,
            game.screenSize.height / 2 + game.tileSize * 3),
        width: game.tileSize * 4,
        height: game.tileSize);

    replayButtonAni
        .getSprite()
        .renderRect(canvas, replayBtnRect, overridePaint: Paint());
  }

  void update(double t) {
    //nextButtonAni.update(t);
  }
}
