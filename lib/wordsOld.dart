//Future class for single user information
Future<TokiPonaDict> loadDict(Future<String> data) async {
  // await wait(5);
  String jsonString = await data;
  final jsonResponse = json.decode(jsonString);
  print(jsonString);

  print("=== in loadDict ====");
  print(jsonResponse);
  return TokiPonaDict.fromJson(jsonResponse);
  // final jsonresponse = json.decode(response.body);
  // return SingleUser.fromJson(jsonresponse[0]["Employee"]);
}

class TokiPonaDict {
  List<dynamic> name;

  TokiPonaDict(name);

  factory TokiPonaDict.fromJson(Map<String, dynamic> parsedJson) {
    return TokiPonaDict(parsedJson['name']);
  }

  toString() {
    return ("TokiPonaDict: $name");
  }
}

// Future<String> _loadAsset() async {
//   return await rootBundle.loadString('assets/config.json');
// }

// Future loadWords() async {
//   String words = await _loadAsset();
//   print(words);
// }

class DictWord {
  String word;
  List<Definition> definitions;

  DictWord(
      {@required String word,
      @required List<Map<String, String>> definitions}) {
    this.word = word;
    this.definitions = definitions.map((d) {
      return Definition(d['pos'], d['def']);
    }).toList();
  }

  @override
  String toString() {
    return "DictWord[$word]";
  }
}

class Definition {
  final String pos;
  final String def;
  Definition(this.pos, this.def);

  List<TextSpan> asTextSpans() {
    return [
      TextSpan(
        text: "$pos. ",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      TextSpan(
        text: "$def\n",
      )
    ];
  }
}

const tokiPonaDict = {
  "ala": {
    "definitions": [
      {"pos": "ADJECTIVE", "def": "no, not, zero"}
    ],
  },
  "alasa": {
    "definitions": [
      {"pos": "VERB", "def": "to hunt, forage"}
    ]
  },
  "ale": {
    "definitions": [
      {
        "pos": "ADJECTIVE",
        "def": "all; abundant, countless, bountiful, every, plentiful"
      },
      {"pos": "NOUN", "def": "abundance, everything, life, universe"},
      {"pos": "NUMBER", "def": "100"}
    ],
  },
  "pakala": {
    "definitions": [
      {
        "pos": "ADJECTIVE",
        "def": "all; abundant, countless, bountiful, every, plentiful"
      },
      {"pos": "NOUN", "def": "abundance, everything, life, universe"},
      {"pos": "NUMBER", "def": "100"}
    ],
  },
  "o": {
    "definitions": [
      {
        "pos": "ADJECTIVE",
        "def": "all; abundant, countless, bountiful, every, plentiful"
      },
      {"pos": "NOUN", "def": "abundance, everything, life, universe"},
      {"pos": "NUMBER", "def": "100"}
    ],
  },
};

const tokiPonaJson = """
{
   "words":[
      {
         "word":"ala",
         "definitions":[
            {
               "pos":"ADJECTIVE",
               "def":"no, not, zero"
            }
         ]
      },
      {
         "word":"alasa",
         "definitions":[
            {
               "pos":"VERB",
               "def":"to hunt, forage"
            }
         ]
      },
      {
         "word":"ale  or  ali",
         "definitions":[
            {
               "pos":"ADJECTIVE",
               "def":"all; abundant, countless, bountiful, every, plentiful"
            },
            {
               "pos":"NOUN",
               "def":"abundance, everything, life, universe"
            },
            {
               "pos":"NUMBER",
               "def":"100"
            }
         ]
      }
   ]
}
""";

const moreWords = {
  "anpa": {
    "definitions": {
      "ADJECTIVE": {"def": "bowing down, downward, humble, lowly, dependent"}
    }
  },
  "ante": {
    "definitions": {
      "ADJECTIVE": {"def": "different, altered, changed, other"}
    }
  },
  "anu": {
    "definitions": {
      "PARTICLE": {"def": "or"},
    }
  },
  "awen": {
    "definitions": {
      "ADJECTIVE": {
        "def":
            "enduring, kept, protected, safe, waiting, staying\nPRE-VERB to continue to"
      }
    }
  },
  "e": {
    "definitions": {
      "PARTICLE": {"def": "(before the direct object)"},
    }
  },
  "en": {
    "definitions": {
      "PARTICLE": {"def": "(between multiple subjects)"}
    }
  },
};
