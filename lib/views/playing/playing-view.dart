import 'dart:ui';
import 'package:bubblesbreak/models/word.dart';
import 'package:bubblesbreak/views/playing/helpers/goodjob-ani.dart';
import 'package:bubblesbreak/views/playing/helpers/learning-dialog.dart';
import 'package:bubblesbreak/views/playing/helpers/modeTitle.dart';
import 'package:bubblesbreak/views/playing/helpers/progess.dart';
import 'package:bubblesbreak/views/playing/helpers/stage-word-type-ani.dart';
import 'package:bubblesbreak/views/playing/helpers/stage-word-type.dart';
import 'package:flutter/gestures.dart';

import 'package:bubblesbreak/configs/configs.dart';
import 'package:bubblesbreak/models/stage.dart';
import 'package:bubblesbreak/utils/network.dart';
import 'package:bubblesbreak/bubble-game.dart';
import './helpers/background.dart';
import './helpers/bubbles-world.dart';

class PlayingView {
  final BubbleGame game;

  Background playingBackground;

  StageWordType stageWordType;
  StageWordTypeAni stageWordTypeAni;

  ModeTitle modeTitle;

  Progress progress;

  BubblesWorld world;

  GoodJobAni goodJobAnimation;

  LearningDialog learningDialog;

  List<Stage> listStage;
  int currentStage;

  bool isCorrect;
  bool isWrong;

  bool isLoading;

  PlayingView(this.game) {
    playingBackground = Background(this.game);

    world = new BubblesWorld(game: this.game);
    world.initializeWorld();

    isCorrect = false;
    isWrong = false;
  }

  initialize() async {
    isLoading = true;
    listStage = await Network.getGameData();
    currentStage = 0;
    world.stage = listStage[currentStage];

    stageWordType = StageWordType(this.game);
    stageWordType.setType(listStage[currentStage].stage_word_type);

    stageWordTypeAni = StageWordTypeAni(this.game);
    stageWordTypeAni.setType(listStage[currentStage].stage_word_type);

    modeTitle = ModeTitle(this.game);

    progress = Progress(this.game);
    progress.setIndex(currentStage);

    learningDialog = LearningDialog(game);

    isLoading = false;
    world.generateBubbles();

    goodJobAnimation = new GoodJobAni(this.game);
  }

  void render(Canvas canvas) {
    playingBackground.render(canvas);

    if (!isLoading) {
      modeTitle.render(canvas);

      progress.render(canvas);

      stageWordType.render(canvas);

      world.render(canvas);

      if (stageWordTypeAni != null) stageWordTypeAni.render(canvas);
    }

    if (isCorrect) {
      goodJobAnimation.render(canvas);
    }

    if (isWrong) {
      learningDialog.render(canvas);
    }
  }

  void update(double t) {
    world.update(t);
    
    if (stageWordTypeAni != null)
      if (stageWordTypeAni.isAtEndPoint == false) stageWordTypeAni.update(t);
      else stageWordTypeAni = null;

    if (isCorrect) {
      goodJobAnimation.update(t);

      if (goodJobAnimation.animation.isLastFrame) {
        isCorrect = false;
        goodJobAnimation.animation.reset();

        renderNextStage();
      }
    }

    if (isWrong) {
      learningDialog.update(t);
    }
  }

  void renderNextStage() {
    // remove all bubbles
    world.removeAllBubbles();

    // next stage
    currentStage++;

    if (currentStage < Configs.NUMBER_OF_STAGE) {
      world.stage = listStage[currentStage];

      stageWordType.setType(listStage[currentStage].stage_word_type);

      stageWordTypeAni = new StageWordTypeAni(game);
      stageWordTypeAni.setType(listStage[currentStage].stage_word_type);

      progress.setIndex(currentStage);

      world.generateBubbles();
    }
  }

  void resize(Size size) {
    world.resize(size);
  }

  void onTapUp(TapUpDetails d) {
    if (world.bubbles != null && !isWrong) {
      world.onTapUp(d).then((result) {
        if (result != null) {
          isCorrect = result["isCorrect"];
          isWrong = !result["isCorrect"];
          learningDialog.setWord(result["word"]);
        }
      });
    }

    if (isWrong) {
      if (learningDialog.nextBtnRect.contains(d.globalPosition)) {
        renderNextStage();
        isWrong = false;
      }
    }
  }
}
