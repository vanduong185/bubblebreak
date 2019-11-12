import 'dart:convert';

Word WordFromJson(String str) {
  final jsonData = json.decode(str);
  return Word.fromMap(jsonData);
}

String WordToJson(Word data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Word {
  int word_id;
  String eng_word;
  String japan_word;
  String eng_sentence_sound_url;
  String eng_sentence;
  String word_type;

  Word({this.word_id, this.eng_word, this.japan_word, this.eng_sentence_sound_url, this.eng_sentence, this.word_type});

  factory Word.fromMap(Map<String, dynamic> json) => new Word(
    word_id: json["word_id"],
    eng_word: json["eng_word"],
    japan_word: json["japan_word"],
    eng_sentence_sound_url: json["eng_sentence_sound_url"],
    eng_sentence: json["eng_sentence"],
    word_type: json["word_type"]
  );

  Map<String, dynamic> toMap() => {
    "word_id": word_id,
    "eng_word": eng_word,
    "japan_word": japan_word,
    "eng_sentence_sound_url": eng_sentence_sound_url,
    "eng_sentence": eng_sentence,
    "word_type": word_type
  };
}
