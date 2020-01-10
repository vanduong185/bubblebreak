import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bubblesbreak/bubble-game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.audio.disableLog();
  Flame.images.loadAll(<String>[
    'playing/background.png',
  ]);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  
  final Size size = await Flame.util.initialDimensions();
  BubbleGame game = BubbleGame(size);
  //runApp(BubbleGame(size).widget);
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapUp = game.onTapUp;
  tapper.onTapDown = game.onTapDown;
  tapper.onTapCancel = game.onTapCancel;
  flameUtil.addGestureRecognizer(tapper);

  SystemChrome.setEnabledSystemUIOverlays([]);
}
