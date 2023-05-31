import 'package:flutter/material.dart';

import '../../shared/components/TextFormField/custom_form_field.dart';

class ShowModalBottomSheet extends StatelessWidget {
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Add Task",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
          CustomFormField(
            suffix_Icon: null,
            textLabel: "Enter Your Task Title",
            inputField: title,
            functionValidate: (text) {
              if (text?.isEmpty == true || text?.trim().isEmpty == true) {
                return "Please Enter title";
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
            textLabel: "Enter Your Task Description",
            inputField: title,
            functionValidate: (text) {
              if (text?.isEmpty == true || text?.trim().isEmpty == true) {
                return "Please Enter description";
              }
            },
            BorderField: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.blue, style: BorderStyle.solid, width: 1)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          Text("Select Date", style: Theme.of(context).textTheme.bodyMedium),
          GestureDetector(
            onTap: () {
          showDatePickerSelectedDate(context);
            },
            child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text("11/11/2011",textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey)),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Add Task",
              style: Theme.of(context).textTheme.bodySmall,
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
    }
  }
}
