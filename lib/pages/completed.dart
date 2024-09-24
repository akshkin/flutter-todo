import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo.provider.dart';

class CompletedTodos extends ConsumerWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> completedTodos =
        todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Todos'),
      ),
      body: ListView.builder(
          itemCount: completedTodos.length,
          itemBuilder: (context, index) {
            return Slidable(
                startActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      ref
                          .watch(todoProvider.notifier)
                          .deleteTodo(todos[index].todoId);
                    },
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icons.delete,
                  )
                ]),
                child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 251, 219, 247),
                        borderRadius: BorderRadius.circular(10)),
                    child:
                        ListTile(title: Text(completedTodos[index].content))));
          }),
    );
  }
}
