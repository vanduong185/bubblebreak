import 'dart:convert';
import 'package:bubblesbreak/models/word.dart';

Stage stageFromJson(String str) {
  final jsonData = json.decode(str);
  return Stage.fromMap(jsonData);
}

String stageToJson(Stage data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Stage {
  String stageWordType;
  List<Word> wordList;

  Stage({this.stageWordType, this.wordList});

  factory Stage.fromMap(Map<String, dynamic> json) => new Stage(
    stageWordType: json["stage_word_type"],
    wordList: json["word_list"],
  );

  Map<String, dynamic> toMap() => {
    "stageWordType": stageWordType,
    "wordList": wordList,
  };
}
