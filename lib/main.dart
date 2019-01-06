import 'package:flutter/material.dart';
import 'words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toki Pona Dictionary',
      theme: new ThemeData(
        primaryColor: Colors.amber[200],
      ),
      home: AllWords(),
    );
  }
}

class AllWords extends StatelessWidget {
  final _words = tokiPonaDict.keys.toList();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildWordList(context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build
      itemCount: _words.length,
      // Provide a builder function. This is where the magic happens! We'll
      // convert each item into a Widget based on the type of item it is.
      itemBuilder: (context, index) {
        final word = _words[index];
        return _buildRow(word, context);
      },
    );
  }

  Widget _buildRow(String word, context) {
    final item = tokiPonaDict[word];
    final dictWord = DictWord(word: word, definitions: item['definitions']);

    return ListTile(
      title: Text(
        word,
        style: _biggerFont,
      ),
      subtitle: Text.rich(
        TextSpan(
            children: dictWord.definitions
                .map((d) => d.asTextSpans())
                .expand((i) => i)
                .toList()),
      ),
      trailing: Text(word,
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'LinjaPona', fontSize: 18.0)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetailScreen(word: dictWord),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toki Pona Dictionary'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.search), onPressed: null),
          new IconButton(icon: const Icon(Icons.settings), onPressed: null),
        ],
      ),
      body: _buildWordList(context),
    );
  }
}

class WordDetailScreen extends StatelessWidget {
  // Declare a field that holds the word
  final DictWord word;

  // In the constructor, require a word
  WordDetailScreen({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
        appBar: AppBar(
          title: Text("${word.word}"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(
                    children: word.definitions
                        .map((d) => d.asTextSpans())
                        .expand((i) => i)
                        .toList()),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.blueAccent)),
              child: Text(
                word.word,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'LinjaPona', fontSize: 30.0),
              ),
            )
          ],
        ));
  }
}
