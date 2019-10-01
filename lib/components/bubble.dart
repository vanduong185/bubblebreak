// import 'dart:ui';
// import 'package:flame/sprite.dart';
// import 'package:bubblesbreak/bubble-game.dart';

// class Bubble {
//   final BubbleGame game;
//   Sprite bgSprite;
//   Rect bgRect;

//   Bubble(this.game) {
//     bgSprite = Sprite('playing/background.png');

//     bgRect = Rect.fromLTWH(
//       0,
//       game.screenSize.height - (game.tileSize * 23),
//       game.tileSize * 9,
//       game.tileSize * 23,
//     );
//   }

//   void render(Canvas c) {
//     bgSprite.renderRect(c, bgRect);
//   }

//   void update(double t) {}
// }

import 'package:bubblesbreak/utils/utils.dart';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/animation.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class Bubble extends BodyComponent {
  ImagesLoader images = new ImagesLoader();
  final double x;
  final double y;
  double radius;
  Rect rect;

  bool isBroken;
  Animation breakAnimation;

  Bubble(Box2DComponent box, this.x, this.y, this.radius) : super(box) {
    images.load("bubble", "playing/bubble2.png");
    isBroken = false;
    breakAnimation = Animation.sequenced("playing/ani_break.png", 7,
        textureWidth: 216, stepTime: 0.1);
    
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

    if (!isBroken)
      paintImage(
          canvas: canvas,
          image: image,
          rect: rect = new Rect.fromCircle(center: center, radius: radius),
          fit: BoxFit.contain);
    else {
      breakAnimation.getSprite().renderRect(canvas, rect);
    }
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = radius;
    shape.p.x = x;
    shape.p.y = y;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    activeFixtureDef.restitution = 1.0;
    activeFixtureDef.density = 0.0;
    activeFixtureDef.friction = 0.0;
    FixtureDef fixtureDef = activeFixtureDef;
    final activeBodyDef = new BodyDef();
    activeBodyDef.linearVelocity = new Vector2(20.0, 20.0);
    activeBodyDef.position = new Vector2(0.0, 0.0);
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.bullet = true;
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void onTapDown() {
    print("tapped");
    isBroken = true;
  }

  @override
  void update(double t) {
    breakAnimation.update(t);
  }
}
