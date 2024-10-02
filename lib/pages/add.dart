import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo.provider.dart';
import 'package:todo/theme/colors.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add todo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: todoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPallete.blueDark,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPallete.blueDark,
              ),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(todoProvider.notifier).addTodo(todoController.text);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPallete.transparent,
                    shadowColor: ColorPallete.transparent
                    // foregroundColor: Colors.white,
                    ),
                child: const Text(
                  "Add todo",
                  style: TextStyle(
                    color: ColorPallete.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
