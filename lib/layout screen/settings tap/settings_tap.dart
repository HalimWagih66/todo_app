import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bottom sheet language.dart';
import 'bottom sheet theming.dart';
class SettingsTap extends StatefulWidget {
  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    String selectedValue = "Light";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.mode),
          SizedBox(height: 18,),
          GestureDetector(
            onTap: (){
              showBottomSheetChoiceTheming();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor,style: BorderStyle.solid,width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.light),
                  Icon(Icons.arrow_drop_down_circle_outlined)
                ],
              ),
            ),
          ),
          SizedBox(height: 18,),
          Text(AppLocalizations.of(context)!.language),
          SizedBox(height: 18,),
          InkWell(
            onTap: (){
              showBottomSheetChoiceLanguage();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor,style: BorderStyle.solid,width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("English"),
                  Icon(Icons.arrow_drop_down_circle_outlined)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void showBottomSheetChoiceTheming(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return ShowBottomSheetTheming();
    },
        elevation: 5,
        backgroundColor: Colors.transparent
    );
  }
  void showBottomSheetChoiceLanguage()async{
    showModalBottomSheet(context: context, builder: (buildContext){
      return ShowBottomSheetLanguage();
    },
        elevation: 5,
        backgroundColor: Colors.transparent);
  }
}
