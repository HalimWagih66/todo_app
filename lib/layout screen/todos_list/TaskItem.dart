import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/shared/components/dialog/dialog%20utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/models/task.dart';
import '../../provider/provider_application.dart';

class TaskItem extends StatelessWidget {
  Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context);
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: appProvider.isDarkEnabled() == true ? Color(0xff141922):Colors.white,
      ),
      margin: EdgeInsets.only(top: 20,right: 15,left: 15),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          extentRatio: .25,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                onPressed: (buildContext) {
                  deleteTask(context);
                },
                label: AppLocalizations.of(context)!.delete,
                backgroundColor: Colors.red,
                icon: Icons.delete),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor),
                  width: 5,
                  height: height * .12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title ??"",style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(
                      height: 20,
                    ),
                    Text(task.desc ?? "",style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 21),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor),
                child: Image(
                  image: AssetImage(
                      "assets/images/Layout screen/todoList tap/Icon-check.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask(BuildContext context) {
    DialogUtils.showMessage(
        context: context,
        title: "Warning",
        message: "Are you sure to delete the task?",
        dialogType: DialogType.warning,
        posActionName: "Yes",
        posAction: () {
          var authProvider = Provider.of<AuthProvider>(context);
          MyDataBase.deleteTask(authProvider.currentUser?.id ?? "", task.id ?? "");
        },
      nigActionName: "No"
    );
  }
}
