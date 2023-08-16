// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:puzzle/main.dart';

void main() {
  testWidgets('スタート画面が表示される', (WidgetTester tester) async {
    // ここにテストの内容を書く

    // MyAppを読み込む
    await tester.binding.setSurfaceSize(const Size(400, 800)); // 画面サイズを指定
    await tester.pumpWidget(const MyApp());

    // 特定のWidgetが表示されていることを確認する
    final titleFinder = find.text('スライドパズル');
    // final titleFinder = find.text('ABCパズル'); // 故意にテストエラーを出す
    final buttonFinder = find.text('スタート');

    // 特定したWidgetが1つだけ存在することを確認する
    expect(titleFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('スタートボタンをタップするとパズル画面が表示される', (WidgetTester tester) async {
    // MyAppを読み込む
    await tester.binding.setSurfaceSize(const Size(400, 800));
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('スタート'));
    await tester.pumpAndSettle(); // Widgetの状態が更新,表示されるのを待つ

    // パズル番号[1-8]が存在するかチェック
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);

    // シャッフルボタンが存在するかチェック
    expect(find.text('シャッフル'), findsOneWidget);
  });
}
