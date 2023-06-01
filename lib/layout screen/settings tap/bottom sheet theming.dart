import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowBottomSheetTheming extends StatefulWidget {

  @override
  State<ShowBottomSheetTheming> createState() => _ShowBottomSheetThemingState();
}

class _ShowBottomSheetThemingState extends State<ShowBottomSheetTheming> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          InkWell(
            onTap: (){

            },
            child: selectedItem(AppLocalizations.of(context)!.light),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){

            },
            child: unSelectedItem(AppLocalizations.of(context)!.dark),
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
