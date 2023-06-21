import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout%20screen/todos_list/show%20bottom%20sheet%20edit%20task.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/shared/components/dialog/dialog%20utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/models/task.dart';
import '../../format/format_date.dart';
import '../../provider/application_provider.dart';
import '../../shared/style/color application/colors_application.dart';

class TaskItem extends StatelessWidget {
  Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onLongPress: () {
        showModeBottomSheetEditTask(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color:  ColorApp.isDarkEnabled(context) == true
              ? Color(0xff141922)
              : Colors.white,
        ),
        margin: EdgeInsets.only(top: 20, right: 15, left: 15),
        child: Slidable(
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            extentRatio: .25,
            children: [
              SlidableAction(
                  borderRadius: appProvider.currentLanguage == "ar"
                      ? BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))
                      : BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
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
                        color:
                            task.isDone == true ? Colors.green : Colors.blue),
                    width: 5,
                    height: height * .12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: task.isDone == true
                                      ? Colors.green
                                      : Colors.blue)),
                      SizedBox(
                        height: 12,
                      ),
                      Text(task.desc ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: task.isDone == true
                                      ? Colors.green
                                      :ColorApp.isDarkEnabled(context) == true ? Colors.white:Colors.black)),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          textBaseline:TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Container(
                              child: Icon(
                                Icons.timer,
                                color: Colors.grey,
                                size: 16,
                              ),
                              alignment: Alignment.bottomRight,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              MyDateUtils.formTaskDateTime(task.time),
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(width: 4,),
                            appProvider.currentLanguage == "en"?Text(
                              MyDateUtils.formTaskAMPM(task.time) == "PM"?AppLocalizations.of(context)!.pm:AppLocalizations.of(context)!.am,
                              style: TextStyle(color: Colors.grey, fontSize: 10),
                              //textDirection: TextDirection.rtl,
                            ):Text(
                              MyDateUtils.formTaskAMPM(task.time) == "PM"?AppLocalizations.of(context)!.pm:AppLocalizations.of(context)!.am,
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                              //textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                task.isDone == false?Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 21),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                  child: InkWell(
                    onTap: () {
                      isDoneTask(context);
                    },
                    child: Image(
                      image: AssetImage(
                          "assets/images/Layout screen/todoList tap/Icon-check.png"),
                    ),
                  ),
                ):Text(AppLocalizations.of(context)?.is_done??"",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.green),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModeBottomSheetEditTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ShowModalBottomSheetEditTask(task: task);
        },
        backgroundColor: Colors.transparent,
      isScrollControlled: true
    );
  }

  Future<void> isDoneTask(BuildContext context) async {
    task.isDone = true;
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    await MyDataBase.isDoneTask(authProvider.currentUser?.id ?? "", task);
  }

  void deleteTask(BuildContext context) {
    DialogUtils.showMessage(
      context: context,
      title: AppLocalizations.of(context)!.warning,
      message: AppLocalizations.of(context)!.are_you_sure_to_delete_the_task,
      dialogType: DialogType.warning,
      posActionName: AppLocalizations.of(context)!.no,
      nigActionName: AppLocalizations.of(context)!.yes,
      nigAction: () async {
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        await MyDataBase.deleteTask(
            authProvider.currentUser?.id ?? "", task.id ?? "");
        Fluttertoast.showToast(msg: AppLocalizations.of(context)!.the_task_has_been_deleted_successfully,
        backgroundColor: Colors.green,
          textColor: Colors.black,
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14
        );
      },
    );
  }
}
