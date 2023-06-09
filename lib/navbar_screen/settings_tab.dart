// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/widgets&model/provider/provider.dart';
import '../theme/app_color.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    ToDoProvider provider = Provider.of(context);
    String? language = provider.currentLocale;
    ThemeMode? mod = provider.currentTheme;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.16, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.settings, size: 50, color: AppColor.secColor),
            Text(
                textAlign: TextAlign.start,
                AppLocalizations.of(context)!.language,
                style: TextStyle(
                    color: AppColor.primColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Container(
              height: 40,
              padding:
              EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: AppColor.secColor)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    elevation: 0,
                    alignment: Alignment.center,
                    items: [
                      DropdownMenuItem(
                        value: "en",
                        child: Text("English",
                            style: TextStyle(
                                color: AppColor.primColor,
                                fontWeight: FontWeight.bold)),
                        onTap: () async {
                          provider.currentLocale = "en";
                          provider.notifyListeners();
                        },
                      ),
                      DropdownMenuItem(
                        value: "ar",
                        child: Text("العربية",
                            style: TextStyle(
                                color: AppColor.primColor,
                                fontWeight: FontWeight.bold)),
                        onTap: () async {
                          provider.currentLocale = "ar";
                          provider.notifyListeners();
                        },
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        language = value;
                      });
                    },
                    value: language,
                  )),
            ),
            Text(
                textAlign: TextAlign.start,
                AppLocalizations.of(context)!.mod,
                style: TextStyle(
                    color: AppColor.primColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Container(
              height: 40,
              padding:
              EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: AppColor.secColor)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    elevation: 0,
                    alignment: Alignment.center,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.light,
                    child: Text(AppLocalizations.of(context)!.light,
                        style: TextStyle(
                            color: AppColor.primColor,
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      provider.currentTheme = ThemeMode.light;
                      provider.notifyListeners();
                    },
                  ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(AppLocalizations.of(context)!.dark,
                            style: TextStyle(
                                color: AppColor.primColor,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          provider.currentTheme = ThemeMode.dark;
                          provider.notifyListeners();
                        },
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        mod = value;
                      });
                    },
                    value: mod,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
