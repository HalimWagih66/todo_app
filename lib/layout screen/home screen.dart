import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout%20screen/settings%20tap/settings_tap.dart';
import 'package:todo_app/layout%20screen/todos_list/show%20bottom%20sheet.dart';
import 'package:todo_app/layout%20screen/todos_list/todosList_tap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/provider_application.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedItem = 0;
  List<Widget> taps = [
    TodosList_Tap(),
    SettingsTap(),
  ];
  @override
  Widget build(BuildContext context) {
     var appProvider = Provider.of<ProviderApplication>(context);
    List<String> titleTaps = [
      AppLocalizations.of(context)!.to_do_list,
      AppLocalizations.of(context)!.settings,
    ];
    return Scaffold(
      backgroundColor: appProvider.getColorApplication(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(titleTaps[selectedItem]),
      ),
      body: taps[selectedItem],
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: appProvider.isDarkEnabled() == true ? Colors.black:Color(0xffDFECDB),
          borderRadius: BorderRadius.circular(50),
        ),
        child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheetAddTask();
            },
            child: Icon(Icons.add)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          currentIndex: selectedItem,
          onTap: (index) {
            selectedItem = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "",backgroundColor: appProvider.isDarkEnabled() == true?Colors.black:Colors.white),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "",backgroundColor: appProvider.isDarkEnabled() == true?Colors.black:Colors.white),
          ],
        ),
      ),
    );
  }

  void showModalBottomSheetAddTask() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ShowModalBottomSheetAddTask();
        },
        elevation: 5,
      backgroundColor: Colors.transparent
    );
  }
}
