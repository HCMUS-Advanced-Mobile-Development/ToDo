import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:todo/constants/hive_constants.dart';
import 'package:todo/constants/notification_constant.dart';
import 'package:todo/constants/search_bar_constant.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/stores/todo_store/todo_store.dart';
import 'package:todo/widgets/empty_animation.dart';
import 'package:todo/widgets/search_bar.dart';
import 'package:todo/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final todoStore = GetIt.I.get<ToDoStore>();
  late final ObservableList<TodoModel> todos = todoStore.currentList;

  final toDoBox = Hive.box<TodoModel>(HiveConstants.boxName);

  final flutterLocalNotificationsPlugin =
      GetIt.I.get<FlutterLocalNotificationsPlugin>();

  TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: SearchBarConstant.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (context) {
                return todoStore.todos.isEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const EmptyAnimation(),
                      )
                    : AnimatedList(
                        itemBuilder: (context, index, animation) {
                          if (todos[index].isDone || todos[index].isVisible! == false) {
                            return const SizedBox.shrink();
                          }
                          return SizeTransition(
                            sizeFactor: animation,
                            child: TodoItem(
                              todoModel: todos[index],
                              onDoneButtonClick: _handleDoneClick,
                            ),
                          );
                        },
                        initialItemCount: todos.length,
                      );
              }),
            ),
          ),
          SearchBar(
            onSubmitted: _handleQuery,
            onQueryChanged: _handleQuery,
          ),
        ],
      ),
    );
  }

  _handleQuery(String query) {
    for (var element in todos) {
      element.isVisible = element.todo.toLowerCase().contains(query.toLowerCase());
    }

    todos.replaceRange(0, todos.length, todos);
  }

  _handleDoneClick(BuildContext context, TodoModel todoModel) async {
    var index =
        todos.indexWhere((element) => element.id.compareTo(todoModel.id) == 0);
    todos.removeAt(index);

    AnimatedList.of(context).removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: TodoItem(todoModel: todoModel),
      ),
    );

    await toDoBox.delete(todoModel.key);
  }
}
