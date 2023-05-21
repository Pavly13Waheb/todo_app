import 'package:flutter/material.dart';
import 'package:todo/navbar_screen/floating_add_task.dart';
import 'package:todo/navbar_screen/test.dart';
import 'package:todo/navbar_screen/todo_list.dart';
import 'package:todo/theme/app_color.dart';
import 'navbar_screen/settings_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  static String routeName = "homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navbarpage = 0;
  List navBarList = [ToDoList(), Test(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text(
          AppLocalizations.of(context)!.todolist,
        ),
      ),
      body: Container(
        child: navBarList[navbarpage],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.bgColor, width: 8),
              color: AppColor.primColor,
              shape: BoxShape.circle),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => NewTask(),
              );
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.white, width: 3)),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          height: kBottomNavigationBarHeight * 1.4,
          child: BottomNavigationBar(
              iconSize: 30,
              currentIndex: navbarpage,
              onTap: (int index) {
                navbarpage = index;
                setState(() {});
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                    Icons.format_list_bulleted,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Test",
                  icon: Icon(
                    Icons.face_2_sharp,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                    Icons.settings,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
