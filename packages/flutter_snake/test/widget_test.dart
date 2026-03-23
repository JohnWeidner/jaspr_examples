import 'package:flutter/material.dart';
import 'package:flutter_snake/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SnakeApp', () {
    testWidgets('renders SnakePage', (tester) async {
      await tester.pumpWidget(const SnakeApp());
      expect(find.byType(SnakePage), findsOneWidget);
    });
  });

  group('SnakePage — notStarted state', () {
    testWidgets('shows the SNAKE title', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SnakePage()));
      expect(find.text('SNAKE'), findsOneWidget);
    });

    testWidgets('shows score of 0', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SnakePage()));
      expect(find.text('Score: 0'), findsOneWidget);
    });

    testWidgets('shows the start prompt', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SnakePage()));
      expect(find.text('Press an arrow key to start.'), findsOneWidget);
    });

    testWidgets('does not show Play Again', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SnakePage()));
      expect(find.text('Play Again'), findsNothing);
    });
  });
}
