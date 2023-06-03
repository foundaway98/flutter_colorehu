import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorehu/models/model_signin.dart';
import 'package:flutter_colorehu/platforms/login_platform.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/sign_button.dart';
import 'package:http/http.dart' as http;

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;
  late String pw;
  late String checkedPW;
  bool checked = false;
  IconData checked_icon = Icons.cancel;
  late String email;
  TextEditingController nickname_controller = TextEditingController();
  @override
  void dispose(){
    nickname_controller.dispose();
    super.dispose();
  }

  void signInWithGoogle() async {
    //final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');
      print('serverAuthCode = ${googleUser.serverAuthCode}');
      print('${googleUser.hashCode}');

      email = googleUser.email;

      setState(() {
        _loginPlatform = LoginPlatform.google;
      });
    }
  }
  toServer(String nickname, String email) async{
    var user = User(nickname: nickname,email: email);
    final response = await http.post(
        Uri.http('54.252.58.5:8000','signin'),
        body: user.toJson()
    );
    return response.body;
  }


  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 80,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              child: _loginPlatform != LoginPlatform.none
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 60,
                                ),
                                TextFormField(
                                  initialValue: email,
                                  decoration: const InputDecoration(
                                    labelText: "ID",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  onChanged: (text) {
                                    pw = text;
                                  },
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "PW",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  onChanged: (text) {
                                    checkedPW = text;
                                    if(checkedPW == pw) {
                                      setState(() {
                                        checked_icon = Icons.check_circle;
                                      });
                                    }else{
                                      setState(() {
                                        checked_icon = Icons.cancel;
                                      });
                                    }
                                  },
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "PW checked",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [Icon(
                                      checked_icon,
                                    )]
                                  ),
                                ),
                                TextFormField(
                                  controller: nickname_controller,
                                  decoration: const InputDecoration(
                                    labelText: "Nickname",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        toServer(nickname_controller.text, email);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Complete"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SignInButton(
                      buttonType: ButtonType.google,
                      imagePosition: ImagePosition.right,
                      //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                      buttonSize: ButtonSize.large,
                      btnTextColor: Colors.grey,
                      btnColor: Colors.white,
                      width: 140,
                      //[width] Use if you change the text value.
                      btnText: 'Google',
                      onPressed: () => signInWithGoogle(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
