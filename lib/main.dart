import 'package:flutter/material.dart';
import 'package:flutter_colorehu/providers/user_provider.dart';
import 'package:flutter_colorehu/screens/join_screen.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_colorehu/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            background: Colors.blue,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        home: const JoinScreen(),
      ),
    );
  }
}
