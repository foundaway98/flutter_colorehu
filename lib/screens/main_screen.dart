import 'package:flutter/material.dart';
import 'package:flutter_colorehu/models/model_signin.dart';
import 'package:flutter_colorehu/providers/user_provider.dart';
import 'package:flutter_colorehu/screens/camera_filter_screen.dart';
import 'package:flutter_colorehu/screens/camera_screen.dart';
import 'package:flutter_colorehu/screens/color_suggest_screen.dart';
import 'package:flutter_colorehu/screens/my_page_screen.dart';
import 'package:flutter_colorehu/widgets/toast_message.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  static String routeName = "screens/main_screen.dart";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //provider
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    ToastMessage().showToast("로그인 성공");
  }

  @override
  Widget build(BuildContext context) {
    //provider 생성
    _userProvider = Provider.of<UserProvider>(context);
    String nickname = _userProvider.nickname;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                title: const Text("MyPage"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPageScreen(
                        user: widget.user,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out"),
                onTap: () {
                  _userProvider.isLoggedIn = false;

                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          ),
        ),
        body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Transform.translate(
                offset: const Offset(160, 140),
                child: Image.asset(
                  'assets/images/color_circle.png',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome,",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      nickname,
                      style:
                          const TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                    ),
                    const Text("feel free to search, check, find color"),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CameraScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: constraints.maxWidth / 2.3,
                              height: constraints.maxWidth / 2.3,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF5952),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(27),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50,
                                    ),
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Color",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ColorSuggestScreen(
                                    color: '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: constraints.maxWidth / 2.3,
                              height: constraints.maxWidth / 2.3,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3E77E9),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(27),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.color_lens_outlined,
                                      size: 50,
                                    ),
                                    Text(
                                      "Color",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Suggest",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CameraFilterScreen(),
                                    ),
                              );
                            },
                            child: Container(
                              width: constraints.maxWidth / 2.3,
                              height: constraints.maxWidth / 2.3,
                              decoration: const BoxDecoration(
                                color: Color(0xFF9F81F7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(27),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.filter_b_and_w_outlined,
                                      size: 50,
                                    ),
                                    Text(
                                      "Filter",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Lens",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth / 2.3,
                            height: constraints.maxWidth / 2.3,
                          ),
                        ],
                      ),
                    ),
                    
                  ]),
            ),
          ],
        ),
      ),
        // Column(
        //   children: [
        //     Expanded(
        //       flex: 2,
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const CameraScreen(),
        //             ),
        //           );
        //         },
        //         child: MainScreenBtn(
        //           buttonName: "Camera",
        //           buttonIcon: Icons.camera_alt_outlined,
        //           buttonColor: Colors.blue.shade400,
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 1,
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const ColorSuggestScreen(
        //                 color: '',
        //               ),
        //             ),
        //           );
        //         },
        //         child: MainScreenBtn(
        //           buttonName: "Color Suggest",
        //           buttonIcon: Icons.color_lens_outlined,
        //           buttonColor: Colors.blue.shade300,
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 1,
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const CameraFilterScreen()),
        //           );
        //         },
        //         child: MainScreenBtn(
        //           buttonName: "Filter",
        //           buttonIcon: Icons.filter_b_and_w_outlined,
        //           buttonColor: Colors.blue.shade200,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

// class MainScreenBtn extends StatelessWidget {
//   final String buttonName;
//   final IconData buttonIcon;
//   final Color buttonColor;
//   const MainScreenBtn({
//     super.key,
//     required this.buttonName,
//     required this.buttonIcon,
//     required this.buttonColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//         color: buttonColor,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             buttonName,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//           Transform.scale(
//             scale: 2.5,
//             child: Transform.translate(
//               offset: const Offset(20, 10),
//               child: Icon(
//                 buttonIcon,
//                 color: Colors.black.withOpacity(0.1),
//                 size: 100,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
