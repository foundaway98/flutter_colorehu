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

  List<String> colorTester = ["test1", "test2", "test3", "test4", "test5"];
  List<String> colorSuggestionList = ["a", "b", "c"];
  List<List<String>> colorSet = [
    ["r", "g", "b"],
    ["r", "y", "b", "a"],
    ["r", "w", "g", "g", "t"],
  ];

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
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < colorPack.length; i++)
                    makeColorPickerButton(context, i),
                ],
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
              decoration: BoxDecoration(color: colorPack[i]),
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(top: 10),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              colorPack[i].colorName,
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
