// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ToDoStore on _ToDoStore, Store {
  final _$todosAtom = Atom(name: '_ToDoStore.todos');

  @override
  ObservableList<TodoModel> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<TodoModel> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  @override
  String toString() {
    return '''
todos: ${todos}
    ''';
  }
}
