import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/providers/todo.provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
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
                child: ListTile(title: Text(todos[index].content)));
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
