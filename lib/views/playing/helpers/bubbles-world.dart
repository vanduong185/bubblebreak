import 'dart:math';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/box2d/box2d_component.dart';


import 'package:bubblesbreak/bubble-game.dart';
import 'package:bubblesbreak/models/stage.dart';
import 'package:bubblesbreak/models/word.dart';
import './bubble.dart';

class BubblesWorld extends Box2DComponent {
  final BubbleGame game;
  
  List<Bubble> bubbles;
  Bubble tappedBubble;
  int tappedBubbleIndex;

  List<Word> words;
  List<String> correctWord;
  Stage stage;

  bool isHandleTap = false;
  bool isCorrect = true;

  BubblesWorld({this.stage, this.game}) : super(scale: 4.0);

  @override
  void initializeWorld() {
    this.world.setGravity(Vector2(0, 0));
    List<BodyComponent> bodies = [
      new WallBody(this, Orientation.portrait, this.viewport.width, 0.1,
          Alignment.topCenter),
      new WallBody(this, Orientation.portrait, this.viewport.width, 0.1,
          Alignment.bottomCenter),
      new WallBody(this, Orientation.portrait, 0.1, this.viewport.height,
          Alignment.centerRight),
      new WallBody(this, Orientation.portrait, 0.1, this.viewport.height,
          Alignment.centerLeft),
    ];

    addAll(bodies);

    // generateBubbles();
  }

  generateBubbles() {
    bubbles = [];

    words = stage.word_list;
    double fontSize;

    if (game.screenSize.shortestSide < 600 )
      fontSize = 30.0;
    else fontSize = 60.0;

    for (int i = 0; i < words.length; i++) {
      // Random random = new Random();
      // double x = random.nextDouble() * viewport.width.toInt();
      // double y = random.nextDouble() * viewport.width.toInt();
      // print("x " + x.toString());
      // print("y " + y.toString());
      bubbles.add(new Bubble(this, 0, 0, fontSize, words[i]));
    }

    addAll(bubbles);
  }

  removeAllBubbles() {
    for (int i = 0; i < bubbles.length; ++i) {
      remove(bubbles[i]);
    }

    bubbles.clear();
  }

  @override
  void update(double t) {
    super.update(t);

    if (tappedBubble != null) if (tappedBubble.breakAnimation.isLastFrame) {
      remove(tappedBubble);
      bubbles.removeAt(tappedBubbleIndex);
      tappedBubble = null;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  Future<bool> onTapUp(TapUpDetails d) async {
    if (!isHandleTap) {
      for (int i = 0; i < bubbles.length; ++i) {
        if (bubbles[i].bubbleRect != null) {
          if (bubbles[i].bubbleRect.contains(d.globalPosition)) {
            isHandleTap = true;
            bubbles[i].onTap();
            tappedBubble = bubbles[i];
            tappedBubbleIndex = i;
            Future.delayed(const Duration(milliseconds: 1000), () {
              isHandleTap = false;
            });
            // remove(bubbles[i]);
            // bubbles.removeAt(index);

            //isHandleTap = false;
            break;
          }
        }
      }

      if (tappedBubble != null && tappedBubbleIndex != null) {
        
        return tappedBubble.word.word_type == stage.stage_word_type;
      }
    }

    return null;
  }
}

class WallBody extends BodyComponent {
  Orientation orientation;
  double width;
  double height;
  Alignment alignment;

  bool first = true;

  WallBody(Box2DComponent box, this.orientation, this.width, this.height,
      this.alignment)
      : super(box) {
    _createBody();
  }

  void _createBody() {
    double x = alignment.x * (box.viewport.width - width);
    double y = (-alignment.y) * (box.viewport.height - height);

    final shape = new PolygonShape();
    shape.setAsBoxXY(width, height);

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;

    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.0;
    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(x / 2, y / 2);
    Body groundBody = world.createBody(bodyDef);
    groundBody.createFixtureFromFixtureDef(fixtureDef);
    this.body = groundBody;
  }
}
