import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo.dart';

class TodoItem extends StatelessWidget {
  final int index;
  final List<Todo> todos;

  const TodoItem({
    super.key,
    required this.index,
    required this.todos,
  });

  // DateFormat.yMEd().add_jms().format(DateTime.now())

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
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
          color: Color.fromARGB(255, 125, 123, 123),
        ),
        trailing: IconButton(
            onPressed: () {}, icon: const Icon(Icons.check_box_outline_blank)),
      ),
    );
  }
}
