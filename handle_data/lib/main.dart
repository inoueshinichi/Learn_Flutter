import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:io';

// ライブラリ(pub spec)
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const HandleDataApp());
}

class HandleDataApp extends StatelessWidget {
  const HandleDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handle Data App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HandleDataPage(title: 'Handle Data Page'),
    );
  }
}

class HandleDataPage extends StatefulWidget {
  // プロパティ
  final String title;

  const HandleDataPage({super.key, required this.title});

  @override
  State<HandleDataPage> createState() => _HandleDataPageState();
}

class _HandleDataPageState extends State<HandleDataPage> {
  // 状態
  final _controller = TextEditingController();
  final _filename = 'flutter_sample_data.txt';
  final _resource_filename = 'assets/documents/test_resource_data.txt';

  // 設定情報からの値を一時保存
  double _r = 0.0;
  double _g = 0.0;
  double _b = 0.0;

  @override
  void initState() {
    super.initState();
    loadFromPrefs();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'FILE ACCESS.',
              style: TextStyle(fontSize: 32, fontWeight: ui.FontWeight.w500),
            ),
            Text(
              "下記に保存したいテキストを記入してください",
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextField(
                controller: _controller,
                style: TextStyle(fontSize: 24),
                minLines: 1,
                maxLines: 5),
            Text('設定値で画像のグラデーションを変更する'),
            Padding(padding: EdgeInsets.all(10.0)),
            Slider(
              min: 0.0,
              max: 255.0,
              value: _r,
              divisions: 255,
              onChanged: (double value) {
                setState(() {
                  _r = value;
                });
              },
            ),
            Slider(
              min: 0.0,
              max: 255.0,
              value: _g,
              divisions: 255,
              onChanged: (double value) {
                setState(() {
                  _g = value;
                });
              },
            ),
            Slider(
              min: 0.0,
              max: 255.0,
              value: _b,
              divisions: 255,
              onChanged: (double value) {
                setState(() {
                  _b = value;
                });
              },
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              width: 125,
              height: 125,
              color: Color.fromARGB(255, _r.toInt(), _g.toInt(), _b.toInt()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.amber,
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Save to Device',
            icon: Icon(Icons.save, color: Colors.white, size: 32),
          ),
          BottomNavigationBarItem(
            label: 'Load from Device',
            icon: Icon(Icons.open_in_new, color: Colors.white, size: 32),
          ),
          BottomNavigationBarItem(
            label: 'Save to Prefs',
            icon: Icon(Icons.save, color: Colors.white, size: 32),
          ),
        ],
        onTap: (int value) async {
          switch (value) {
            case 0:
              // Save to Device
              saveToDevice(_controller.text);
              setState(() {
                _controller.text = '';
              });
              final dirname = await getDocDirname();
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("saved!"),
                  content: Text("saved to ${dirname}"),
                ),
              );
              break;
            case 1:
              // Load from Device
              String value = await loadFromDevice();
              setState(() {
                _controller.text = value;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("loaded!"),
                  content: Text("load message from file."),
                ),
              );
              break;
            case 2:
              // Save to Prefs
              saveToPrefs();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("saved!"),
                        content: Text("save preferences."),
                      ));
              break;
            default:
              print('no default.');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.open_in_new),
          onPressed: () async {
            String text;
            try {
              text = await getDataOfAssetsFromResource(_resource_filename);
            } catch (e) {
              text = "*** no data in assets ***";
            }
            setState(() {
              _controller.text = text;
            });
          }),
    );
  }

  // デバイスの保存先ディレクトリパスを取得
  Future<String> getDocDirname() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // デバイスの保存先のファイルパスを取得
  Future<File> getDataFileFromDevice(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File(directory.path + '/' + filename);
  }

  // デバイスの保存先にファイル内容を保存
  void saveToDevice(String value) async {
    final file = await getDataFileFromDevice(_filename);
    file.writeAsString(value);
  }

  // デバイスの保存先からファイル内容を読み込み
  Future<String> loadFromDevice() async {
    // 非同期の場合try...catch...でエラーバンドリングすること.
    try {
      final file = await getDataFileFromDevice(_filename);
      return file.readAsString();
    } catch (e) {
      return '*** no data ***';
    }
  }

  // リソースからファイルを読み込む
  Future<String> getDataOfAssetsFromResource(String path) async {
    // アセットを操作
    return await rootBundle.loadString(path);
  }

  // 設定情報からデータを読み込む(KVS系)
  // 扱える型: int, double, bool, String, List<String>
  // Shared Preferencesライブラリが必要.
  /* 設定情報に保存 */
  void saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('r', _r);
    prefs.setDouble('g', _g);
    prefs.setDouble('b', _b);
  }

  /* 設定情報を読み込む */
  void loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _r = (prefs.getDouble('r') ?? 0.0);
      _g = (prefs.getDouble('g') ?? 0.0);
      _b = (prefs.getDouble('b') ?? 0.0);
    });
  }
}
