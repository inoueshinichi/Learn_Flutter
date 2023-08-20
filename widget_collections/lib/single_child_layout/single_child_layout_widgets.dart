import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'container.dart';

/* 画面遷移(ナビゲーション) */
void routingContainerPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ContainerPage()),
  );
}

class SingleChildLayoutWidgetsPage extends StatelessWidget {
  const SingleChildLayoutWidgetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Child Layout Widgets'),
      ),
      body: SCLGridMenuView(),
    );
  }
}

class SCLGridMenuView extends StatelessWidget {
  const SCLGridMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      shrinkWrap: true,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        ElevatedButton(
          onPressed: () => routingContainerPage(context),
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
