import 'package:flutter/material.dart';

class ColorSuggestScreen extends StatefulWidget {
  const ColorSuggestScreen({super.key, required this.color});

  final String color;
  @override
  State<ColorSuggestScreen> createState() => _ColorSuggestScreenState();
}

class _ColorSuggestScreenState extends State<ColorSuggestScreen> {
  List<String> colorSuggestionList = ["a", "b", "c"];
  List<List<String>> colorSet = [
    ["r", "g", "b"],
    ["r", "y", "b", "a"],
    ["r", "w", "g", "g", "t"],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.color_lens_outlined),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.color),
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
              child: Container(
                decoration: widget.color == ''
                    ? const BoxDecoration()
                    : BoxDecoration(
                        color: Color(
                          int.parse(widget.color, radix: 16),
                        ),
                      ),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                padding:
                    const EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                child: const Text(
                  "Color name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                )
              ],
            ),
            makeList(colorSuggestionList)
          ],
        ));
  }

  ListView makeList(List<String> colorSuggestionList) {
    return ListView.separated(
        shrinkWrap: true,
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
