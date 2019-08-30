import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bubblesbreak/bubble-game.dart';

void main() async {
  Flame.audio.disableLog();
  Flame.images.loadAll(<String>[
    'playing/background.png',
  ]);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  BubbleGame game = BubbleGame();
  runApp(game.widget);

  SystemChrome.setEnabledSystemUIOverlays([]);
}
