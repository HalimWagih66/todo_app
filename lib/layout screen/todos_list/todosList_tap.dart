import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/database/models/task.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/provider/application_provider.dart';
import '../../format/format_date.dart';
import '../../shared/style/color application/colors_application.dart';
import 'task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TodosList_Tap extends StatefulWidget {
  @override
  State<TodosList_Tap> createState() => _TodosList_TapState();
}

class _TodosList_TapState extends State<TodosList_Tap> {
  var selectedDate = DateTime.now();
  var focusedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var appProvider = Provider.of<ApplicationProvider>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            color: Colors.blue,
          ),
          child: TableCalendar(
            locale: appProvider.currentLanguage,
            onFormatChanged: (calenderFormat){
              setState(() {
                this.calendarFormat = calenderFormat;
              });
            },
            headerStyle: HeaderStyle(
              formatButtonDecoration: BoxDecoration(
                color: ColorApp.getColorApplication(context),
                borderRadius: BorderRadius.circular(10),
                border: null
              ),
              formatButtonTextStyle: TextStyle(
                color: ColorApp.isDarkEnabled(context) == false?Colors.black: Color(0xffDFECDB)
              ),
              rightChevronIcon: Icon(
                 appProvider.currentLanguage == "en"?Icons.keyboard_arrow_right:Icons.keyboard_arrow_left,
                 color: ColorApp.getColorApplication(context),
              ),
                leftChevronIcon: Icon(
                  appProvider.currentLanguage == "en"?Icons.keyboard_arrow_left:Icons.keyboard_arrow_right,
                  color: ColorApp.getColorApplication(context),
                ),
              formatButtonShowsNext: true,
              titleTextStyle: TextStyle(color: ColorApp.getColorApplication(context))
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: ColorApp.getColorApplication(context),width: 1,style: BorderStyle.solid))),
              weekdayStyle: TextStyle(color: ColorApp.getColorApplication(context)),
              weekendStyle:  TextStyle(color: ColorApp.getColorApplication(context)),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(
                color: ColorApp.getColorApplication(context)
              ),
              weekendTextStyle: TextStyle(color: ColorApp.getColorApplication(context)),
                selectedDecoration:
                    BoxDecoration(color: ColorApp.getColorApplication(context), shape: BoxShape.circle),selectedTextStyle: TextStyle(color: ColorApp.isDarkEnabled(context) == false?Colors.black: Color(0xffDFECDB))),
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) {
              print("day = ${day.millisecondsSinceEpoch}");
              print("selected  = {selectedDate.millisecondsSinceEpoch}");
              return isSameDay(selectedDate, day);
            },
            onDaySelected: (selectedDate, day) {
              setState(() {
                this.selectedDate = selectedDate;
                this.focusedDay = day;
              });
            },
            daysOfWeekHeight: 40,
            calendarFormat: calendarFormat,
            availableCalendarFormats: {
              CalendarFormat.week:AppLocalizations.of(context)!.week,
              CalendarFormat.month:AppLocalizations.of(context)!.month,
            }
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
              stream: MyDataBase.readTasksRealTime(
                  authProvider.currentUser?.id ?? "",
                  MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch),
              builder: (buildContext, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.toString()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var listTasks =
                    snapshot.data?.docs.map((e) => e.data()).toList();
                if (listTasks?.isEmpty == true) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 100,
                        color: Color(0xA67A7A7A),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(AppLocalizations.of(context)!.you_don_t_have_any_tasks_yet,
                          style: TextStyle(color: Color(0xA67A7A7A))),
                    ],
                  ));
                }
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskItem(listTasks![index]);
                    },
                    itemCount: listTasks?.length ?? 0);
              }),
        ),
      ],
    );
  }
}
