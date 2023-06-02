import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets&model/provider/provider.dart';
import 'package:todo/widgets&model/todo_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class ToDo extends StatefulWidget {
  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    ToDoProvider provider = Provider.of(context);
    provider.refreshTodoFromFireStore();

    return Scaffold(
      body: Column(
        children: [
          CalendarTimeline(
            showYears: true,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022, 1, 1),
            lastDate: DateTime(2023, 12, 31),
            onDateSelected: (date) {
              print(date);
            },
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.red,
            dotsColor: Color(0xFF333A47),
            //selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.taskData.length,
              itemBuilder: (_, index) {
                return ToDoWidget(todos: provider.taskData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
