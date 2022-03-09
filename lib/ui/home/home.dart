import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/constants/route_constants.dart';
import 'package:todo/constants/search_bar_constant.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/stores/todo_store/todo_store.dart';
import 'package:todo/widgets/search_bar.dart';
import 'package:todo/widgets/todo_item.dart';

import '../../widgets/empty_animation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> _addButtonAnimation;
  late AnimationController _addButtonAnimationController;

  @override
  void initState() {
    _addButtonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    _addButtonAnimation = CurvedAnimation(
      parent: _addButtonAnimationController,
      curve: Curves.easeInOut,
    );

    _addButtonAnimationController.repeat(
      reverse: true,
      period: const Duration(
        milliseconds: 1500,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _addButtonAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoStore = GetIt.instance.get<ToDoStore>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _handleAdd,
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          progress: _addButtonAnimation,
          size: 32.0,
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(
            top: SearchBarConstant.height,
          ),
          child: Center(
            child: Observer(builder: (context) {
              return todoStore.todos.isEmpty
                  ? const EmptyAnimation()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: todoStore.todos
                            .map((element) => TodoItem(todoModel: element))
                            .toList(),
                      ),
                    );
            }),
          ),
        ),
        const SearchBar()
      ]),
    );
  }

  void _handleAdd() {
    Navigator.pushNamed(context, RouteConstants.addTodo);
  }
}
