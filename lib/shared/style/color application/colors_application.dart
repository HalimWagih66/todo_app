import 'package:flutter/material.dart';

class ColorApp{
  static bool isDarkEnabled(BuildContext context){
    return MediaQuery.of(context).platformBrightness == Brightness.dark ? true : false;
  }
  static Color getColorApplication(BuildContext context){
    return MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black : Color(0xffDFECDB);
  }
}
