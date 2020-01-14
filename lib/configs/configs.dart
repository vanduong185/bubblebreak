class Configs {
  static const NUMBER_OF_STAGE = 10;

  static String apiURL = "https://bubblesbreak.mana-b.com/api/bubblesBreak/getWordList";
  
  static dynamic bodyRequestAPI = {
    "api_token": "Egmk7Yu4Ycs9tQQ1heytc1b3guL3N7tMwFrqnkkEdfa18PZJcu1t84ENQaPC",
    "user_id": "1",
    "is_test": "0",
    "is_desktop": "1"
  };

  static String getWordTypeJp(String type) {
    if (type == "noun") return "名詞";
    if (type == "verb") return "動詞";
    if (type == "adjective") return "形容詞";

    return "Unknown";
  }
}