import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  int _id = 0;
  // ignore: prefer_final_fields
  String _nickname = "";
  // ignore: prefer_final_fields
  String _email = "";

  int get id => _id;
  String get nickname => _nickname;
  String get email => _email;

  set id(int key) {
    _id = key;
    notifyListeners();
  }

  set nickname(String googleNickname) {
    _nickname = googleNickname;
    notifyListeners();
  }

  set email(String googleEmail) {
    _email = googleEmail;
    notifyListeners();
  }
}
