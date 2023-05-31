import 'package:flutter/material.dart';

import '../database/models/user.dart';

class AuthProvider extends ChangeNotifier{
  User? currentUser;
  void updateUser(User user){
    currentUser = user;
    notifyListeners();
  }
}