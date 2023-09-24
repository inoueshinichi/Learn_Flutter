import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Basic1WidgetsPage extends StatefulWidget {
  final String title;
  final String message;

  const Basic1WidgetsPage(
      {Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  _Basic1WidgetsPageState createState() => _Basic1WidgetsPageState();
}

// データ用クラス
class Data {
  int _price;
  String _name;
  Data(this._name, this._price) : super();

  @override
  String toString() {
    return _name + ':' + _price.toString() + '円';
  }
}

class _Basic1WidgetsPageState extends State<Basic1WidgetsPage> {
  String _message = '初期値';

  // サンプルデータ
  static final _data = [
    Data('Apple', 200),
    Data('Orange', 150),
    Data('Peach', 300),
  ];

  Data _item = _data[0];

  // 初期状態を作るメソッド
  @override
  void initState() {
    _message = widget.message;
  }

  void _setData() {
    setState(() {
      _item = (_data..shuffle()).first;
    });
  }

  void _setMessage() {
    setState(() {
      _message = 'タップしました!';
    });
  }

  @override
  Widget build(BuildContext context) {
    // StatefulWidgetのプロパティを設定
    // _message = widget.message;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              _message,
              style: TextStyle(fontSize: 32.0),
            ),
            Text(
              _item.toString(),
              style: TextStyle(fontSize: 32.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setMessage,
        tooltip: 'set message',
        child: Icon(Icons.star),
      ),
    );
  }
}
