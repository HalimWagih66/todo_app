import 'package:todo_app/database/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CashHelper{
  static late SharedPreferences prefs;
  static Future<void> savedLanguageInSharedPreferences(String saveLanguage)async{
    await prefs.setString("language", saveLanguage);
  }
  static String getLanguageSharedPreferences(){
    return prefs.getString("language")??"English";
  }
  static Future<void> savedLoggedInInSharedPreferences(bool loginUser)async{
    await prefs.setBool("login", loginUser);
  }
  static bool? getLoggedInInSharedPreferences(){
    return prefs.getBool("login");
  }
  static Future<void> savedUserInInSharedPreferences(User user)async{
    await prefs.setStringList("user", [user.id??"",user.email??"",user.name??""]);
  }
  static List<String>? getUserFromSharedPreferences(){
    return prefs.getStringList("user");
  }
}