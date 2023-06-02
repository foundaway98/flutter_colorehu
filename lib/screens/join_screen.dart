import 'package:flutter/material.dart';
// import 'package:flutter_colorehu/model/model_signin.dart';
import 'package:flutter_colorehu/platforms/login_platform.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/sign_button.dart';
// import 'package:http/http.dart' as http;

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
  // IconData checked_icon = Icons.cancel;
  late String email;
  // TextEditingController nickname_controller = TextEditingController();
  @override
  void dispose() {
    // nickname_controller.dispose();
    super.dispose();
  }

  void signInWithGoogle() async {
    //final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      // print('name = ${googleUser.displayName}');
      // print('email = ${googleUser.email}');
      // print('id = ${googleUser.id}');
      // print('serverAuthCode = ${googleUser.serverAuthCode}');
      // print('${googleUser.hashCode}');

      email = googleUser.email;

      setState(() {
        _loginPlatform = LoginPlatform.google;
      });
    }
  }

  // toServer(String nickname, String email) async {
  //   var user = User(nickname: nickname, email: email);
  //   final response = await http.post(Uri.http('54.156.21.48:8000', 'signin'),
  //       body: user.toJson());
  //   return response.body;
  // }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () => signInWithGoogle(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
