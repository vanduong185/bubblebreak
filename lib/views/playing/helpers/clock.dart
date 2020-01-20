import 'dart:async';
import 'dart:ui';
import 'package:bubblesbreak/configs/theme.dart';
import 'package:flame/anchor.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart' as flamePosition;
import 'package:bubblesbreak/bubble-game.dart';
import 'package:flame/text_config.dart';

class Clock {
  final BubbleGame game;
  final int duration = 10;

  Timer timer;
  int tick = 0;

  Rect clockRect;
  Sprite clockSprite;

  RRect indicatorRect;
  Sprite indicatorSprite;

  TextConfig textConfig;

  Clock(this.game) {
    clockSprite = Sprite('playing/clock1.png');
    indicatorSprite = Sprite('playing/clock2.png');
    resize();
  }

  start() {
    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      tick = timer.tick;

      if (tick >= duration) cancel();
    });
  }

  cancel() {
    timer.cancel();
  }

  reset() {
    timer.cancel();
    tick = 0;
    start();
  }

  void render(Canvas canvas) {
    clockRect = Rect.fromCenter(
        center: new Offset(game.screenSize.width / 2, game.tileSize * 2),
        width: game.tileSize * 4,
        height: game.tileSize);

    clockSprite.renderRect(canvas, clockRect);

    indicatorRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(
          game.screenSize.width / 2 -
              game.tileSize +
              game.tileSize * 0.285 * tick,
          game.tileSize * 1.82,
          game.tileSize * 2.85 - game.tileSize * 0.285 * tick,
          game.tileSize / 2.5),
      bottomRight: Radius.circular(game.tileSize / 2.5),
      topRight: Radius.circular(game.tileSize / 2.5),
      bottomLeft:
          tick == 0 ? Radius.circular(game.tileSize / 2.5) : Radius.zero,
      topLeft: tick == 0 ? Radius.circular(game.tileSize / 2.5) : Radius.zero,
    );

    Paint indicatorPaint = new Paint();
    indicatorPaint.color = ColorPallet.orange;
    canvas.drawRRect(indicatorRect, indicatorPaint);
    // indicatorSprite. (canvas, indicatorRect);

    textConfig = TextConfig(
        fontSize: 40,
        fontFamily: 'Fredoka',
        color: ColorPallet.orange,
        textAlign: TextAlign.justify);

    String text = (duration - tick).toString();

    textConfig.render(
      canvas,
      text,
      flamePosition.Position.fromOffset(
          new Offset(game.screenSize.width / 2 - game.tileSize * 1.5, game.tileSize * 2)),
      anchor: Anchor.center,
    );
  }

  void update(double t) {}

  void resize() {}
}
