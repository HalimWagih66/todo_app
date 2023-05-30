import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static dialogLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 14),
                Text("Loading"),
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
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      title: title,
      animType: AnimType.rightSlide,
      desc: message,
      btnCancelOnPress: nigActionName != null? () {
        nigAction?.call();
      }:null,
      btnOkOnPress: posActionName != null ?() {
        posAction?.call();
      }:null,
    )..show();
  }
}
