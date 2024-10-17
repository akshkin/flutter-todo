import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/providers/todo.provider.dart';

void main() {
  late ProviderContainer container;
  late TodoListNotifier notifier;

  setUp(() {
    container = ProviderContainer();
    notifier = container.read(todoProvider.notifier);
  });

  test("todo list starts empty", () {
    expect(notifier.state, []);
  });
  test("add todo", () {
    notifier.addTodo("finish flutter");
    expect(notifier.state[0].content, "finish flutter");
  });

  test("delete todo", () {
    notifier.addTodo("finish flutter");
    expect(notifier.state[0].content, "finish flutter");

    notifier.deleteTodo(0);
    expect(notifier.state, []);
  });
  test("complete todo", () {
    notifier.addTodo("finish flutter");
    expect(notifier.state[0].content, "finish flutter");
    expect(notifier.state[0].completed, false);

    notifier.completedTodo(0);
    expect(notifier.state[0].completed, true);
  });
}
