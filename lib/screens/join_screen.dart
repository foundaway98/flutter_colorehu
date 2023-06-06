import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorehu/models/model_signin.dart';
import 'package:flutter_colorehu/platforms/login_platform.dart';
import 'package:flutter_colorehu/providers/user_provider.dart';
import 'package:flutter_colorehu/screens/main_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:http/http.dart' as http;

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  late UserProvider _userProvider;
  LoginPlatform _loginPlatform = LoginPlatform.none;
  late String pw;
  late String checkedPW;
  bool googleLogedIn = false;

  late String email;
  late String displayName;
  late GoogleSignInAccount userInfo;
  late User userIdNickEmail;

  void toServer(String nickname, String email) async {
    var user = User(id: 0, nickname: nickname, email: email);
    final response = await http.post(Uri.http('54.252.58.5:8000', 'signin/'),
        body: user.toJson());
    print(response.body);
    if (response.statusCode == 200) {
      userIdNickEmail = User.fromJson(jsonDecode(response.body));
      _userProvider.email = userIdNickEmail.email;
      _userProvider.nickname = userIdNickEmail.nickname;
      _userProvider.id = userIdNickEmail.id;
      _userProvider.isLoggedIn = true;
    }
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
      displayName = googleUser.displayName!;

      toServer(displayName, email);
      setState(() {
        _loginPlatform = LoginPlatform.google;
        userInfo = googleUser;
        googleLogedIn = true;
      });
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth / 1.2,
                height: constraints.maxHeight / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight / 2 / 4,
                    ),
                    SignInButton(
                      buttonType: ButtonType.google,
                      imagePosition: ImagePosition.right,
                      //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                      buttonSize: ButtonSize.large,
                      btnTextColor: Colors.grey,
                      btnColor: Colors.white,
                      width: 140,
                      //[width] Use if you change the text value.
                      btnText: 'Google',
                      onPressed: _userProvider.isLoggedIn
                          ? null
                          : () {
                              signInWithGoogle();
                            },
                    ),
                    SizedBox(
                      height: constraints.maxHeight / 2 / 4 / 2,
                    ),
                    _userProvider.isLoggedIn
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                    user: userIdNickEmail,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 5.0,
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
