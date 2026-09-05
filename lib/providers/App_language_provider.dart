import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier{
  String appLanguage="en";
  void changelanguage(String text){
    if(appLanguage==text){
      return;
    }
    appLanguage=text;
    notifyListeners();
  }
}