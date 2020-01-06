import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';

import './views/view.dart';
import './views/home/home-view.dart';
import './views/playing/playing-view.dart';

class BubbleGame extends Game {
  Size screenSize;
  double tileSize;

  View activeView = View.home;
  HomeView homeView;
  PlayingView playingView;

  BubbleGame(Size screenSize) {
    this.screenSize = screenSize;
    
    initialize();
  }

  void initialize() async {
    resize(screenSize);

    homeView = HomeView(this);
    playingView = PlayingView(this);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 6;
    playingView?.resize(size);
  }

  @override
  void render(Canvas canvas) {
    if (activeView == View.home) {
      homeView.render(canvas);
    } 
    
    if (activeView == View.playing) {
      playingView.render(canvas);
    }
  }

  @override
  void update(double t) {
    if (activeView == View.home) {
      homeView.update(t);
    }

    if (activeView == View.playing) {
      playingView.update(t);
    }
  }

   void onTapDown(TapDownDetails d) {
    if (activeView == View.home) {
      homeView.onTapDown(d);
    }
  }

  void onTapUp(TapUpDetails d) {
    if (activeView == View.home) {
      homeView.onTapUp(d);
    }

    if (activeView == View.playing) {
      playingView.onTapUp(d);
    }
  }

  void onTapCancel() {
    if (activeView == View.home) {
      homeView.onTapCancel();
    }
  }
}
