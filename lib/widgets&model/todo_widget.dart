import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets&model/edit_widget.dart';
import 'package:todo/widgets&model/provider/provider.dart';
import 'tasks_data_class.dart';
import '../theme/app_color.dart';

class ToDoWidget extends StatefulWidget {
  TaskData todos;

  ToDoWidget({required this.todos});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
    ToDoProvider provider = Provider.of(context);

    return SwipeActionCell(
      key: ObjectKey(ToDoWidget),

      /// this key is necessary
      leadingActions: <SwipeAction>[
        SwipeAction(
            widthSpace: 70,
            icon: Icon(Icons.delete),
            onTap: (CompletionHandler handler) async {
              var todoCollection =
                  FirebaseFirestore.instance.collection("todo");
              var doc = todoCollection.doc(widget.todos.id);
              doc.delete().timeout(Duration(seconds: 1));
              provider.refreshTodoFromFireStore();
            },
            color: Colors.red),
        SwipeAction(
          color: Colors.yellow,
          widthSpace: 70,
          icon: Icon(Icons.edit),
          onTap: (CompletionHandler handler) async {
            handler(false);
            return showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: EditWidget());
              },
            );
          },
        )
      ],
      child: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.background),
        height: MediaQuery.of(context).size.height * 0.13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 10,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.primColor,
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.todos.task,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.todos.description,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primColor),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.watch_later_outlined),
                          Text(
                            widget.todos.selectedtime.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: AppColor.primColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(Icons.check, color: Colors.white, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
