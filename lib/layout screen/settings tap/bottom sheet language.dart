import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/application_provider.dart';
import '../../shared/style/color application/colors_application.dart';

class ShowBottomSheetLanguage extends StatefulWidget {

  @override
  State<ShowBottomSheetLanguage> createState() => _ShowBottomSheetLanguageState();
}

class _ShowBottomSheetLanguageState extends State<ShowBottomSheetLanguage> {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: ColorApp.isDarkEnabled(context)?Color(0xff141922):Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              appProvider.changeLanguage("en");
              setState(() {

              });
            },
            child: appProvider.currentLanguage == "en"?selectedItem("English"):unSelectedItem("English"),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              appProvider.changeLanguage("ar");
              setState(() {
              });
            },
            child: appProvider.currentLanguage == "ar"?selectedItem("عربي"):unSelectedItem("عربي"),
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
          Text(text,style: Theme.of(context)!.textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor)),
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


