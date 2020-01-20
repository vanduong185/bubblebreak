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
import 'package:bubblesbreak/models/word.dart';
import 'package:flutter/painting.dart';

class LearningDialog {
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

  Word word;

  TextConfig engWord;

  TextConfig japMeaning;

  TextConfig wordType;

  TextPainter sentence;

  LearningDialog(this.game) {
    dialogSprite = Sprite('playing/learningBG.png');

    nextButtonAni = Animation.sequenced("playing/nextButton.png", 3,
        textureHeight: 104, textureWidth: 500, stepTime: 0.1);

    dialogRectMaxWidth = game.tileSize * 4;
    dialogRectMaxHeight = game.tileSize * 6;
  }

  reset() {
    dialogRectWidth = 5;
    dialogRectHeight = 8;
  }

  setWord(Word w) {
    reset();

    this.word = w;

    sentence = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    sentence.text = TextSpan(
      text: w.engSentence,
      style: TextStyle(
        color: ColorPallet.grey,
      ),
    );

    if (sentence.text == null) return;
    sentence.layout(maxWidth: game.tileSize * 3);
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

      engWord = TextConfig(
          fontSize: 24,
          fontFamily: 'Fredoka',
          color: ColorPallet.white,
          textAlign: TextAlign.justify);

      engWord.render(
          canvas,
          word.engWord,
          flamePosition.Position.fromOffset(new Offset(
              game.screenSize.width / 2,
              game.screenSize.height / 2 - game.tileSize * 2)),
          anchor: Anchor.center);

      japMeaning = TextConfig(
          fontSize: 20,
          fontFamily: 'Fredoka',
          color: ColorPallet.orange,
          textAlign: TextAlign.justify);

      japMeaning.render(
          canvas,
          word.japanWord,
          flamePosition.Position.fromOffset(new Offset(
              game.screenSize.width / 2 + 20,
              game.screenSize.height / 2 - game.tileSize * 1.5)),
          anchor: Anchor.topLeft);

      wordType = TextConfig(
          fontSize: 20,
          fontFamily: 'Fredoka',
          color: ColorPallet.orange,
          textAlign: TextAlign.justify);

      wordType.render(
          canvas,
          Configs.getWordTypeJp(word.wordType),
          flamePosition.Position.fromOffset(new Offset(
              game.screenSize.width / 2 + 20,
              game.screenSize.height / 2 - game.tileSize)),
          anchor: Anchor.topLeft);

      sentence.paint(
        canvas,
        Offset(
          game.screenSize.width / 2 - sentence.width / 2,
          game.screenSize.height / 2 - game.tileSize * 0.1,
        ),
      );
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
