import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/authentication/login.dart';
import 'package:todo/navbar_screen/floating_add_task.dart';
import 'package:todo/navbar_screen/todo_list.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/widgets&model/provider/provider.dart';
import 'authentication/UserDmAuth.dart';
import 'navbar_screen/settings_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  static String routeName = "homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navbarpage = 0;
  List navBarList = [ToDo(), SettingsTab()];
  late ToDoProvider provider;

  getUser() async {
    var user = FirebaseAuth.instance.currentUser;
    print(user?.email);
  }

  void iniState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text(
          AppLocalizations.of(context)!.todolist,
        ),
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text("Welcome back ${UserDm.currentUser!.username}"),
            accountEmail: Text(UserDm.currentEmail!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/pavly.jpg"),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, Login.routeName);
            },
            child: Text("SignOut"),
          ),
          ListTile(
            title: const Text("Home Page"),
            leading: const Icon(Icons.home, color: Colors.red),
            onTap: () {
              print("Home Page");
            },
          ),
          ListTile(
            title: const Text("Help"),
            leading: const Icon(Icons.help, color: Colors.blue),
            onTap: () {
              print("Help");
            },
          ),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Icons.help_center_outlined, color: Colors.grey),
            onTap: () {
              print("About");
            },
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.exit_to_app_sharp, color: Colors.green),
            onTap: () {
              print("Logout");
            },
          ),
        ]),
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
                label: "",
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
