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

Future<List<ColorSet>> loadRecommendFromServer(String colorStr,String keyword) async {
  final response = await http.get(
    Uri.http('54.252.58.5:8000', 'colorset/loadrecommendset/$colorStr/$keyword'),
  );
  print("get colorset recommend lists = ${response.statusCode}");
  String responseBody = utf8.decode(response.bodyBytes);
  List<ColorSet> list = parseColorSet(responseBody);
  return list;
}


saveColorSetToServer(ColorSet colorset) async {
  final response = await http.post(Uri.http('54.252.58.5:8000', 'colorset/'),
      body: colorset.toJson());
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
  List<List<Color>> colorSet = [
    [
      Colors.black,
      Colors.white,
      Colors.grey,
    ],
    [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
    ],
    [
      Colors.blueGrey,
      Colors.grey,
      Colors.amber,
      Colors.yellowAccent,
      Colors.deepPurple,
    ],
  ];

  List<Text> buttons = [
    const Text('PPT'),
    const Text('fashion'),
    const Text('interior')
  ];

  List<Text> dialogButton = [
    const Text('PPT'),
    const Text('fashion'),
    const Text('interior')
  ];

  List<bool> buttonSelected = [true, false, false];
  List<bool> sharedToggle = [true, false, false];

  bool isSharing = false;

  @override
  void initState() {
    super.initState();
    if (widget.color != "") {
      colorPack[0] = widget.color.toColor();
      colorFlag[0] = true;
    }
  }

  String converter(String colorString) {
    List<String> alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];

    List<String> convertedString = [];
    String result = "";

    for (var i = 0; i <= 4; i += 2) {
      convertedString.add(colorString.substring(i, i + 2));
    }

    for (String rgbValue in convertedString) {
      int rgb = int.parse(rgbValue, radix: 16);

      for (var i = 0; i < 26; i++) {
        if (rgb ~/ 10 == i) {
          result += alphabet[i];
        }
      }
    }
    return result;
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
                  onPressed: () {
                    int trueChecked = 0;
                    for (int i = 0; i < colorFlag.length; i++) {
                      if (colorFlag[i] == true) trueChecked++;
                    }

                    if (trueChecked >= 3) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Dialog(
                                child: SizedBox(
                                  height: 350,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              "색 조합 저장",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      SizedBox(
                                        height: 105,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            for (int i = 0;
                                                i < colorPack.length;
                                                i++)
                                              colorFlag[i]
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colorPack[i],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                spreadRadius: 0,
                                                                blurRadius: 3.0,
                                                                offset:
                                                                    const Offset(
                                                                  0,
                                                                  3,
                                                                ), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                          child: Text(
                                                              colorPack[i]
                                                                  .colorName),
                                                        )
                                                      ],
                                                    )
                                                  : Container(),
                                          ],
                                        ),
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          return ToggleButtons(
                                            constraints: BoxConstraints.expand(
                                                width:
                                                    constraints.maxWidth / 3.3),
                                            fillColor: Colors.cyan,
                                            selectedColor: Colors.black,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            onPressed: (index) {
                                              setState(() {
                                                for (int i = 0;
                                                    i < sharedToggle.length;
                                                    i++) {
                                                  if (i == index) {
                                                    sharedToggle[i] = true;
                                                  } else {
                                                    sharedToggle[i] = false;
                                                  }
                                                }
                                              });
                                            },
                                            isSelected: sharedToggle,
                                            children: dialogButton,
                                          );
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Wrap(
                                            direction: Axis.vertical,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: -15,
                                            children: [
                                              Checkbox(
                                                value: isSharing,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isSharing = !isSharing;
                                                    value = isSharing;
                                                  });
                                                },
                                              ),
                                              const Text('share')
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'save',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.save_alt_outlined),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < colorPack.length; i++)
                          makeColorPickerButton(context, i),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              Text(
                                'Search with Main',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                              for (int i = 0; i < buttonSelected.length; i++) {
                                if (i == index) {
                                  buttonSelected[i] = true;
                                } else {
                                  buttonSelected[i] = false;
                                }
                              }
                            });
                          },
                          isSelected: buttonSelected,
                          children: buttons,
                        );
                      },
                    ),
                  ]),
            ),
            Flexible(
              flex: 2,
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
                  borderRadius: BorderRadius.circular(8)),
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
            height: 40,
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
              const Text("Color Name + Color Name"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var color in colorSet[index])
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 3.0,
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(color.colorName),
                            )
                          ],
                        )
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_rounded),
                  )
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 5);
        },
        itemCount: colorSuggestionList.length);
  }
}
