import 'package:flutter/material.dart';
import 'package:todo_app/layout%20screen/settings%20tap/settings_tap.dart';
import 'package:todo_app/layout%20screen/todos_list/show%20bottom%20sheet.dart';
import 'package:todo_app/layout%20screen/todos_list/todosList_tap.dart';

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
  List<String> titleTaps = [
    "TO Do List",
    "Settings",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFECDB),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(titleTaps[selectedItem]),
      ),
      body: taps[selectedItem],
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheetAddTask();
          },
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedItem,
          onTap: (index) {
            selectedItem = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
    );
  }

  void showModalBottomSheetAddTask() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ShowModalBottomSheet();
        },
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(13), topLeft: Radius.circular(13))));
  }
}
