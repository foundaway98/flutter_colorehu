import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorehu/models/api_adapter.dart';
import 'package:flutter_colorehu/screens/join_screen.dart';
import 'package:flutter_colorehu/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import '../models/model_signin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

fromServer() async{

  final response = await http.get(
      Uri.http('54.252.58.5:8000','signin/get'),
  );
  print(response.statusCode);
  String responsebody = utf8.decode(response.bodyBytes);
  List<User> list= parseUsers(responsebody);
  print('${list[0].nickname} ${list[0].email}');
  print('${list[1].nickname} ${list[1].email}');

  return response.body;
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              width: 400,
              height: 600,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "ColoRehu",
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "ID",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "PW",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const JoinScreen()),
                          );
                        },
                        child: const Text("Join"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          fromServer();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                          );
                        },
                        child: const Text("Log In"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
