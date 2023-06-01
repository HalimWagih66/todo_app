import 'package:flutter/material.dart';

class ProviderApplication extends ChangeNotifier{
  String currentTheme = "light";
  String currentLanguage = "en";
  void changeTheme(String theme){
    currentTheme = theme;
    notifyListeners();
  }
  void changeLanguage(String language){
    currentLanguage = language;
    notifyListeners();
  }
  bool isDarkEnabled(){
    return currentTheme == "dark" ? true : false;
  }
  String getLanguageCode(){
    return currentLanguage;
  }
  Color getColorApplication(){
     return currentTheme == "dark" ? Colors.black : Color(0xffDFECDB);
  }
  String getSplashScree(){
    return currentTheme == "dark" ? "assets/images/splash screen/dark/splash_dark.png" : "assets/images/splash screen/light/splash_light.png";
  }
}