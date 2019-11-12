import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bubblesbreak/configs/configs.dart';
import 'package:bubblesbreak/models/stage.dart';
import 'package:bubblesbreak/models/word.dart';


class Network {
  static Future<List<Stage>> getGameData() async {
    List<Stage> listStage = new List<Stage>();

    var response = await http.post(Configs.apiURL, body: Configs.bodyRequestAPI);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var stages = data["game_data"]["stage_data"];

      for (var s in stages) {
        Stage stage = new Stage(
          stage_word_type: s["stage_word_type"],
          word_list: new List<Word>()
        );

        for (var w in s["word_list"]) {
          Word word = new Word.fromMap(w);
          stage.word_list.add(word);
        }

        listStage.add(stage);
      }

      return listStage; 
    }
  }
}