import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/constants/search_bar_constant.dart';
import 'package:todo/stores/todo_store/todo_store.dart';
import 'package:todo/widgets/search_bar.dart';
import 'package:todo/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final todoStore = GetIt.instance.get<ToDoStore>();

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
              child: Observer(
                builder: (context) {
                  final todos = todoStore.currentList;

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return TodoItem(todoModel: todos[index]);
                    },
                    itemCount: todos.length,
                  );
                }
              ),
            ),
          ),
          const SearchBar(),
        ],
      ),
    );
  }
}
