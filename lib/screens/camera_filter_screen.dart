import 'package:flutter/material.dart';
import 'package:camera_filters/camera_filters.dart';

class CameraFilterScreen extends StatefulWidget {
  const CameraFilterScreen({super.key});

  @override
  State<CameraFilterScreen> createState() => _CameraFilterScreenState();
}

class _CameraFilterScreenState extends State<CameraFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CameraScreenPlugin(
        onDone: (value) {
        },
        onVideoDone: (value) {
        },
      ),
    );
  }
}
