import 'package:flutter/material.dart';
import 'package:todo_app/storge%20local/cash_Helper.dart';

import '../database/models/user.dart';

class AuthProvider extends ChangeNotifier{
  User? currentUser;
  AuthProvider(){
   List<String>?dateUser = CashHelper.getUserFromSharedPreferences();
   if(dateUser?[0] != null || dateUser?[0].isEmpty != true){
     User user = User(id: dateUser?[0], email: dateUser?[1], name: dateUser?[2]);
     currentUser = user;
     notifyListeners();
   }
  }
  void updateUser(User user)async{
    currentUser = user;
    await CashHelper.savedUserInInSharedPreferences(user);
    notifyListeners();
  }
}