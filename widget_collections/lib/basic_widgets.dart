import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicWidgetsPage extends StatefulWidget {
  const BasicWidgetsPage({Key? key}) : super(key: key);

  @override
  _BasicWidgetsPageState createState() => _BasicWidgetsPageState();
}

class _BasicWidgetsPageState extends State<BasicWidgetsPage> {
  String name = "shinichi";
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    rootBundle.load("assets/images/nekosan.png").then((data) {
      if (mounted) {
        setState(() {
          bytes = data.buffer.asUint8List(); // UInt8List
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // styleプロパティは, TextStyleクラスを使用するのではなく,
    // TextThemeクラスを使うと一貫性がでる.
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    // final titleStyle = textTheme.title.copyWith(color: theme.backgroundColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Widgets'),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            // Textウィジェット
            Text(
              'Hello, $name! How are you ?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 100,
              height: 50,
            ),
            // RichTextウィジェット
            const Text.rich(TextSpan(
              text: 'Hello',
              children: <TextSpan>[
                TextSpan(
                    text: ' beautiful ',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text: 'world',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            )),
            // strutStyleプロパティ: 文字の高さや上下文字列とのpadding設定
            const Text(
              "strutStyle",
              strutStyle: StrutStyle(
                leading: 3.0,
                height: 1.0,
              ),
            ),
            // textAlignプロパティ: 水平方向のアライメント
            const Text(
              "textAlign",
              textAlign: TextAlign.right,
            ),
            // softWrapプロパティとoverflowプロパティによる親ウィジェットから
            // はみ出す文字列の折返し処理
            const Text(
              "あいうえお.かきくけこ.さしすせそ.たちつてと.なにぬねの.はひふへほ.",
              softWrap: false,
              // overflow: TextOverflow.clip,
              // overflow: TextOverflow.fade,
              overflow: TextOverflow.ellipsis,
              // overflow: TextOverflow.visible,
            ),
            // maxLinesプロパティ: 行数を指定する
            const Text(
              "あいうえお.かきくけこ.さしすせそ.たちつてと.なにぬねの.はひふへほ.",
              maxLines: 3,
            ),
            // textScaleFactorプロパティ: フォントサイズのスケールを設定
            const Text(
              "Scale",
              textScaleFactor: 1.5,
            ),
            // textWidthBasicプロパティ: 1行以上のテキストの幅を決める方法を指定する
            // 基本的にTextWidthBasic.longestLineを使用するときに使う.
            const Text(
              "チャットの投稿内容",
              textWidthBasis: TextWidthBasis.longestLine,
            ),
            // DefaultTextStyleウィジェット: 配下のTextウィジェットのスタイルを
            // 一括設定できる
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge!,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[Text('A'), Text('B'), Text('C')],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[Text('E'), Text('F'), Text('G')],
            ),
            // アセット画像
            Image.asset("assets/images/nekosan.png"),
            // ネットワーク画像
            // Image.network("https://image/paty/to/img.png"),
            // 端末内の画像
            // Image.file("device/your/path/to/img.png"),
            // バイトデータからの画像構築
            bytes == null
                ? Container()
                : Image.memory(
                    bytes!,
                    // fit: BoxFit.fill,
                    fit: BoxFit.contain,
                  ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
