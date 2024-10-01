import 'package:todo/models/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String content) {
    state = [
      ...state,
      Todo(
        todoId: state.isEmpty ? 0 : state[state.length - 1].todoId + 1,
        content: content,
        completed: false,
        date: DateTime.now(),
      )
    ];
  }

  void completedTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.todoId == id)
          Todo(
            todoId: todo.todoId,
            content: todo.content,
            completed: !todo.completed,
            date: todo.date,
            completedDate: DateTime.now(),
          )
        else
          todo
    ];
  }

  void deleteTodo(int id) {
    state = state.where((todo) => todo.todoId != id).toList();
  }
}
