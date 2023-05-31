import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:colornames/colornames.dart';
import 'color_suggest_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ValueNotifier<Color?> hoveredColor = ValueNotifier<Color?>(null);

  bool isClicked = true;
  bool isImage = false;
  String colorHex = '';
  late CameraController _controller;
  late List<CameraDescription> cameras;
  late File userImage;
  String colorName = '';

  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();
    startCamera();
  }

  void startCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraInitialized = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraInitialized && _controller.value.isInitialized) {
      return EyeDrop(
        child: Scaffold(
          appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: const Icon(
                Icons.camera,
                size: 50.0,
              ) /*const Hero(
                  tag: "1",
                  child: Icon(
                    Icons.camera,
                    size: 50.0,
                  ),
                )*/
              ),
          body: Column(
            children: [
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          ValueListenableBuilder<Color?>(
                            valueListenable: hoveredColor,
                            builder: (context, value, _) => Container(
                              color: value ?? Colors.transparent,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(colorHex),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(colorName)
                        ],
                      ),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            if (colorHex == '') {
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ColorSuggestScreen(
                                          color: colorHex,
                                        )),
                              );
                            }
                          },
                          child: const Text('추천받기'),
                        ),
                        const Icon(Icons.arrow_forward),
                        const SizedBox(
                          width: 10,
                        ),
                      ])
                    ],
                  )),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: isClicked
                    ? Container(
                        color: Colors.black,
                        child: CameraPreview(_controller),
                      )
                    : Container(
                        color: Colors.black,
                        child: isImage
                            ? Center(child: Image.file(userImage))
                            : Container(),
                      ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: EyedropperButton(
                          icon: Icons.colorize,
                          onColor: (value) => {},
                          onColorChanged: (value) {
                            hoveredColor.value = abgr2Color(
                                int.parse(cutColor(value), radix: 16));
                            setState(() {
                              colorHex = hoveredColor.value
                                  .toString()
                                  .substring(8, 16);
                              colorName =
                                  int.parse(colorHex.substring(2, 7), radix: 16)
                                      .colorName;
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            setState(() {
                              isClicked = !isClicked;
                            });
                          },
                          icon: const Icon(Icons.mode_comment),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: isClicked
                            ? Container()
                            : IconButton(
                                onPressed: () async {
                                  var picker = ImagePicker();
                                  var image = await picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (image != null) {
                                    setState(() {
                                      userImage = File(image.path);
                                      isImage = true;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.image)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Text("Camera not Found"),
      );
    }
  }
}

String cutColor(Color argbColor) {
  String c1 = argbColor.toString().substring(8, 16);
  return c1;
}
