import 'package:flutter/material.dart';
import 'package:todo_app/layout%20screen/home%20screen.dart';
import 'package:todo_app/login/login%20screen.dart';
import 'package:todo_app/splash%20screen/splash%20screen.dart';
import 'package:todo_app/storge%20local/cash_Helper.dart';

class ProviderApplication extends ChangeNotifier{
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = "en";
  bool loggedIn = true;
  ProviderApplication(){
    currentTheme = CashHelper.getThemingFromSharedPreferences() == "dark"?ThemeMode.dark:ThemeMode.light;
    currentLanguage = CashHelper.getLanguageSharedPreferences();
    loggedIn = CashHelper.getLoggedInInSharedPreferences() == null?true:false;
    notifyListeners();
  }
  String getNameScreen(){
    return loggedIn == true?LoginScreen.routeName:HomeScreen.routeName;
  }
  void changeTheme(ThemeMode mode){
    currentTheme = mode;
    String theme = mode == ThemeMode.light?"light":"dark";
    CashHelper.savedThemingInSharedPreferences(theme);
    notifyListeners();
  }
  void changeLoginInUser(bool loginUser)async {
    this.loggedIn = loginUser;
    await CashHelper.savedLoggedInInSharedPreferences(loginUser);
    notifyListeners();
  }
  void changeLanguage(String language){
    currentLanguage = language;
    CashHelper.savedLanguageInSharedPreferences(language);
    notifyListeners();
  }
  bool isDarkEnabled(){
    return currentTheme == ThemeMode.dark ? true : false;
  }
  Color getColorApplication(){
     return currentTheme == ThemeMode.dark ? Colors.black : Color(0xffDFECDB);
  }
  String getSplashScree(){
    return currentTheme == ThemeMode.dark ? "assets/images/splash screen/dark/splash_dark.png" : "assets/images/splash screen/light/splash_light.png";
  }
}