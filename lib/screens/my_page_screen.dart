import 'package:flutter/material.dart';

class MyPageScreeen extends StatefulWidget {
  const MyPageScreeen({super.key});

  @override
  State<MyPageScreeen> createState() => _MyPageScreeenState();
}

class _MyPageScreeenState extends State<MyPageScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Page"),
      ),
    );
  }
}
