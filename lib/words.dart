import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
  "ale  or  ali": {
    "definitions": [
      {
        "pos": "ADJECTIVE",
        "def": "all; abundant, countless, bountiful, every, plentiful"
      },
      {"pos": "NOUN", "def": "abundance, everything, life, universe"},
      {"pos": "NUMBER", "def": "100"}
    ]
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
