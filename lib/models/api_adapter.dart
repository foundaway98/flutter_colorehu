

import 'dart:convert';

import 'model_signin.dart';

List<User> parseUsers(String responsebody){
  final parsed = json.decode(responsebody).cast<Map<String,dynamic>>();
  return parsed.map<User>((json) =>User.fromJson(json)).toList();
}