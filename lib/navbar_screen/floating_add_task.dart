import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NewTask extends StatefulWidget {
  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          AppLocalizations.of(context)!.addnewtask
,          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: TextFormField(
            decoration: InputDecoration(

              hintText: AppLocalizations.of(context)!.enteryourtask,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 5),
              ),
            ),


          ),
        ),
        Text(AppLocalizations.of(context)!.selectedtime, style: TextStyle(fontSize: 20)),
        Text(
          "12:00 AM",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        )
      ]),
    );
  }
}
