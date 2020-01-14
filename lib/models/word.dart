import 'dart:convert';

Word wordFromJson(String str) {
  final jsonData = json.decode(str);
  return Word.fromMap(jsonData);
}

String wordToJson(Word data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Word {
  int wordID;
  String engWord;
  String japanWord;
  String engSentenceSoundUrl;
  String engSentence;
  String wordType;

  Word({this.wordID, this.engWord, this.japanWord, this.engSentenceSoundUrl, this.engSentence, this.wordType});

  factory Word.fromMap(Map<String, dynamic> json) => new Word(
    wordID: json["word_id"],
    engWord: json["eng_word"],
    japanWord: json["japan_word"],
    engSentenceSoundUrl: json["eng_sentence_sound_url"],
    engSentence: json["eng_sentence"],
    wordType: json["word_type"]
  );

  Map<String, dynamic> toMap() => {
    "wordID": wordID,
    "engWord": engWord,
    "japanWord": japanWord,
    "engSentenceSoundUrl": engSentenceSoundUrl,
    "engSentence": engSentence,
    "wordType": wordType
  };
}
