import 'dart:ui';
import 'package:bubblesbreak/configs/configs.dart';
import 'package:bubblesbreak/configs/theme.dart';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart' as flamePosition;
import 'package:flame/text_config.dart';

import 'package:bubblesbreak/bubble-game.dart';
import 'package:bubblesbreak/models/word.dart';
import 'package:flutter/painting.dart';

class LearningDialog {
  final BubbleGame game;
  Rect dialogRect;
  Sprite dialogSprite;

  Rect overlayRect;

  Rect nextBtnRect;

  Animation nextButtonAni;

  Word word;

  TextConfig engWord;
  TextConfig japMeaning;
  TextConfig wordType;
  TextConfig sentence;

  TextPainter painter;

  TextBoxComponent sentenceBox;

  LearningDialog(this.game) {
    dialogSprite = Sprite('playing/learningBG.png');

    nextButtonAni = Animation.sequenced("playing/nextButton.png", 3,
        textureHeight: 104, textureWidth: 500, stepTime: 0.1);
  }

  setWord(Word w) {
    this.word = w;

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    painter.text = TextSpan(
      text: w.eng_sentence,
      style: TextStyle(
        color: ColorPallet.grey,
      ),
    );

    if (painter.text == null) return;
    painter.layout(maxWidth: game.tileSize * 4);
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

    nextBtnRect = Rect.fromCenter(
        center: new Offset(game.screenSize.width / 2,
            game.screenSize.height / 2 + game.tileSize * 3),
        width: game.tileSize * 4,
        height: game.tileSize);

    nextButtonAni
        .getSprite()
        .renderRect(canvas, nextBtnRect, overridePaint: Paint());

    engWord = TextConfig(
        fontSize: 24,
        fontFamily: 'Fredoka',
        color: Color(0xFFFFFFFF),
        textAlign: TextAlign.justify);

    engWord.render(
        canvas,
        word.eng_word,
        flamePosition.Position.fromOffset(new Offset(game.screenSize.width / 2,
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

    // sentenceBox.render(canvas);
    painter.paint(
      canvas,
      Offset(
        game.screenSize.width / 2 - painter.width / 2,
        game.screenSize.height / 2 - game.tileSize * 0.2,
      ),
    );
  }

  void update(double t) {
    //nextButtonAni.update(t);

    // sentenceBox.update(t);
  }
}
