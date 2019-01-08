import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'words.dart';

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Toki Pona Dictionary',
        theme: ThemeData(
          primaryColor: Colors.amber[200],
        ),
        home: HomePage(post: post),
        routes: <String, WidgetBuilder>{
          SettingsPage.routeName: (context) => SettingsPage(),
        });
  }
}

class HomePage extends StatefulWidget {
  final Future<Post> post;
  HomePage({Key key, this.post}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Center(
        child: FutureBuilder<Post>(
          future: widget.post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  static String routeName = "/nextPage";
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
      alignment: const Alignment(0.0, -0.2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Include common compound words"),
          Switch.adaptive(
              value: _switchValue,
              onChanged: (bool value) {
                SharedPreferencesHelper.setCompoundWordSetting(value);
                // setState(() {
                //   _switchValue = value;
                // });
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
        body: _buildSwitch());
  }
}

class SharedPreferencesHelper {
  static final String showCompoundWords = "showCompoundWords";

  static Future<bool> getCompoundWordSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(showCompoundWords) ?? false;
  }

  static Future<bool> setCompoundWordSetting(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(showCompoundWords, value);
  }
}
