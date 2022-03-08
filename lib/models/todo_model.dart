class TodoModel {
  String todo = "";
  DateTime deadline = DateTime.now().add(const Duration(days: 1));
  bool? isDone = false;

  TodoModel({required this.todo, required this.deadline, this.isDone});
}