import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'words.dart';

void main() => runApp(MyApp(dictWords: loadDict()));

class MyApp extends StatelessWidget {
  final Future<List<DictWord>> dictWords;

  MyApp({Key key, this.dictWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Toki Pona Dictionary',
        theme: ThemeData(
          primaryColor: Colors.amber[200],
        ),
        home: HomePage(dictWords: dictWords),
        routes: <String, WidgetBuilder>{
          SettingsPage.routeName: (context) => SettingsPage(),
        });
  }
}

class HomePage extends StatefulWidget {
  final Future<List<DictWord>> dictWords;
  HomePage({Key key, this.dictWords}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildWordList(context) {
    return FutureBuilder<List>(
        future: widget.dictWords,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var words = snapshot.data;
            return ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, index) {
                  final word = words[index];
                  return _buildRow(word, context);
                });
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildRow(DictWord word, context) {
    // final _rootWord = word.word.split(' (')[0];

    return ListTile(
      title: Text(
        word.word,
        style: _biggerFont,
      ),
      subtitle: Text.rich(
        TextSpan(
            children: word.definitions
                .map((d) => [
                      TextSpan(
                          text: "${d.pos}. ",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      TextSpan(text: "${d.def}\n")
                    ])
                .expand((i) => i)
                .toList()),
      ),
      trailing: Text("${word.getMainWord()} \t",
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'LinjaPona', fontSize: 18.0)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetailScreen(word: word),
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
            new IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () =>
                    Navigator.of(context).pushNamed(SettingsPage.routeName)),
          ],
        ),
        body: _buildWordList(context));
  }
}

class WordDetailScreen extends StatelessWidget {
  // Declare a field that holds the word
  final DictWord word;

  // In the constructor, require a word
  WordDetailScreen({Key key, @required this.word}) : super(key: key);

  List<TextSpan> _fmtDefinitions(List<Definition> defs) {
    List<TextSpan> textSpans = [];
    for (var i = 0; i < defs.length; i++) {
      var d = defs[i];
      textSpans.add(TextSpan(text: "${i + 1})\t\t"));
      textSpans.add(TextSpan(
          text: "${d.pos}\n", style: TextStyle(fontStyle: FontStyle.italic)));
      textSpans.add(TextSpan(text: "\t\t\t\t\t${d.def}\n"));
      if (d.eg != "") {
        textSpans.add(TextSpan(text: "\t\t\t\t\tEg. ${d.eg}\n"));
      }
      textSpans.add(TextSpan(text: "\n"));
    }
    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    final _rootWord = "  \"    " + word.word.split(' (')[0] + " \"";
    print(_rootWord);

    // Use the Todo to create our UI
    return Scaffold(
        appBar: AppBar(
          title: Text("${word.word}"),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text.rich(
              TextSpan(children: _fmtDefinitions(word.definitions)),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.blueAccent)),
            child: Text(
              _rootWord,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'LinjaPona', fontSize: 30.0),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.blueAccent)),
              child: Text("e\t",
                  style: TextStyle(
                    fontFamily: 'LinjaPona',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textScaleFactor: 1.0,
                  maxLines: 10))
        ]));
  }
}

class SettingsPage extends StatefulWidget {
  static String routeName = "/settingsPage";
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _switchValue = false;

  @override
  void initState() {
    SharedPreferencesHelper.getCompoundWordSetting().then((show) {
      setState(() => this._switchValue = show);
    });
    super.initState();
  }

  Widget _buildSwitch() {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Include common compound words"),
          Switch.adaptive(
              value: _switchValue,
              onChanged: (bool value) {
                SharedPreferencesHelper.setCompoundWordSetting(value);
                setState(() {
                  _switchValue = value;
                });
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Column(children: [
          _buildSwitch(),
          Text(
              "The symbols are rendered using jan Same's linja pona font, a rendition of the \"sitelen pona\” script for toki pona.")
        ]));
  }
}

class SharedPreferencesHelper {
  static final String showCompoundWords = "showCompoundWords";

  static Future<bool> getCompoundWordSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(showCompoundWords) ?? false;
  }

  static Future<bool> setCompoundWordSetting(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(showCompoundWords, value);
  }
}
