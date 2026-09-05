import 'package:evantly_app/model/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  ///data
  MyUser? currentUser;

  updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
