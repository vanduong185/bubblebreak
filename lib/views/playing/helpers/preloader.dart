import 'dart:ui';
import 'package:bubblesbreak/configs/theme.dart';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/position.dart' as flamePosition;
import 'package:bubblesbreak/bubble-game.dart';
import 'package:flame/text_config.dart';

class Preloader {
  final BubbleGame game;

  Animation animation;
  TextConfig textConfig;
  Rect overlayRect;

  Preloader(this.game) {
    animation = Animation.sequenced("playing/preloader2.png", 5,
        textureWidth: 216, stepTime: 0.1);

    textConfig = TextConfig(
        fontSize: 30,
        fontFamily: 'Fredoka',
        color: ColorPallet.orange,
        textAlign: TextAlign.justify);
  }

  void render(Canvas canvas) {
    // overlayRect =
    //     Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    // Paint overlayPaint = Paint();
    // overlayPaint.color = Color(0xFF545454).withOpacity(0.5);

    // canvas.drawRect(overlayRect, overlayPaint);

    animation.getSprite().renderRect(
      canvas,
      new Rect.fromCenter(
        center: new Offset(
          this.game.screenSize.width / 2,
          this.game.screenSize.height / 2,
        ),
        width: 300,
        height: 300,
      ),
    );

    textConfig.render(
      canvas,
      "LOADING",
      flamePosition.Position.fromOffset(
          new Offset(game.screenSize.width / 2, game.screenSize.height / 2)),
      anchor: Anchor.center,
    );
  }

  void update(double t) {
    animation.update(t);
  }
}
