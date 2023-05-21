import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          InkWell(
            child: Icon(
              Icons.ac_unit_sharp,
              size: 100,
            ),
            onTap: () {
              //adduser();
            },
          ),
        ],
      ),
    );
  }
}
