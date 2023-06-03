import 'package:colornames/colornames.dart';
import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';

class ColorSuggestScreen extends StatefulWidget {
  const ColorSuggestScreen({super.key, required this.color});

  final String color;

  @override
  State<ColorSuggestScreen> createState() => _ColorSuggestScreenState();
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

  List<List<String>> name = [
    ['ppt', '00000', 'asdasda'],
    [
      'data',
      '00000',
      'asdasda',
      '00000',
      '00000',
    ],
    ['fashion', '00000', 'asdasda'],
  ];

  List<Text> buttons = [
    const Text('PPT'),
    const Text('fashion'),
    const Text('interior')
  ];

  List<bool> buttonSelected = [true, false, false];
  late int colorNum;

  @override
  void initState() {
    super.initState();
    if (widget.color != "") {
      colorPack[0] = widget.color.toColor();
      colorFlag[0] = true;
      colorNum = 0;
    } else {
      colorNum = -1;
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
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (colorNum == 4) {
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ColorPicker(
                              selectedColor: colorPack[colorNum],
                              onColorSelected: (value) {
                                setState(() {
                                  colorFlag[colorNum] = true;
                                  colorPack[colorNum] = value;
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
                      colorNum++;
                    }
                  },
                  child: const Icon(
                    Icons.add,
                    size: 50,
                  ),
                )),
            Flexible(
              flex: 2,
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
                    )
                  ]),
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
              colorFlag[i]
                  ? setState(() {
                      colorFlag.removeAt(i);
                      colorPack.removeAt(i);
                      colorNum--;
                      if (colorNum < -1) colorNum = -1;

                      colorFlag.add(false);
                      colorPack.add(Colors.white);
                    })
                  : () {};
            },
            child: const SizedBox(
              width: 20,
              child: Text(
                "x",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return Dialog(
              //       child: ColorPicker(
              //         selectedColor: colorPack[i],
              //         onColorSelected: (value) {
              //           setState(() {
              //             colorFlag[i] = true;
              //             colorPack[i] = value;
              //           });
              //         },
              //         config: const ColorPickerConfig(
              //           enableLibrary: false,
              //           enableEyePicker: false,
              //           enableOpacity: false,
              //         ),
              //         onClose: Navigator.of(context).pop,
              //         onEyeDropper: () {},
              //       ),
              //     );
              //   },
              // );
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorPack[i],
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
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
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.favorite_border_rounded),
                  // )
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
