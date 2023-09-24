import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// basic_1.dart
import 'basic_1.dart';

/* 画面遷移(ナビゲーション) */
void routingBasic1Widgets(BuildContext context) {
  const title = 'Basic1Widgets';
  const message = 'Basic1Widgetsページ';
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Basic1WidgetsPage(
      title: title,
      message: message,
    )),
  );
}

class Flutter3TutorialLayoutWidgetsPage extends StatelessWidget {
  const Flutter3TutorialLayoutWidgetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter3 Tutorial Layout Widgets'),
      ),
      body: FTGridMenuView(),
    );
  }
}

class FTGridMenuView extends StatelessWidget {
  const FTGridMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      shrinkWrap: true,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: <Widget>[
        ElevatedButton(
          onPressed: () => routingBasic1Widgets(context),
          child: const Text('A'),
        ),
        ElevatedButton(
          onPressed: () => {},
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
        ElevatedButton(
          onPressed: () => {},
          child: const Text('I'),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('J'),
        ),
      ],
    );
  }
}
