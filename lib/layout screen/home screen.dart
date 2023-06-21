import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout%20screen/settings%20tap/settings_tap.dart';
import 'package:todo_app/layout%20screen/todos_list/show%20bottom%20sheet%20add%20task.dart';
import 'package:todo_app/layout%20screen/todos_list/todosList_tap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/application_provider.dart';
import '../shared/style/color application/colors_application.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "HomeScreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isScrollBottomSheet = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedItem = 0;
  List<Widget> taps = [
    TodosList_Tap(),
    SettingsTap(),
  ];

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    
    List<String> titleTaps = [
      AppLocalizations.of(context)!.to_do_list,
      AppLocalizations.of(context)!.settings,
    ];
    return Scaffold(
      backgroundColor: ColorApp.getColorApplication(context),
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text(titleTaps[selectedItem]),
      ),
      body: taps[selectedItem],
      floatingActionButton: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: ColorApp.isDarkEnabled(context) == true ? Colors.black : Color(
              0xffDFECDB),
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
            BottomNavigationBarItem(icon: Icon(Icons.menu),
                label: "",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings),
                label: "",
            ),
          ],
        ),
      ),
    );
  }

  void showModalBottomSheetAddTask() {
    print(MediaQuery.of(context).platformBrightness);
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ShowModalBottomSheetAddTask();
        },
        elevation: 5,
        backgroundColor: Colors.transparent,
    );
  }
}