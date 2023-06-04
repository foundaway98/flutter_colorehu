// import 'package:flutter/material.dart';
// import 'package:flutter_colorehu/screens/join_screen.dart';
// import 'package:flutter_colorehu/screens/main_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreen();
// }

// class _LoginScreen extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Flexible(
//             child: Container(
//               width: 400,
//               height: 600,
//               margin: const EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               padding: const EdgeInsets.symmetric(
//                 vertical: 20,
//                 horizontal: 10,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.amber,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "ColoRehu",
//                     style: TextStyle(
//                       fontSize: 64,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 60,
//                   ),
//                   const TextField(
//                     decoration: InputDecoration(
//                       labelText: "ID",
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   const TextField(
//                     decoration: InputDecoration(
//                       labelText: "PW",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const JoinScreen()),
//                           );
//                         },
//                         child: const Text("Join"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const MainScreen()),
//                           );
//                         },
//                         child: const Text("Log In"),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
