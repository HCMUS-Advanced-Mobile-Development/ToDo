import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/constants/hive_constants.dart';
import 'package:todo/stores/todo_store/todo_store.dart';

import '../models/todo_model.dart';

class StoresLocator {
  static void setUp() {
    final getIt = GetIt.instance;

    getIt.registerSingleton(ToDoStore());

  }
}