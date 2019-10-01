import 'package:box2d_flame/box2d.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:bubblesbreak/components/bubble.dart';
import 'package:flame/box2d/box2d_component.dart';

class BubblesWorld extends Box2DComponent {
  List<Bubble> bubbles;

  BubblesWorld() : super(scale: 4.0);

  @override
  void initializeWorld() {
    List<BodyComponent> bodies = [
      new WallBody(this, Orientation.portrait, 1.0, 0.005, Alignment.topCenter),
      new WallBody(
          this, Orientation.portrait, 1.0, 0.005, Alignment.bottomCenter),
      new WallBody(
          this, Orientation.portrait, 0.005, 1.0, Alignment.centerRight),
      new WallBody(
          this, Orientation.portrait, 0.005, 1.0, Alignment.centerLeft),
    ];

    addAll(bodies);
    bubbles = [];
    bubbles.add(new Bubble(this, 30.0, 30.0, 20.0));
    bubbles.add(new Bubble(this, 0.0, 0.0, 25.0));
    bubbles.add(new Bubble(this, 0.0, 50.0, 25.0));
    bubbles.add(new Bubble(this, 30.0, 30.0, 30.0));

    addAll(bubbles);
  }

  @override
  void update(double t) {
    super.update(t);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  void onTapDown(TapDownDetails d) {
    for (int i = 0 ; i < bubbles.length; ++i) {
      if (bubbles[i].rect.contains(d.globalPosition)) {
        bubbles[i].onTapDown();
        
        Future.delayed(const Duration(milliseconds: 400), () {
          remove(bubbles[i]);
          bubbles.removeAt(i);
        });
        //  remove(bubble);
      }
    }
    // bubbles.forEach((Bubble bubble) {
    //   if (bubble.rect.contains(d.globalPosition)) {
    //     bubble.onTapDown();
        
    //     Future.delayed(const Duration(milliseconds: 200), () {
    //       remove(bubble);
          
    //     });
    //     //  remove(bubble);
    //   }
    // });
  }
}

class WallBody extends BodyComponent {
  Orientation orientation;
  double widthPercent;
  double heightPercent;
  Alignment alignment;

  bool first = true;

  WallBody(Box2DComponent box, this.orientation, this.widthPercent,
      this.heightPercent, this.alignment)
      : super(box) {
    _createBody();
  }

  void _createBody() {
    double width = box.viewport.width * widthPercent;
    double height = box.viewport.height * heightPercent;

    double x = alignment.x * (box.viewport.width - width);
    double y = (-alignment.y) * (box.viewport.height - height);

    final shape = new PolygonShape();
    shape.setAsBoxXY(width / 2, height / 2);

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;

    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.2;
    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(x / 2, y / 2);
    Body groundBody = world.createBody(bodyDef);
    groundBody.createFixtureFromFixtureDef(fixtureDef);
    this.body = groundBody;
  }
}
