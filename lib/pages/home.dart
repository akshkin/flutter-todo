import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/components/todo.dart';
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
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                          "No active todos. Add new todo using the button below"),
                      completedTodos.isNotEmpty
                          ? TextButton(
                              onPressed: () => Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  duration: const Duration(milliseconds: 400),
                                  reverseDuration:
                                      const Duration(milliseconds: 400),
                                  child: const CompletedTodos(),
                                ),
                              ),
                              child: const Text("Completed todos"),
                            )
                          : Container()
                    ],
                  ),
                ),
              );
            } else if (index == activeTodos.length) {
              if (completedTodos.isEmpty) {
                return Container();
              } else {
                return Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: const Duration(milliseconds: 400),
                          reverseDuration: const Duration(milliseconds: 400),
                          child: const CompletedTodos()),
                    ),
                    child: const Text("Completed todos"),
                  ),
                );
              }
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
                      backgroundColor: Colors.red,
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
                      backgroundColor: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      icon: Icons.check_box_outline_blank,
                    )
                  ],
                ),
                child: TodoItem(index: index, todos: activeTodos),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: const Duration(milliseconds: 400),
                reverseDuration: const Duration(milliseconds: 400),
                child: const AddTodo()),
          );
        },
        tooltip: 'Increment',
        // foregroundColor: const Color.fromARGB(255, 20, 4, 27),
        child: const Icon(Icons.add),
      ),
    );
  }
}
