import 'dart:ui';
import 'package:bubblesbreak/configs/configs.dart';
import 'package:bubblesbreak/configs/theme.dart';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/text_box_component.dart';
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
  double nextBtnRectMaxWidth;
  double nextBtnRectMaxHeight;

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

    dialogRectMaxWidth = game.tileSize * 5;
    dialogRectMaxHeight = game.tileSize * 8;

    nextBtnRectMaxWidth = game.tileSize * 4;
    nextBtnRectMaxHeight = game.tileSize;
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
      text: w.eng_sentence,
      style: TextStyle(
        color: ColorPallet.grey,
      ),
    );

    if (sentence.text == null) return;
    sentence.layout(maxWidth: game.tileSize * 4);
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
              game.screenSize.height / 2 + game.tileSize * 3),
          width: nextBtnRectMaxWidth,
          height: nextBtnRectMaxHeight);

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
          word.eng_word,
          flamePosition.Position.fromOffset(new Offset(
              game.screenSize.width / 2,
              game.screenSize.height / 2 - game.tileSize * 2.5)),
          anchor: Anchor.center);

      japMeaning = TextConfig(
          fontSize: 20,
          fontFamily: 'Fredoka',
          color: ColorPallet.orange,
          textAlign: TextAlign.justify);

      japMeaning.render(
          canvas,
          word.japan_word,
          flamePosition.Position.fromOffset(new Offset(
              game.screenSize.width / 2 + game.tileSize,
              game.screenSize.height / 2 - game.tileSize * 1.8)),
          anchor: Anchor.center);

      wordType = TextConfig(
          fontSize: 20,
          fontFamily: 'Fredoka',
          color: ColorPallet.orange,
          textAlign: TextAlign.justify);

      wordType.render(
          canvas,
          Configs.getWordTypeJp(word.word_type),
          flamePosition.Position.fromOffset(new Offset(
              game.screenSize.width / 2 + game.tileSize,
              game.screenSize.height / 2 - game.tileSize * 1.1)),
          anchor: Anchor.center);

      sentence.paint(
        canvas,
        Offset(
          game.screenSize.width / 2 - sentence.width / 2,
          game.screenSize.height / 2 - game.tileSize * 0.2,
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

      if (dialogRectWidth > dialogRectMaxWidth &&
          dialogRectHeight > dialogRectMaxHeight) {
        dialogRectWidth = dialogRectMaxWidth;
        dialogRectHeight = dialogRectMaxHeight;
      }
    }
  }
}
