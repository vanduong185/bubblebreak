import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'package:bubblesbreak/bubble-game.dart';
import 'package:bubblesbreak/views/home/helpers/start-button.dart';

class HomeView {
  final BubbleGame game;
  Rect bgRect;
  Sprite bgSprite;

  StartButton startButton;

  HomeView(this.game) {
    resize();
    bgSprite = Sprite('branding/homeBackground.png');
    startButton = StartButton(this.game);
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
    startButton.render(c);
  }

  void resize() {
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.screenSize.width,
      game.screenSize.height,
    );
  }

  void update(double t) {
    startButton.update(t);
  }

  void onTapDown(TapDownDetails d) {
    if (startButton.rect.contains(d.globalPosition)) 
      startButton.onTapDown();
  }

  void onTapUp(TapUpDetails d) {
    if (startButton.rect.contains(d.globalPosition))
      startButton.onTapUp();
  }

  void onTapCancel() {
    startButton.onTapCancel();
  }
}
