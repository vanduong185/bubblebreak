import 'dart:math';
import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:bubblesbreak/configs/theme.dart';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/position.dart' as flamePosition;
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

import 'package:bubblesbreak/models/word.dart';
import 'package:bubblesbreak/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Bubble extends BodyComponent {
  ImagesLoader images = new ImagesLoader();
  final double x;
  final double y;
  double fontsize;
  Word word;

  Rect bubbleRect;

  bool isBroken;
  Animation breakAnimation;

  TextPainter painter;

  Bubble(Box2DComponent box, this.x, this.y, this.fontsize, this.word)
      : super(box) {
    images.load("bubble", "playing/bubble2.png");
    isBroken = false;
    breakAnimation = Animation.sequenced("playing/ani_break.png", 7,
        textureWidth: 216, stepTime: 0.08);

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    _createBody();
  }

  @override
  void initializeWorld() {
    // TODO: implement initializeWorld
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    if (images.isLoading) {
      return;
    }

    var image = images.get("bubble");

    // TextConfig textConfig = TextConfig(
    //     fontSize: fontsize, fontFamily: 'Fredoka', color: Color(0xFFF47B2A), textAlign: TextAlign.justify);
    // textConfig.render(
    //     canvas, word.eng_word, flamePosition.Position.fromOffset(center.translate(radius * 0.1, radius * 0.1)), anchor: Anchor.center);
    painter.text = TextSpan(
      text: word.eng_word,
      style: TextStyle(
        color: ColorPallet.orange,
        fontSize: fontsize,
        fontFamily: 'Fredoka',
        shadows: <Shadow>[
          Shadow(
            color: ColorPallet.white,
            offset: Offset(0, 1.5),
          ),
          Shadow(
            color: ColorPallet.white,
            offset: Offset(1.5, 0),
          ),
          Shadow(
            color: ColorPallet.white,
            offset: Offset(0, -1.5),
          ),
          Shadow(
            color: ColorPallet.white,
            offset: Offset(-1.5, 0),
          ),
          Shadow(
            color: ColorPallet.white,
            offset: Offset(1.5, -1.5),
          ),
          Shadow(
            color: ColorPallet.white,
            offset: Offset(-1.5, -1.5),
          ),
          Shadow(
            color: ColorPallet.white,
            offset: Offset(-1.5, 1.5),
          ),
          Shadow(
            color: ColorPallet.white,
            offset: Offset(1.5, 1.5),
          ),
        ],
      ),
    );
    
    painter.layout();
    painter.paint(canvas,
        center.translate(-painter.size.width / 2, -painter.size.height / 2));

    if (!isBroken) {
      paintImage(
          canvas: canvas,
          image: image,
          rect: bubbleRect = new Rect.fromCircle(
            center: center.translate(radius * 0.1, radius * 0.1),
            radius: radius + radius * 0.1,
          ),
          fit: BoxFit.contain);
    } else {
      this.body.linearVelocity = Vector2(0, 0);
      breakAnimation.getSprite().renderRect(canvas, bubbleRect);
    }
  }

  void _createBody() {
    final shape = new CircleShape();
    // shape.radius = ((fontsize / 2) * word.eng_word.length.toDouble()) / 4.5;
    shape.radius = word.eng_word.length.toDouble() * (fontsize / 12) + 5;
    shape.p.x = x;
    shape.p.y = y;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    activeFixtureDef.restitution = 1.0;
    activeFixtureDef.density = 0.0;
    activeFixtureDef.friction = 0.0;
    FixtureDef fixtureDef = activeFixtureDef;
    final activeBodyDef = new BodyDef();

    Random random = new Random();
    int min = -50, max = 50;
    double vx = random.nextDouble() * (min + random.nextInt(max - min));
    double vy = random.nextDouble() * (min + random.nextInt(max - min));
    activeBodyDef.linearVelocity = new Vector2(vx, vy);

    activeBodyDef.position = new Vector2(0, 0);
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.bullet = true;
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void onTap() {
    print("tapped");
    isBroken = true;
  }

  @override
  void update(double t) {
    if (isBroken) {
      if (breakAnimation.isLastFrame) {
        breakAnimation.loop = false;
      }
      breakAnimation.update(t);
    }
  }
}
