import 'dart:math';
import 'package:box2d_flame/box2d.dart';
import 'package:bubblesbreak/configs/theme.dart';
import 'package:flame/animation.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

import 'package:bubblesbreak/models/word.dart';
import 'package:bubblesbreak/utils/utils.dart';

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

    painter.text = TextSpan(
      text: word.engWord,
      style: TextStyle(
        color: ColorPallet.white,
        fontSize: fontsize,
        fontFamily: "Fredoka",
        shadows: Theme.textBubbleShadow,
      ),
    );

    if (painter.text != null) painter.layout();

    _createBody();
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
    shape.radius = word.engWord.length.toDouble() * (fontsize / 12) + 5;
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
