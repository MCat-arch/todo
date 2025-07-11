import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Custom light theme
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFAF5EC), // ✅ custom background
    primaryColor: Colors.blueAccent,
    colorScheme: ColorScheme.light(
      primary: Colors.blueAccent,
      background: Color(0xFFFAF5EC), // optional, but nice to match
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFAF5EC),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
  );

  final ThemeData darkTheme = ThemeData.dark();

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

