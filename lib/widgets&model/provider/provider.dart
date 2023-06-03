import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tasks_data_class.dart';

class ToDoProvider extends ChangeNotifier {
  String currentLocale = "en";
  ThemeMode currentTheme = ThemeMode.light;

  List<TaskData> taskData = [];

  changeLanguage(String lang) async {
    currentLocale = lang;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", lang);
  }

  changeTheme(ThemeMode theme) async {
    currentTheme = theme;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme == ThemeMode.light ? "light" : "dark");
  }

  refreshTodoFromFireStore() {
    var todoCollection = FirebaseFirestore.instance.collection("todo");
    todoCollection.get().then(
      (querySnapShot) {
        taskData = querySnapShot.docs.map((documentSnapShot) {
          var json = documentSnapShot.data();
          return TaskData(
              id: json["id"],
              task: json["task"],
              description: json["description"],
              isDone: json["isDone"],
              selectedtime: DateTime.fromMicrosecondsSinceEpoch(json["time"]));
        }).toList();
        notifyListeners();
      },
    );
  }
}
