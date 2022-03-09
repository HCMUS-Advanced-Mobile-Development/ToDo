import 'package:mobx/mobx.dart';
import 'package:todo/models/todo_model.dart';

part 'todo_store.g.dart';

class ToDoStore = _ToDoStore with _$ToDoStore;

abstract class _ToDoStore with Store {
  @observable
  ObservableList<TodoModel> todos = ObservableList.of([]);
}
