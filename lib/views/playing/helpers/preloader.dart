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
    animation.getSprite().renderRect(
      canvas,
      new Rect.fromCenter(
        center: new Offset(
          this.game.screenSize.width / 2,
          this.game.screenSize.height / 2,
        ),
        width: this.game.screenSize.shortestSide < 600 ? 300 : 600,
        height: this.game.screenSize.shortestSide < 600 ? 300 : 600,
      ),
    );

    textConfig.render(
      canvas,
      "LOADING",
      flamePosition.Position.fromOffset(
          new Offset(game.screenSize.width / 2, game.screenSize.height / 2 + game.tileSize * 2)),
      anchor: Anchor.center,
    );
  }

  void update(double t) {
    animation.update(t);
  }
}
