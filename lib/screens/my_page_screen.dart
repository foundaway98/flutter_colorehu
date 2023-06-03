import 'package:colornames/colornames.dart';
import 'package:flutter/material.dart';

class MyPageScreeen extends StatefulWidget {
  const MyPageScreeen({super.key});

  @override
  State<MyPageScreeen> createState() => _MyPageScreeenState();
}

class _MyPageScreeenState extends State<MyPageScreeen> {
  bool isEdited = false;
  String nickname = "";

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

  final _textController = TextEditingController();

  void editNickname() {
    setState(() {
      isEdited = !isEdited;
    });
  }

  void saveNickname() {
    setState(() {
      nickname = _textController.text;
      isEdited = !isEdited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isEdited
                    ? Flexible(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    : Text(
                        nickname,
                        style: const TextStyle(fontSize: 24),
                      ),
                IconButton(
                  onPressed: () => isEdited ? saveNickname() : editNickname(),
                  icon: isEdited
                      ? const Icon(Icons.save_alt_outlined)
                      : const Icon(Icons.edit_outlined),
                )
              ],
            ),
            Text(nickname),
            Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: makeList(colorSuggestionList))
          ],
        ),
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
