import 'dart:ui';
import 'package:bubblesbreak/configs/configs.dart';
import 'package:bubblesbreak/configs/theme.dart';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart' as flamePosition;
import 'package:flame/text_config.dart';

import 'package:bubblesbreak/bubble-game.dart';
import 'package:flutter/painting.dart';

class TimeUpDialog {
  final BubbleGame game;
  Rect dialogRect;
  double dialogRectWidth;
  double dialogRectMaxWidth;
  double dialogRectHeight;
  double dialogRectMaxHeight;

  Sprite dialogSprite;

  Rect overlayRect;

  Rect nextBtnRect;

  Animation nextButtonAni;

  TimeUpDialog(this.game) {
    dialogSprite = Sprite('playing/timesUpBG.png');

    nextButtonAni = Animation.sequenced("playing/nextButton.png", 3,
        textureHeight: 104, textureWidth: 500, stepTime: 0.1);

    dialogRectMaxWidth = game.tileSize * 4;
    dialogRectMaxHeight = game.tileSize * 6;

    reset();
  }

  reset() {
    dialogRectWidth = 5;
    dialogRectHeight = 8;
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
        width: dialogRectWidth,
        height: dialogRectHeight);

    dialogSprite.renderRect(canvas, dialogRect,
        overridePaint: BasicPalette.black.paint);

    if (dialogRectWidth == dialogRectMaxWidth &&
        dialogRectHeight == dialogRectMaxHeight) {
      nextBtnRect = Rect.fromCenter(
          center: new Offset(game.screenSize.width / 2,
              game.screenSize.height / 2 + game.tileSize * 2),
          width: game.tileSize * 3,
          height: game.tileSize * 0.8);

      nextButtonAni
          .getSprite()
          .renderRect(canvas, nextBtnRect, overridePaint: Paint());
    }
  }

  void update(double t) {
    //nextButtonAni.update(t);

    if (dialogRectWidth <= dialogRectMaxWidth &&
        dialogRectHeight <= dialogRectMaxHeight) {
      dialogRectWidth += dialogRectWidth * t * 20;
      dialogRectHeight += dialogRectHeight * t * 20;

      if (dialogRectWidth > dialogRectMaxWidth ||
          dialogRectHeight > dialogRectMaxHeight) {
        dialogRectWidth = dialogRectMaxWidth;
        dialogRectHeight = dialogRectMaxHeight;
      }
    }
  }
}
