import 'package:chatapp/themes/Dark_Mode.dart';
import 'package:chatapp/themes/Light_Mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _themedata=lightMode;
  ThemeData get themedata=>_themedata;
  bool get isDarkMode=>_themedata==DarkMode;

  set themeData(ThemeData themedata)
  {
    _themedata=themedata;
      notifyListeners();
  }

  void toggleTheme()
  {
    if(_themedata==lightMode)
      {
        _themedata=DarkMode;
      }
    else
      {
        _themedata=lightMode;
      }

    notifyListeners();
  }


}