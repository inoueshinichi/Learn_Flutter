import 'package:flutter/material.dart';
import 'basic/basic_widgets.dart';
import 'single_child_layout/single_child_layout_widgets.dart';

void main() {
  runApp(const WidgetCollectionsApp());
}

class WidgetCollectionsApp extends StatelessWidget {
  const WidgetCollectionsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WidgetCollections',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // スタート画面表示
      home: const StartPage(),
    );
  }
}

/* 画面遷移(ナビゲーション) */
void routingBasicWidgetsPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BasicWidgetsPage()),
  );
}

void routingSingleChildLayoutWidgetsPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SingleChildLayoutWidgetsPage()),
  );
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Book'),
      ),
      body: GridMenuView(),
    );
  }
}

class GridMenuView extends StatelessWidget {
  const GridMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      shrinkWrap: true,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            '初級',
            style: TextStyle(fontSize: 24),
          ),
        ),
        ElevatedButton(
          onPressed: () => routingBasicWidgetsPage(context),
          child: const Text('A'),
        ),
        ElevatedButton(
          onPressed: () => routingSingleChildLayoutWidgetsPage(context),
          child: const Text('B'),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('C'),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('D'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text(
            '中級',
            style: TextStyle(fontSize: 24),
          ),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('E'),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('F'),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('G'),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('H'),
        ),
      ],
    );
  }
}
