import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/models/task.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../format/format_date.dart';
import '../../provider/provider_application.dart';
import '../../shared/components/TextFormField/custom_form_field.dart';

class ShowModalBottomSheetAddTask extends StatefulWidget {

  @override
  State<ShowModalBottomSheetAddTask> createState() =>
      _ShowModalBottomSheetAddTaskState();
}

class _ShowModalBottomSheetAddTaskState
    extends State<ShowModalBottomSheetAddTask> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context);
    return Container(
      decoration: BoxDecoration(
          color: appProvider.isDarkEnabled() ? Color(0xff141922) : Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.add_task,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            CustomFormField(
              suffix_Icon: null,
              textLabel: AppLocalizations.of(context)!.enter_your_task_title,
              inputField: titleController,
              functionValidate: (text) {
                if (text?.isEmpty == true || text?.trim().isEmpty == true) {
                  return AppLocalizations.of(context)!.please_enter_title;
                }
              },
              BorderField: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 1)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            CustomFormField(
              prefix_Icon: null,
              suffix_Icon: null,
              minLines: 1,
              maxLines: 2,
              textLabel:
                  AppLocalizations.of(context)!.enter_your_task_description,
              inputField: descController,
              functionValidate: (text) {
                if (text?.isEmpty == true || text?.trim().isEmpty == true) {
                  return AppLocalizations.of(context)!.please_Enter_description;
                }
              },
              BorderField: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 1)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Text(AppLocalizations.of(context)!.select_date,
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 3,),
            GestureDetector(
              onTap: () {
                showDatePickerSelectedDate(context);
              },
              child: Column(
                children: [
                  Container(
                    child: Text('${FormDate.formTaskDateDate(selectedDate)}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),textDirection: TextDirection.rtl),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text('${FormDate.formTaskDateTime(selectedDate)}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),textDirection: TextDirection.rtl),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addTask(context);
              },
              child: Text(
                AppLocalizations.of(context)!.add_task,
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

  DateTime selectedDate = DateTime.now();

  void showDatePickerSelectedDate(BuildContext context) async {
    var appProvider = Provider.of<ProviderApplication>(context,listen: false);
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      primaryColor: Colors.cyan,
      backgroundColor: appProvider.isDarkEnabled()==true?Colors.grey[900]:Colors.white,
      calendarTextColor: appProvider.isDarkEnabled()==true?Colors.white:Colors.grey[900],
      tabTextColor: appProvider.isDarkEnabled()==true?Colors.white:Colors.grey[900],
      unselectedTabBackgroundColor: Colors.grey[700],
      buttonTextColor: appProvider.isDarkEnabled() == true ?Colors.white:Colors.grey[900],
      timeSpinnerTextStyle:
      TextStyle(color: appProvider.isDarkEnabled()==true?Colors.white70:Colors.grey[400], fontSize: 18),
      timeSpinnerHighlightedTextStyle:
    TextStyle(color: appProvider.isDarkEnabled() == true ?Colors.white:Colors.grey[700], fontSize: 24),
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: selectedDate,
      startFirstDate: DateTime.now(),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      borderRadius: const Radius.circular(16),
    );
    if (dateTime != null) {
      selectedDate = dateTime;
      setState(() {});
    }
  }

  void addTask(BuildContext context) {
    if (formKey.currentState?.validate() == false) return;
    Task task = Task(
        title: titleController.text,
        desc: descController.text,
        dateTime: selectedDate);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    MyDataBase.addTask(authProvider.currentUser?.id ?? "", task);
  }
}
