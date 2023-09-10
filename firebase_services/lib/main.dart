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
  final _controller = TextEditingController();

  void fire() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('my_collection').get();
    var msg = '';
    snapshot.docChanges.forEach((element) {
      final name = element.doc.get('name');
      final mail = element.doc.get('mail');
      final age = element.doc.get('age');
      msg += "${name} (${age}) <${mail}>";
    });

    _controller.text = msg;
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
            Text(
              _controller.text,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            fire();
          });
        },
        tooltip: 'Firestore',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
