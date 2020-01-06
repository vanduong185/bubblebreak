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

// import 'dart:ui';

// import 'package:flame/anchor.dart';
// import 'package:flame/components/text_box_component.dart';
// import 'package:flame/components/text_component.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/game.dart';
// import 'package:flame/palette.dart';
// import 'package:flame/text_config.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   final Size size = await Flame.util.initialDimensions();
//   runApp(MyGame(size).widget);
// }

// TextConfig regular = TextConfig(color: BasicPalette.white.color, textAlign: TextAlign.justify);
// TextConfig tiny = regular.withFontSize(20.0);

// class MyTextBox extends TextBoxComponent {
//   MyTextBox(String text, double w)
//       : super(text,
//             config: tiny, boxConfig: TextBoxConfig(timePerChar: 0, maxWidth: w));

//   @override
//   void drawBackground(Canvas c) {
//     // final Rect rect = Rect.fromLTWH(0, 0, 600, 100);
//     // c.drawRect(rect, Paint()..color = const Color(0xFFFF00FF));
//     // c.drawRect(
//     //     rect,
//     //     Paint());
//   }
// }

// class MyGame extends Game {
//   Size size;
//   MyGame(Size screenSize) {
//     this.size = screenSize;
//     box = MyTextBox(
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum.', 600)
//       ..anchor = Anchor.center
//       ..y = size.height/2
//       ..x = size.width/2
//       ..width = 100;
//     // size = screenSize;
//     // add(TextComponent('Hello, Flame', config: regular)
//     //   ..anchor = Anchor.topCenter
//     //   ..x = size.width / 2
//     //   ..y = 32.0);

//     // add(TextComponent('center', config: tiny)
//     //   ..anchor = Anchor.center
//     //   ..x = size.width / 2
//     //   ..y = size.height / 2);

//     // add(TextComponent('bottomRight', config: tiny)
//     //   ..anchor = Anchor.bottomRight
//     //   ..x = size.width
//     //   ..y = size.height);

//     // add(MyTextBox(
//     //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum.')
//     //   ..anchor = Anchor.bottomLeft
//     //   ..y = size.height);
//   }
//   MyTextBox box;

//   @override
//   void render(Canvas canvas) {

//     box.render(canvas);
//   }

//   @override
//   void update(double t) {
//     box.update(t);
//   }
// }