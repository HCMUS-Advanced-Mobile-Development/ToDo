class TodoModel {
  String id = "";
  String todo = "";
  DateTime deadline = DateTime.now().add(const Duration(days: 1));
  bool isDone;

  TodoModel({required this.id, required this.todo, required this.deadline, this.isDone = false});
}