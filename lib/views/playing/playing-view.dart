import 'dart:ui';
import 'package:bubblesbreak/views/playing/helpers/clock.dart';
import 'package:bubblesbreak/views/playing/helpers/goodjob-ani.dart';
import 'package:bubblesbreak/views/playing/helpers/learning-dialog.dart';
import 'package:bubblesbreak/views/playing/helpers/modeTitle.dart';
import 'package:bubblesbreak/views/playing/helpers/preloader.dart';
import 'package:bubblesbreak/views/playing/helpers/progess.dart';
import 'package:bubblesbreak/views/playing/helpers/stage-word-type-ani.dart';
import 'package:bubblesbreak/views/playing/helpers/stage-word-type.dart';
import 'package:bubblesbreak/views/view.dart';
import 'package:flutter/gestures.dart';

import 'package:bubblesbreak/configs/configs.dart';
import 'package:bubblesbreak/models/stage.dart';
import 'package:bubblesbreak/utils/network.dart';
import 'package:bubblesbreak/bubble-game.dart';

import './helpers/background.dart';
import './helpers/bubbles-world.dart';
import 'helpers/result-dialog.dart';

class PlayingView {
  final BubbleGame game;

  Background playingBackground;

  StageWordType stageWordType;
  StageWordTypeAni stageWordTypeAni;

  ModeTitle modeTitle;

  Progress progress;

  Clock clock;

  BubblesWorld world;

  GoodJobAni goodJobAnimation;

  LearningDialog learningDialog;

  ResultDialog resultDialog;

  Preloader preloader;

  List<Stage> listStage;
  int currentStage;

  bool isCorrect;
  bool isWrong;

  bool isLoading;

  bool endGame;

  PlayingView(this.game) {
    playingBackground = Background(this.game);

    world = new BubblesWorld(game: this.game);
    world.initializeWorld();
  }

  initialize() async {
    isLoading = true;
    isCorrect = false;
    isWrong = false;
    endGame = false;

    preloader = Preloader(this.game);

    listStage = await Network.getGameData();
    currentStage = 0;
    world.stage = listStage[currentStage];

    stageWordType = StageWordType(this.game);
    stageWordType.setType(listStage[currentStage].stageWordType);

    stageWordTypeAni = StageWordTypeAni(this.game);
    stageWordTypeAni.setType(listStage[currentStage].stageWordType);

    modeTitle = ModeTitle(this.game);

    progress = Progress(this.game);
    progress.setIndex(currentStage);

    clock = Clock(this.game);

    learningDialog = LearningDialog(game);
    resultDialog = ResultDialog(game);
    resultDialog.reset();

    world.generateBubbles();

    goodJobAnimation = new GoodJobAni(this.game);
    
    clock.start();

    isLoading = false;
  }

  void render(Canvas canvas) {
    playingBackground.render(canvas);

    if (isLoading) {
      preloader.render(canvas);
    }

    if (!isLoading && !endGame) {
      modeTitle.render(canvas);

      progress.render(canvas);

      stageWordType.render(canvas);

      clock.render(canvas);

      world.render(canvas);

      if (stageWordTypeAni != null) stageWordTypeAni.render(canvas);
    }

    if (isCorrect) {
      goodJobAnimation.render(canvas);
    }

    if (isWrong) {
      learningDialog.render(canvas);
    }

    if (endGame) {
      resultDialog.render(canvas);
    }
  }

  void update(double t) {
    world.update(t);

    if (isLoading) {
      preloader.update(t);
    }

    if (stageWordTypeAni != null) if (stageWordTypeAni.isAtEndPoint == false)
      stageWordTypeAni.update(t);
    else
      stageWordTypeAni = null;

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

    if (endGame) {
      resultDialog.update(t);
    }
  }

  void renderNextStage() {
    // remove all bubbles
    world.removeAllBubbles();

    // next stage
    currentStage++;

    if (currentStage < Configs.numberOfStage) {
      world.stage = listStage[currentStage];

      stageWordType.setType(listStage[currentStage].stageWordType);

      stageWordTypeAni = new StageWordTypeAni(game);
      stageWordTypeAni.setType(listStage[currentStage].stageWordType);

      progress.setIndex(currentStage);

      world.generateBubbles();

      clock.reset();
    } else {
      endGame = true;
    }
  }

  void resize(Size size) {
    world.resize(size);
  }

  void onTapUp(TapUpDetails d) {
    if (world.bubbles != null && !isWrong) {
      world.onTapUp(d).then((result) {
        clock.cancel();
        
        if (result != null) {
          isCorrect = result["isCorrect"];
          isWrong = !result["isCorrect"];
          learningDialog.setWord(result["word"]);
        }
      });
    }

    if (endGame) {
      if (resultDialog.replayBtnRect.contains(d.globalPosition)) {
        game.activeView = View.home;
      }
    }

    if (isWrong) {
      if (learningDialog.nextBtnRect.contains(d.globalPosition)) {
        renderNextStage();
        isWrong = false;
      }
    }
  }
}
