import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/models/task.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../format/format_date.dart';
import '../../shared/components/TextFormField/custom_form_field.dart';

class ShowModalBottomSheet extends StatefulWidget {
  @override
  State<ShowModalBottomSheet> createState() => _ShowModalBottomSheetState();
}

class _ShowModalBottomSheetState extends State<ShowModalBottomSheet> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              textLabel:AppLocalizations.of(context)!.enter_your_task_title,
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
              textLabel: AppLocalizations.of(context)!.enter_your_task_description,
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
              height: MediaQuery.of(context).size.height * .04,
            ),
            Text(AppLocalizations.of(context)!.select_date, style: Theme.of(context).textTheme.bodyMedium),
            GestureDetector(
              onTap: () {
            showDatePickerSelectedDate(context);
              },
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('${FormDate.formTaskDateDate(selectedDate)}',textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addTask(context);
              },
              child: Text(
                AppLocalizations.of(context)!.add_task,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 13),
                backgroundColor: Theme.of(context).primaryColor,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  void showDatePickerSelectedDate(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (date != null) {
      selectedDate = date;
      setState(() {

      });
    }
  }

  void addTask(BuildContext context){
    if(formKey.currentState?.validate() == false)return;
    Task task = Task(
        title: titleController.text,
        desc: descController.text,
        dateTime: selectedDate
    );
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    MyDataBase.addTask(authProvider.currentUser?.id??"", task);
  }
}
