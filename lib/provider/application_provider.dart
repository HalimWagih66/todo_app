import 'package:flutter/material.dart';
import 'package:todo_app/layout%20screen/home%20screen.dart';
import 'package:todo_app/login/login%20screen.dart';
import 'package:todo_app/storge%20local/cash_Helper.dart';
class ApplicationProvider extends ChangeNotifier{
  ThemeMode currentTheme = ThemeMode.system;
  String currentLanguage = "en";
  bool loggedIn = true;

  ApplicationProvider(){
    if(CashHelper.getLanguageSharedPreferences() == null){
      currentLanguage = "en";
    }
    else{
      currentLanguage = CashHelper.getLanguageSharedPreferences() == "en"?"en":"ar";
    }
    if(CashHelper.getLoggedInInSharedPreferences() == null){
      loggedIn = true;
    }
    else{
      loggedIn = CashHelper.getLoggedInInSharedPreferences() == true?true:false;
    }
    notifyListeners();
  }
  String getNameScreen(){
    return loggedIn == true?LoginScreen.routeName:HomeScreen.routeName;
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
}