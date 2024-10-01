import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo.provider.dart';
import 'package:todo/theme/colors.dart';

class TodoItem extends ConsumerWidget {
  final int index;
  final List<Todo> todos;

  const TodoItem({
    super.key,
    required this.index,
    required this.todos,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      style: ListTileStyle.list,
      tileColor:
          index.isEven ? ColorPallete.blueLight : ColorPallete.greenLight,
      // ? const Color.fromARGB(255, 208, 234, 250)
      // : const Color.fromARGB(255, 230, 250, 231),
      title: Text(
        todos[index].content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        DateFormat.yMEd().format(todos[index].date),
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: ColorPallete.textGray,
      ),
      trailing: IconButton(
        onPressed: () {
          ref.watch(todoProvider.notifier).completedTodo(todos[index].todoId);
        },
        icon: todos[index].completed
            ? const Icon(Icons.check_box)
            : const Icon(Icons.check_box_outline_blank),
      ),
    );
  }
}
