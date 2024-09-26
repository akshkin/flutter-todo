class Todo {
  int todoId;
  String content;
  bool completed;
  DateTime date;
  DateTime? completedDate;

  Todo({
    required this.todoId,
    required this.content,
    required this.completed,
    required this.date,
    this.completedDate,
  });
}
