import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';

import 'package:bubblesbreak/bubble-game.dart';
import 'package:bubblesbreak/views/view.dart';

class StartButton {
  final BubbleGame game;
  Rect rect;
  Sprite sprite;
  bool isTapped = false;

  Animation startButtonAni = Animation.sequenced("branding/startButton.png", 3,
      textureWidth: 340, stepTime: 0.1);

  StartButton(this.game) {
    resize();
    sprite = Sprite('branding/startButton.png');

    startButtonAni.currentIndex = 1;
  }

  void render(Canvas canvas) {
    startButtonAni.getSprite().renderRect(canvas, rect, overridePaint: Paint());
  }

  void update(double t) {
    if (isTapped) {
      startButtonAni.currentIndex = 2;
    }
  }

  void resize() {
    rect = Rect.fromCenter(
        center: new Offset(game.screenSize.width / 2,
            game.screenSize.height / 2 + game.tileSize * 3),
      width: game.tileSize * 3,
      height: game.tileSize * 1.5);
  }

  void onTapDown() {
    startButtonAni.currentIndex = 0;
  }

  void onTapUp() {
    startButtonAni.currentIndex = 1;
    game.playingView.initialize();
    game.activeView = View.playing;
  }

  void onTapCancel() {
    startButtonAni.currentIndex = 1;
  }
}
