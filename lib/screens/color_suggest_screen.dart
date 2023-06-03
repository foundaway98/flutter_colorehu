import 'dart:convert';

import 'package:colornames/colornames.dart';
import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/api_adapter.dart';
import '../models/model_colorset.dart';

class ColorSuggestScreen extends StatefulWidget {
  const ColorSuggestScreen({super.key, required this.color});

  final String color;

  @override
  State<ColorSuggestScreen> createState() => _ColorSuggestScreenState();
}

load_recommend_fromServer(String colorStr) async {
  String colorstr = colorStr;
  final response = await http.get(
    Uri.http('54.252.58.5:8000', 'colorset/loadSet/${colorstr}'),
  );
  print("get colorset recommend lists = ${response.statusCode}");
  String responseBody = utf8.decode(response.bodyBytes);
  List<ColorSet> list = parseColorSet(responseBody);
  return list;
}

save_colorSet_toServer(ColorSet colorset) async{
  final response = await http.post(
      Uri.http('54.252.58.5:8000', 'colorset/'),
      body: colorset.toJson()
  );
  return response.body;
}

class _ColorSuggestScreenState extends State<ColorSuggestScreen> {
  List<Color> colorPack = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  List<bool> colorFlag = [false, false, false, false, false];

  List<String> colorTester = ["test1", "test2", "test3", "test4", "test5"];
  List<String> colorSuggestionList = ["a", "b", "c"];
  List<List<String>> colorSet = [
    ["r", "g", "b"],
    ["r", "y", "b", "a"],
    ["r", "w", "g", "g", "t"],
  ];

  List<Text> buttons = [Text('PPT'), Text('fashion'), Text('interior')];

  List<bool> button_selected = [true, false, false];


  @override
  void initState() {
    super.initState();
    if (widget.color != "") {
      colorPack[0] = widget.color.toColor();
      colorFlag[0] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.color_lens_outlined),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 48,
                ),
                const Text(
                  "Color Set",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.save_alt_outlined),
                ),
              ],
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < colorPack.length; i++)
                      makeColorPickerButton(context, i),
                  ],
                ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return ToggleButtons(
                        constraints: BoxConstraints.expand(
                            width: constraints.maxWidth / 3.3),
                        fillColor: Colors.cyan,
                        selectedColor: Colors.black,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                        onPressed: (index) {
                          setState(() {
                            for (int i = 0; i < button_selected.length; i++) {
                              if (i == index) {
                                button_selected[i] = true;
                              } else {
                                button_selected[i] = false;
                              }
                            }
                          });
                        },
                        children: buttons,
                        isSelected: button_selected,
                      );
                    },
                  )

                ]
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(child: makeList(colorSuggestionList)),
            )
          ],
        ));
  }

  Padding makeColorPickerButton(BuildContext context, i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                colorFlag[i] = false;
                colorPack[i] = Colors.white;
              });
            },
            child: const SizedBox(
                width: 20,
                child: Text(
                  "x",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: ColorPicker(
                      selectedColor: colorPack[i],
                      onColorSelected: (value) {
                        setState(() {
                          colorFlag[i] = true;
                          colorPack[i] = value;
                          print(colorFlag);
                        });
                      },
                      config: const ColorPickerConfig(
                        enableLibrary: false,
                        enableEyePicker: false,
                        enableOpacity: false,
                      ),
                      onClose: Navigator.of(context).pop,
                      onEyeDropper: () {},
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: colorPack[i],
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8)
              ),
              width: i == 0 ? 55 : 50,
              height: i == 0 ? 55 : 50,
              child: i == 0
                  ? Center(
                child: Transform.translate(
                  offset: const Offset(24, -27),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "M",
                        style: TextStyle(
                            backgroundColor:
                            Colors.white.withOpacity(0.1)),
                      ),
                    ),
                  ),
                ),
              )
                  : const Text(""),
            ),

          ),
          SizedBox(
            width: 50,
            height: 50,
            child: Text(
              colorFlag[i] ? colorPack[i].colorName : '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView makeList(List<String> colorSuggestionList) {
    return ListView.separated(
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                colorSuggestionList[index],
                style: const TextStyle(
                  fontSize: 44,
                ),
              ),
              Row(
                children: [for (var color in colorSet[index]) Text(color)],
              )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemCount: colorSuggestionList.length);
  }
}