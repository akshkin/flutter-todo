import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
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
            if (activeTodos.isEmpty) {
              return const Padding(
                padding: EdgeInsets.fromLTRB(8, 30, 8, 0),
                child: Center(
                  child: Text(
                      "No active todos. Add new todo using the button below"),
                ),
              );
            }

            if (index == activeTodos.length) {
              if (completedTodos.isEmpty) {
                return Container();
              } else {
                return Center(
                    child: TextButton(
                        onPressed: () => Navigator.of(context).push(
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                duration: const Duration(milliseconds: 400),
                                reverseDuration:
                                    const Duration(milliseconds: 400),
                                child: const CompletedTodos())),
                        child: const Text("Completed todos")));
              }
            } else {
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
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        ref
                            .watch(todoProvider.notifier)
                            .completedTodo(todos[index].todoId);
                      },
                      backgroundColor: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      icon: Icons.check_box_outline_blank,
                    )
                  ]),
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 251, 219, 247),
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          ListTile(title: Text(activeTodos[index].content))));
            }
            // }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: const Duration(milliseconds: 400),
              reverseDuration: const Duration(milliseconds: 400),
              child: const AddTodo()));
        },
        tooltip: 'Increment',
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
