// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo/main.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/completed.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/providers/todo.provider.dart';

void main() {
  testWidgets('default state', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    Finder defaultText =
        find.text("No active todos. Add new todo using the button below");
    expect(defaultText, findsOneWidget);
  });

  testWidgets("Completed todos show up on completed page",
      (WidgetTester tester) async {
    TodoListNotifier notifier = TodoListNotifier(
      <Todo>[
        Todo(
          todoId: 0,
          content: "content",
          completed: true,
          date: DateTime.now(),
        )
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [todoProvider.overrideWith((ref) => notifier)],
        child: const MaterialApp(home: CompletedTodos()),
      ),
    );
    Finder completedText = find.text("content");
    expect(completedText, findsOneWidget);
  });
  testWidgets("Slide and delete a todo", (WidgetTester tester) async {
    TodoListNotifier notifier = TodoListNotifier(
      <Todo>[
        Todo(
          todoId: 0,
          content: "content",
          completed: false,
          date: DateTime.now(),
        )
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [todoProvider.overrideWith((ref) => notifier)],
        child: const MaterialApp(home: MyHomePage()),
      ),
    );
    Finder completedText = find.text("content");
    expect(completedText, findsOneWidget);

    Finder draggableWidget = find.byKey(ValueKey("0"));
    Finder deleteButton = find.byKey(ValueKey("0delete"));
    await tester.timedDrag(
        draggableWidget, Offset(200, 0), Duration(seconds: 1));
    await tester.pump();
    await tester.tap(deleteButton);
    await tester.pump();
    Finder defaultText =
        find.text("No active todos. Add new todo using the button below");
    expect(defaultText, findsOneWidget);
  });
}
