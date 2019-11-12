import 'dart:convert';
import 'package:bubblesbreak/models/word.dart';

Stage StageFromJson(String str) {
  final jsonData = json.decode(str);
  return Stage.fromMap(jsonData);
}

String StageToJson(Stage data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Stage {
  String stage_word_type;
  List<Word> word_list;

  Stage({this.stage_word_type, this.word_list});

  factory Stage.fromMap(Map<String, dynamic> json) => new Stage(
    stage_word_type: json["stage_word_type"],
    word_list: json["word_list"],
  );

  Map<String, dynamic> toMap() => {
    "stage_word_type": stage_word_type,
    "word_list": word_list,
  };
}
