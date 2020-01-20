import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';

import 'package:bubblesbreak/bubble-game.dart';

class ResultDialog {
  final BubbleGame game;
  Rect dialogRect;
  double dialogRectWidth;
  double dialogRectMaxWidth;
  double dialogRectHeight;
  double dialogRectMaxHeight;

  Sprite dialogSprite;

  Rect overlayRect;

  Rect replayBtnRect;
  Animation replayButtonAni;

  ResultDialog(this.game) {
    dialogSprite = Sprite('playing/resultBG2.png');

    replayButtonAni = Animation.sequenced("playing/resultButton.png", 3,
        textureHeight: 104, textureWidth: 504, stepTime: 0.1);

    dialogRectMaxWidth = game.tileSize * 4;
    dialogRectMaxHeight = game.tileSize * 6;
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

    dialogSprite.renderRect(canvas, dialogRect);

    if (dialogRectWidth == dialogRectMaxWidth &&
        dialogRectHeight == dialogRectMaxHeight) {
      replayBtnRect = Rect.fromCenter(
          center: new Offset(game.screenSize.width / 2,
              game.screenSize.height / 2 + game.tileSize * 2),
          width: game.tileSize * 3,
          height: game.tileSize * 0.8);

      replayButtonAni
          .getSprite()
          .renderRect(canvas, replayBtnRect, overridePaint: Paint());
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
