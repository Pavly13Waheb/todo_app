import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets&model/provider/provider.dart';
import 'package:todo/widgets&model/todo_widget.dart';

class ToDo extends StatefulWidget {
  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    ToDoProvider provider = Provider.of(context);
    provider.refreshTodoFromFireStore();

    return Container(
      child: ListView.builder(
          itemCount: provider.taskData.length,
          itemBuilder: (_, index) {
            return ToDoWidget(todos: provider.taskData[index]);
          }),
    );
  }
}
