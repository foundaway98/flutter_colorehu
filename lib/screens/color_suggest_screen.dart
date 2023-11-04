import 'dart:convert';

import 'package:colornames/colornames.dart';
import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorehu/providers/user_provider.dart';
import 'package:flutter_colorehu/widgets/color_box_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/api_adapter.dart';
import '../models/model_colorset.dart';

class ColorSuggestScreen extends StatefulWidget {
  const ColorSuggestScreen({super.key, required this.color});

  final String color;

  @override
  State<ColorSuggestScreen> createState() => _ColorSuggestScreenState();
}

Future<List<ColorSet>> loadRecommendFromServer(
    String colorStr, String keyword) async {
  final response = await http.get(
    Uri.http(
        '13.239.11.253:8000', 'colorset/loadrecommendset/$colorStr/$keyword'),
  );
  String responseBody = utf8.decode(response.bodyBytes);
  List<ColorSet> list = parseColorSet(responseBody);
  return list;
}

saveColorSetToServer(ColorSet colorset) async {
  final response = await http.post(Uri.http('13.239.11.253:8000', 'colorset/'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(colorset));
  return response.body;
}

class _ColorSuggestScreenState extends State<ColorSuggestScreen> {
  //provider
  late UserProvider _userProvider;
  late Future<List<ColorSet>> colorList;
  List<Color> userSelectedColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  List<bool> colorFlag = [false, false, false, false, false];

  List<Text> buttons = [
    const Text('PPT'),
    const Text('Fashion'),
    const Text('Interior')
  ];

  List<Text> dialogButton = [
    const Text('PPT'),
    const Text('Fashion'),
    const Text('Interior')
  ];

  List<bool> buttonSelected = [false, false, false];
  List<bool> sharedToggle = [true, false, false];
  List<String> buttonString = ["PPT", "Fashion", "Interior"];

  bool isSharing = false;

  List<bool> toggleButtonInIt() {
    return [false, false, false];
  }

  @override
  void initState() {
    super.initState();
    if (widget.color != "") {
      userSelectedColors[0] = widget.color.toColor();
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
      var rgb = int.parse(rgbValue, radix: 16);

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
    //provider 생성
    _userProvider = Provider.of<UserProvider>(context);
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
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      userSelectedColors = [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ];
                      colorFlag = [false, false, false, false, false];
                      buttonSelected = toggleButtonInIt();
                    },
                  );
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
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
                                height: 400,
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
                                            style:
                                                TextStyle(color: Colors.black),
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
                                      height: 125,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            for (int i = 0;
                                                i < userSelectedColors.length;
                                                i++)
                                              colorFlag[i]
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                userSelectedColors[
                                                                    i],
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
                                                              userSelectedColors[
                                                                      i]
                                                                  .colorName),
                                                        )
                                                      ],
                                                    )
                                                  : Container(),
                                          ],
                                        ),
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
                                          borderRadius: const BorderRadius.all(
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            List<String> colorString = [
                                              "",
                                              "",
                                              "",
                                              "",
                                              ""
                                            ];
                                            String colorsetstr = "";
                                            String keyword = "PPT";

                                            //make colors to string
                                            for (int i = 0; i < 5; i++) {
                                              if (colorFlag[i] == true) {
                                                colorString[i] =
                                                    userSelectedColors[i]
                                                        .toString()
                                                        .substring(10, 16);
                                              }
                                            }

                                            //make colorsetstr
                                            for (String c in colorString) {
                                              if (c != "") {
                                                String css = converter(c);
                                                colorsetstr += css;
                                                colorsetstr += ',';
                                              }
                                            }

                                            //set sharing

                                            //set keyword
                                            for (int i = 0; i < 3; i++) {
                                              if (sharedToggle[i] == true) {
                                                if (i == 0) {
                                                  keyword = "PPT";
                                                } else if (i == 1) {
                                                  keyword = "Fashion";
                                                } else if (i == 2) {
                                                  keyword = "Interior";
                                                }
                                              }
                                            }

                                            saveColorSetToServer(
                                              ColorSet(
                                                  id: 0,
                                                  uid: _userProvider.id,
                                                  color1: colorString[0],
                                                  color2: colorString[1],
                                                  color3: colorString[2],
                                                  color4: colorString[3],
                                                  color5: colorString[4],
                                                  colorsetstr: colorsetstr,
                                                  share: isSharing,
                                                  keyword: keyword),
                                            );

                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          child: const Text(
                                            'save',
                                            style:
                                                TextStyle(color: Colors.black),
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
                      for (int i = 0; i < userSelectedColors.length; i++)
                        makeColorPickerButton(context, i),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [],
                  ),
                  Flexible(
                    child: colorFlag[0]
                        ? ToggleButtons(
                            constraints: const BoxConstraints.expand(
                                height: 40, width: 100),
                            fillColor: Colors.cyan,
                            selectedColor: Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            onPressed: (index) {
                              setState(() {
                                colorList = loadRecommendFromServer(
                                    converter(userSelectedColors[0]
                                        .toString()
                                        .substring(10, 16)),
                                    buttonString[index]);
                                for (int i = 0;
                                    i < buttonSelected.length;
                                    i++) {
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
                          )
                        : const SizedBox(),
                  ),
                ]),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: !buttonSelected.contains(true)
                ? const Text("M 색을 선택 후 버튼을 눌러주세요")
                : FutureBuilder(
                    future: colorList,
                    builder: (context, futureResult) {
                      if (futureResult.hasData) {
                        return makeList(futureResult);
                      }
                      return const Center(
                        child: Text("..."),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
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
                userSelectedColors[i] = Colors.white;
                buttonSelected = toggleButtonInIt();
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
                      selectedColor: userSelectedColors[i],
                      onColorSelected: (value) {
                        setState(() {
                          colorFlag[i] = true;
                          userSelectedColors[i] = value;
                          buttonSelected = toggleButtonInIt();
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
                  color: userSelectedColors[i],
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
              colorFlag[i] ? userSelectedColors[i].colorName : '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<ColorSet>> futureResult) {
    return ListView.separated(
      shrinkWrap: false,
      itemCount: futureResult.data!.length,
      itemBuilder: (context, index) {
        var colorPack = [];
        var color = futureResult.data![index];
        colorPack.add(color.color1);
        colorPack.add(color.color2);
        colorPack.add(color.color3);
        colorPack.add(color.color4);
        colorPack.add(color.color5);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String color in colorPack)
                      color != ""
                          ? Column(
                              children: [
                                ColorBoxWidget(color: color.toColor()),
                                SizedBox(
                                  width: 50,
                                  child: Text(color.toColor().colorName),
                                )
                              ],
                            )
                          : const SizedBox()
                  ],
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 5);
      },
    );
  }
}
