import 'dart:ui';
import 'package:flame/animation.dart';

import 'package:bubblesbreak/bubble-game.dart';

class GoodJobAni {
  final BubbleGame game;

  Animation animation;

  GoodJobAni(this.game) {
    animation = Animation.sequenced("playing/goodJob.png", 11,
        textureWidth: 275, stepTime: 0.1);
  }

  void render(Canvas canvas) {
    animation.getSprite().renderRect(
      canvas,
      new Rect.fromCenter(
          center: new Offset(this.game.screenSize.width / 2,
              this.game.screenSize.height / 2),
          width: 300,
          height: 300));
  }

  void update(double t) {
    animation.update(t);
  }
}
