import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../provider/provider_application.dart';

class ShowBottomSheetLanguage extends StatefulWidget {

  @override
  State<ShowBottomSheetLanguage> createState() => _ShowBottomSheetLanguageState();
}

class _ShowBottomSheetLanguageState extends State<ShowBottomSheetLanguage> {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context);
    return Container(
      decoration: BoxDecoration(
          color: appProvider.isDarkEnabled()?Color(0xff141922):Colors.white,
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
            child: appProvider.getLanguageCode() == "en"?selectedItem("English"):unSelectedItem("English"),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              appProvider.changeLanguage("ar");
              setState(() {
              });
            },
            child: appProvider.getLanguageCode() == "ar"?selectedItem("عربي"):unSelectedItem("عربي"),
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

