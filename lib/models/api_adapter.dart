


import 'dart:convert';

import 'model_colorset.dart';
import 'model_signin.dart';

List<User> parseUsers(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

List<ColorSet> parseColorSet(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
  return parsed.map<ColorSet>((json) => ColorSet.fromJson(json)).toList();
}
    // .cast<Map<String,dynamic>>()