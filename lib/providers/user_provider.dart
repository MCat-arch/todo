import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username = 'User';
  String? _profilePicPath;

  String get username => _username;
  String? get profilePicPath => _profilePicPath;

  void setUsername(String uname) {
    _username = uname;
    notifyListeners();
  }

  void setProfilePic(String path) {
    _profilePicPath = path;
    notifyListeners();
  }
}