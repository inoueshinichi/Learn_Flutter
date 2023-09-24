import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:convert'; // utf-8 <=> utf-16
import 'dart:io';
import 'package:firebase_core/firebase_core.dart'; // firebase core
import 'firebase_options.dart'; // flutterfire_cliにより自動作成
import 'package:cloud_firestore/cloud_firestore.dart'; // could firestore

void main() async {
  // Firebaseの初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    /* 設定情報 */
    options: /* アプリが実行されているプラットフォーム用の設定情報 */
        DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter with Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter with Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 状態
  final _cntlOutput = TextEditingController();
  final _cntlInput = TextEditingController();

  void fire() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot /*QuerySnapshot*/ = await firestore
        .collection('my_collection') /*CollectionReference*/
        .get();

    var msg = '';

    // コレクションのドキュメント類は, QuerySnapshotのdocChagesプロパティに保管されている
    // docChanges: List[DocumentChange]
    snapshot.docChanges.forEach((element /*DocumentChange*/) {
      final name = element.doc
          /*DocumentSnapshot*/
          .get('name');
      final mail = element.doc.get('mail');
      final age = element.doc.get('age');
      msg += "${name} (${age}) <${mail}>\n";
    });

    _cntlOutput.text = msg;
  }

  void fireFilter() async {
    var inMsg = _cntlInput.text;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
        .collection('my_collection')
        .where('name', isEqualTo: inMsg) // Queryクラス 名前でフィルタ
        .get();

    /* documentのフィルタリング
    isEqualTo: 値
    isNotEqualTo: 値
    isLessThan: 値
    isLessThanOrEqualTo: 値
    isGreaterThan: 値
    isGreaterThanOrEqualTo: 値
    arrayContains: 値 リストに指定の値を含む
    arrayContainsAny: [リスト] リストに指定の値のいずれかを含む
    whereIn: [リスト] 指定の値のいずれかを含む
    whereNotIn: [リスト] 指定の値のいずれも含まない
    isNull: 真偽値 nullかどうか
    */

    var outMsg = "";
    snapshot.docChanges.forEach((element) {
      final name = element.doc.get('name');
      final mail = element.doc.get('mail');
      final age = element.doc.get('age');
      outMsg += "${name} (${age}) <${mail}>";
    });
    _cntlOutput.text = outMsg;
  }

  void fireFilterSort() async {
    var msg = _cntlInput.text;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    /* Queryクラスは, コレクションからドキュメントを取り出すために必要なメソッドを多く持つ */
    final snapshot = await firestore
        .collection('my_collection')
        .orderBy('name', descending: false) /*Query*/
        .startAt([msg]).endAt(
            [msg + '\uf8ff']) /* '\uf8ff': ◯, ◯◯, ...., ◯◯◯...◯ を示す */
        .get();

    /* ドキュメントのフィルタリング
    limit(値) 引数の数値の数だけ取り出す
    startAt([リスト]) 引数の値以降のものを取り出す
    startAfter([リスト]) 引数の値より後のものを取り出す
    endAt([リスト]) 引数の値以前のものを取り出す
    endBefore([リスト]) 引数の値より前のものを取り出す
    startAtDocument(値) 引数のドキュメント以降のものを取り出す
    startAfterDocument(値) 引数のドキュメントより後のものを取り出す
    endAtDocument(値) 引数のドキュメント以前のものを取り出す
    endBeforeDocument(値) 引数のドキュメントより前のものを取り出す
    */
    var outMsg = "";
    snapshot.docChanges.forEach((element) {
      final name = element.doc.get('name');
      final mail = element.doc.get('mail');
      final age = element.doc.get('age');
      outMsg += "${name} (${age}) <${mail}>";
    });
    _cntlOutput.text = outMsg;
  }

  void fireAddDoc() async {
    // データ作成
    var inMsg = _cntlInput.text;
    final input = inMsg.split(',');
    final data = /*Map<String, dynamic>*/ {
      'name': input[0],
      'mail': input[1],
      'age': input[2],
    };

    // ドキュメント追加
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 自動ID
    // final snapshot = await firestore.collection('my_collection').add(data);

    // 手動ID
    final snapshot = await firestore
        .collection('my_collection')
        .doc('my_document3')
        .set(data);

    // 表示
    this.fire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Internet access throgh firestore",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("input"),
            TextField(
                controller: _cntlInput,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  fontSize: 28.0,
                  color: const Color(0xffFF0000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                )),
            Text("output"),
            TextField(
                controller: _cntlOutput,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  fontSize: 28.0,
                  color: const Color(0xffFF0000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                )),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // fire();
            // fireFilter();
            fireAddDoc();
          });
        },
        tooltip: 'Firestore',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
