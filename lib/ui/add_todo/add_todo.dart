import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/widgets/text_input.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TodoModel todoModel = TodoModel(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: TextInput(
                hintText: S.current.whatIsYourPlan,
                minLines: 7,
                maxLines: 15,
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
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Theme.of(context).cardColor,
                    ),
                    onPressed: _handleSetDeadline,
                    label: Text(
                      DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).add_jm().format(todoModel.deadline),
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSaveTodo() {
    Navigator.pop(context);
  }

  void _handleSetDeadline() {
    DatePicker.showDateTimePicker(
      context,
      currentTime: todoModel.deadline,
      onConfirm: (date) {
        setState(() {
          todoModel.deadline = date;
        });
      }
    );
  }
}
