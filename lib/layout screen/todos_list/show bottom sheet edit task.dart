import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/models/task.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/provider/task_provider.dart';
import '../../format/format_date.dart';
import '../../provider/application_provider.dart';
import '../../shared/components/TextFormField/custom_form_field.dart';
import '../../shared/components/dialog/dialog utils.dart';
import '../../shared/style/color application/colors_application.dart';

class ShowModalBottomSheetEditTask extends StatefulWidget {
  Task task;
  ShowModalBottomSheetEditTask({required this.task}){}

  @override
  State<ShowModalBottomSheetEditTask> createState() => _ShowModalBottomSheetEditTaskState();
}

class _ShowModalBottomSheetEditTaskState extends State<ShowModalBottomSheetEditTask> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: ColorApp.isDarkEnabled(context) ? Color(0xff141922) : Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.05,),
            Text(AppLocalizations.of(context)!.edit_task,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: MediaQuery.of(context).size.height*.03,),
            CustomFormField(
              suffix_Icon: null,
              //inputField: titleController,
              initial_Value: widget.task.title,
              functionOcChanged: (text){
                widget.task.title = text;
              },
              textLabel: AppLocalizations.of(context)!.enter_your_task_title,
              functionValidate: (text) {
                if (text?.isEmpty == true || text?.trim().isEmpty == true) {
                  return AppLocalizations.of(context)!.please_enter_title;
                }
              },
              BorderField: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 1)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.04,),
            CustomFormField(
              prefix_Icon: null,
              suffix_Icon: null,
              minLines: 1,
              maxLines: 2,
              initial_Value: widget.task.desc,
              functionOcChanged: (text){
                widget.task.desc = text;
              },
              textLabel:
                  AppLocalizations.of(context)!.enter_your_task_description,
              functionValidate: (text) {
                if (text?.isEmpty == true || text?.trim().isEmpty == true) {
                  return AppLocalizations.of(context)!.please_Enter_description;
                }
              },
              BorderField: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 1)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.05,),
            Text(AppLocalizations.of(context)!.select_date,
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: MediaQuery.of(context).size.height*.02,),
            GestureDetector(
              onTap: () {
                showDatePickerSelectedDate();
              },
              child: Column(
                children: [
                  Container(
                    child: Text('${MyDateUtils.formTaskDateDate(selectedDate == null?widget.task.date:selectedDate)}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),textDirection: TextDirection.rtl),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${MyDateUtils.formTaskDateTime(selectedDate == null?widget.task.time:selectedDate)}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),textDirection: TextDirection.rtl),
                        SizedBox(width: 5,),
                        appProvider.currentLanguage == "en"?Text(
                          MyDateUtils.formTaskAMPM(selectedDate == null?widget.task.time:selectedDate) == "PM"?AppLocalizations.of(context)!.pm:AppLocalizations.of(context)!.am,
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                          //textDirection: TextDirection.rtl,
                        ):Text(
                          MyDateUtils.formTaskAMPM(selectedDate == null?widget.task.time:selectedDate) == "PM"?AppLocalizations.of(context)!.pm:AppLocalizations.of(context)!.am,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                          //textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                editTask(context);
              },
              child: Text(
                AppLocalizations.of(context)!.edit_task,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13))),
            )
          ],
        ),
      ),
    );
  }

  DateTime? selectedDate;
  void showDatePickerSelectedDate() async {
    selectedDate = widget.task.time;
    int dateTimeStartInitialDate = DateTime.now().millisecondsSinceEpoch;
    int selectedDateTime = widget.task.time?.millisecondsSinceEpoch??DateTime.now().millisecondsSinceEpoch;
    if(selectedDateTime < DateTime.now().millisecondsSinceEpoch){
      selectedDateTime = DateTime.now().millisecondsSinceEpoch;
      selectedDate = DateTime.fromMillisecondsSinceEpoch(selectedDateTime);
    }
    var appProvider = Provider.of<ApplicationProvider>(context,listen: false);
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      primaryColor: Colors.cyan,
      backgroundColor: ColorApp.isDarkEnabled(context)==true?Colors.grey[900]:Colors.white,
      calendarTextColor: ColorApp.isDarkEnabled(context)==true?Colors.white:Colors.grey[900],
      tabTextColor: ColorApp.isDarkEnabled(context)==true?Colors.white:Colors.grey[900],
      unselectedTabBackgroundColor: Colors.grey[700],
      buttonTextColor: ColorApp.isDarkEnabled(context) == true ?Colors.white:Colors.grey[900],
      timeSpinnerTextStyle:
      TextStyle(color: ColorApp.isDarkEnabled(context)==true?Colors.white70:Colors.grey[400], fontSize: 18),
      timeSpinnerHighlightedTextStyle:
    TextStyle(color: ColorApp.isDarkEnabled(context) == true ?Colors.white:Colors.grey[700], fontSize: 24),
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: selectedDate,
      startFirstDate: DateTime.now(),
      startLastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      borderRadius: const Radius.circular(16),
    );
    if (dateTime != null) {
      selectedDate = dateTime;
      widget.task.date = MyDateUtils.dateOnly(dateTime);
      widget.task.time = dateTime;
      setState(() {
      });
    }
  }
  void editTask(BuildContext context)async{
    if (formKey.currentState?.validate() == false) return;
    DialogUtils.dialogLoading(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    await MyDataBase.isDoneTask(authProvider.currentUser?.id??"", widget.task);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context: context, message:AppLocalizations.of(context)?.task_modified_successfully??"",title: AppLocalizations.of(context)?.edit_task, dialogType: DialogType.success,posActionName: AppLocalizations.of(context)?.ok,posAction:(){DialogUtils.hideDialog(context);} );
  }
}
