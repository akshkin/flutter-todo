import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/components/todo.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo.provider.dart';
import 'package:todo/theme/colors.dart';

class ActiveTodos extends ConsumerWidget {
  const ActiveTodos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos =
        todos.where((todo) => todo.completed == false).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Todos'),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length,
        itemBuilder: (context, index) {
          if (activeTodos.isEmpty) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(8, 30, 8, 0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                        "No active todos. Add new todo using the button below"),
                  ],
                ),
              ),
            );
          } else {
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      ref
                          .watch(todoProvider.notifier)
                          .deleteTodo(activeTodos[index].todoId);
                    },
                    backgroundColor: ColorPallete.red,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icons.delete,
                  )
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      ref
                          .watch(todoProvider.notifier)
                          .completedTodo(activeTodos[index].todoId);
                    },
                    backgroundColor: ColorPallete.greenDark,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icons.check_box_outline_blank,
                  )
                ],
              ),
              child: TodoItem(index: index, todos: activeTodos),
            );
          }
        },
      ),
    );
  }
}
