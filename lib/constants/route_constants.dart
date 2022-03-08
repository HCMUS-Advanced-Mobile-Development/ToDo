import 'package:flutter/material.dart';
import 'package:todo/ui/add_todo/add_todo.dart';

class RouteConstants {
  static const addTodo = "addTodo";

  static final routesMap = <String, WidgetBuilder>{
    addTodo: (context) => const AddTodo(),
  };
}