import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:todo/authentication/UserDmAuth.dart';
import 'package:todo/widgets&model/provider/provider.dart';

import '../widgets&model/tasks_data_class.dart';

class NewTask extends StatefulWidget {
  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedTime = DateTime.now();
  late ToDoProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.addnewtask,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: taskController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.enteryourtask,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 5),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.taskdescriptions,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 5),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(AppLocalizations.of(context)!.selecteddate,
                      style: TextStyle(fontSize: 20))),
              Container(
                padding: EdgeInsets.all(10),
                child: TimePickerSpinnerPopUp(
                  mode: CupertinoDatePickerMode.date,
                  initTime: DateTime.now(),
                  minTime: DateTime.now().subtract(const Duration(days: 365)),
                  maxTime: DateTime.now().add(const Duration(days: 365)),
                  barrierColor: Colors.black12,
                  //Barrier Color when pop up show
                  minuteInterval: 1,
                  padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
                  cancelText: 'Cancel',
                  confirmText: 'OK',
                  pressType: PressType.singlePress,
                  timeFormat: 'dd/MM/yyyy',
                  // Customize your time widget
                  // timeWidgetBuilder: (dateTime) {},
                  onChange: (dateTime) {
                    // Implement your logic with select dateTime
                  },
                ),
              ),
              Text(AppLocalizations.of(context)!.selectedtime,
                  style: TextStyle(fontSize: 20)),
              Container(
                padding: EdgeInsets.all(10),
                child: TimePickerSpinnerPopUp(
                  mode: CupertinoDatePickerMode.time,
                  initTime: DateTime.now(),
                  onChange: (dateTime) {
                    selectedTime = dateTime;
                    // Implement your logic with select dateTime
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    onAddPress();
                    Navigator.pop(context);
                    provider.refreshTodoFromFireStore();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddPress() {
    CollectionReference todo = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TaskData.collectionName);
    DocumentReference doc = todo.doc();
    doc.set({
      "id": doc.id,
      "task": taskController.text,
      "description": descriptionController.text,
      "isDone": false,
      "time": selectedTime.microsecondsSinceEpoch,
    }).timeout(
      Duration(seconds: 1),
      onTimeout: () {
        Navigator.pop(context);
        provider.refreshTodoFromFireStore();
      },
    );
  }
}
