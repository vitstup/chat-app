import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _theme = darkMode;

  ThemeData get theme => _theme;

  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void changeTheme(){
    _isDarkMode = !_isDarkMode;

    _theme = _isDarkMode ? darkMode : lightMode;

    notifyListeners();
  }
}