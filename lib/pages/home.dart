import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/completed.dart';
import 'package:todo/providers/todo.provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos =
        todos.where((todo) => todo.completed == false).toList();
    List<Todo> completedTodos =
        todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: ListView.builder(
          itemCount: activeTodos.length + 1,
          itemBuilder: (context, index) {
            if (index == activeTodos.length) {
              if (completedTodos.isEmpty) {
                return Container();
              } else {
                return Center(
                    child: TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const CompletedTodos())),
                        child: const Text("Completed todos")));
              }
            } else {
              return Slidable(
                  startActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        ref.watch(todoProvider.notifier).deleteTodo(index);
                      },
                      backgroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      icon: Icons.delete,
                    )
                  ]),
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        ref.watch(todoProvider.notifier).completedTodo(index);
                      },
                      backgroundColor: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      icon: todos[index].completed
                          ? Icons.check_circle
                          : Icons.check_box_outline_blank,
                    )
                  ]),
                  child: ListTile(title: Text(activeTodos[index].content)));
            }
            // }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (content) => const AddTodo()));
        },
        tooltip: 'Increment',
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
