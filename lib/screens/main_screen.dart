import 'package:flutter/material.dart';
import 'package:flutter_colorehu/screens/camera_filter_screen.dart';
import 'package:flutter_colorehu/screens/camera_screen.dart';
import 'package:flutter_colorehu/screens/color_suggest_screen.dart';
import 'package:flutter_colorehu/screens/my_page_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatefulWidget {
  final GoogleSignInAccount user;
  const MainScreen({super.key, required this.user});

  static String routeName = "/main_screen.dart";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('colorehu'),
        ),
        drawer: Drawer(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Text('Welcome, ${widget.user.displayName}'),
              ),
              ListTile(
                tileColor: Colors.grey.shade300,
                title: const Text("MyPage"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyPageScreeen(),
                    ),
                  );
                },
              ),
              ListTile(
                tileColor: Colors.grey.shade300,
                title: const Text("Log out"),
                onTap: () {},
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraScreen(),
                    ),
                  );
                },
                child: MainScreenBtn(
                  buttonName: "Camera",
                  buttonIcon: Icons.camera_alt_outlined,
                  buttonColor: Colors.blue.shade400,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ColorSuggestScreen(
                              color: '',
                            )),
                  );
                },
                child: MainScreenBtn(
                  buttonName: "Color Suggest",
                  buttonIcon: Icons.color_lens_outlined,
                  buttonColor: Colors.blue.shade300,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraFilterScreen()),
                  );
                },
                child: MainScreenBtn(
                  buttonName: "Filter",
                  buttonIcon: Icons.filter_b_and_w_outlined,
                  buttonColor: Colors.blue.shade200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreenBtn extends StatelessWidget {
  final String buttonName;
  final IconData buttonIcon;
  final Color buttonColor;
  const MainScreenBtn({
    super.key,
    required this.buttonName,
    required this.buttonIcon,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: buttonColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            buttonName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          Transform.scale(
            scale: 2.5,
            child: Transform.translate(
              offset: const Offset(20, 10),
              child: Icon(
                buttonIcon,
                color: Colors.black.withOpacity(0.1),
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
