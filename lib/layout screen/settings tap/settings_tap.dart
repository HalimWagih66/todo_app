import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/login/login%20screen.dart';
import '../../provider/application_provider.dart';
import '../../shared/style/color application/colors_application.dart';
import 'bottom sheet language.dart';

class SettingsTap extends StatefulWidget {
  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    String selectedValue = "Light";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(
            flex: 1,
          ),
          Text(AppLocalizations.of(context)!.language,style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              showBottomSheetChoiceLanguage();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                    width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appProvider.currentLanguage == "en" ? "English" : "عربي"),
                  Icon(Icons.arrow_drop_down_circle_outlined)
                ],
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
                onPressed: () {
                  singOut();
                },
                child: Text(AppLocalizations.of(context)?.sign_out ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorApp.getColorApplication(context))),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }



  void showBottomSheetChoiceLanguage() async {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ShowBottomSheetLanguage();
        },
        elevation: 5,
        backgroundColor: Colors.transparent);
  }

  void singOut() {
    var appProvider = Provider.of<ApplicationProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    appProvider.changeLoginInUser(true);
  }
}
