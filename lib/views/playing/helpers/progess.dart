import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/position.dart' as flamePosition;
import 'package:flame/text_config.dart';

import 'package:bubblesbreak/configs/configs.dart';
import 'package:bubblesbreak/bubble-game.dart';

class Progress {
  final BubbleGame game;
  
  TextConfig textConfig;

  int index;

  Progress(this.game);

  void setIndex(int index) {
    this.index = index;
  }

  void render(Canvas canvas) {
    double fontSize;
    if (this.game.screenSize.shortestSide < 600 )
      fontSize = 30;
    else fontSize = 60;

    textConfig = TextConfig(
        fontSize: 30, fontFamily: 'Fredoka', color: Color(0xFFFFFFFF), textAlign: TextAlign.justify);
    
    String text = (index + 1).toString() + "/" + Configs.numberOfStage.toString();

    textConfig.render(
        canvas, text, flamePosition.Position.fromOffset(new Offset(game.screenSize.width/2, game.tileSize)), anchor: Anchor.center);
  }

  void update(double t) {}

  void resize() {
  }
}
