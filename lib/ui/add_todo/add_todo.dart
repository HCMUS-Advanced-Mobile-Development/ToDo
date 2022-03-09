import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/stores/todo_store/todo_store.dart';
import 'package:todo/utils/DateTimeUtils.dart';
import 'package:todo/widgets/text_input.dart';
import 'package:validators/validators.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final todoStore = GetIt.instance.get<ToDoStore>();

  final TodoModel todoModel = TodoModel(
    id: DateTime.now().millisecond.toString(),
    todo: "",
    deadline: DateTime.now().add(const Duration(days: 1)),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.addTodo),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _handleSaveTodo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: TextInput(
                    hintText: S.current.whatIsYourPlan,
                    minLines: 7,
                    maxLines: 15,
                    validator: (value) {
                      if (isNull(value)) {
                        return S.current.thisFieldMustNotEmpty;
                      }

                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        todoModel.todo = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.event,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Theme.of(context).cardColor,
                        ),
                        onPressed: _handleSetDeadline,
                        label: Text(
                          DateTimeUtils.formatDeadline(todoModel.deadline),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSaveTodo() {
    if (_formKey.currentState!.validate()) {
      todoStore.todos.add(todoModel);
      Navigator.pop(context);
    }
  }

  void _handleSetDeadline() {
    DatePicker.showDateTimePicker(context, currentTime: todoModel.deadline,
        onConfirm: (date) {
      setState(() {
        todoModel.deadline = date;
      });
    });
  }
}
