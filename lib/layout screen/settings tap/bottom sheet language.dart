
import 'package:flutter/material.dart';

class ShowBottomSheetLanguage extends StatefulWidget {

  @override
  State<ShowBottomSheetLanguage> createState() => _ShowBottomSheetLanguageState();
}

class _ShowBottomSheetLanguageState extends State<ShowBottomSheetLanguage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          InkWell(
            onTap: (){

            },
            child: selectedItem("English"),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){

            },
            child: unSelectedItem("عربي"),
          ),
        ],
      ),
    );
  }

  Widget selectedItem(String text){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: Theme.of(context)!.textTheme.bodyMedium),
          Icon(Icons.check,color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
  Widget unSelectedItem(String text){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: Theme.of(context)!.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

