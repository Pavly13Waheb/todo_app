import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/theme/app_color.dart';

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 10,
      itemBuilder: (context, index) => Container(child: todoWidget(context)),
    );
  }

  todoWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,vertical: MediaQuery.of(context).size.height * 0.01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      height: 130,
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
                    "Play basket ball",
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
                          "10:30 AM",
                          style:
                              TextStyle(fontSize: 12, color: AppColor.secColor),
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
    );
  }
}
