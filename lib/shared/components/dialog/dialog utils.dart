import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider_application.dart';

class DialogUtils {
  static dialogLoading(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context,listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            backgroundColor:
            appProvider.isDarkEnabled()?Color(0xff141922):Colors.white,
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 14),
                Text(AppLocalizations.of(context)!.loading,style: TextStyle(color: appProvider.isDarkEnabled()?Colors.grey:Colors.white,)),
              ],
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static showMessage({
    required BuildContext context,
    required String message,
    required DialogType dialogType,
    String? title,
    String? posActionName,
    Function? posAction,
    String? nigActionName,
    Function? nigAction,
  }) {
    var appProvider = Provider.of<ProviderApplication>(context, listen: false);
    AwesomeDialog(
      dialogBackgroundColor:
          appProvider.isDarkEnabled() ? Color(0xff141922) : Colors.white,
      context: context,
      dialogType: dialogType,
      title: title,
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      animType: AnimType.rightSlide,
      desc: message,
      btnCancelOnPress: nigActionName != null
          ? () {
              nigAction?.call();
            }
          : null,
      btnOkOnPress: posActionName != null
          ? () {
              posAction?.call();
            }
          : null,
      btnOkText: posActionName,
      btnCancelText: nigActionName,
    )..show();
  }
}
