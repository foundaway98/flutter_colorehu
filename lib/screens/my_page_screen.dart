import 'dart:convert';

import 'package:colornames/colornames.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/api_adapter.dart';
import '../models/model_colorset.dart';
import '../models/model_signin.dart';

class MyPageScreen extends StatefulWidget {
  final User user;
  const MyPageScreen({super.key, required this.user});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}



class _MyPageScreenState extends State<MyPageScreen> {
  bool isEdited = false;
  String nickname = "";
  late User nicknameChangeduser;

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

  changeNicknameFromServer(int id,String nickname) async {
    final response = await http.get(
      Uri.http('54.252.58.5:8000', 'signin/update/$id/$nickname'),
    );
    print("change nickname user = ${response.statusCode}");
    if (response.statusCode==400){
      return false;
    }else{
      nicknameChangeduser = User.fromJson(jsonDecode(response.body));
      return true;
    }
  }

  loadMyColorSetListFromServer(int id) async {
    final response = await http.get(
      Uri.http('54.252.58.5:8000', 'colorset/loadset/$id'),
    );
    print("get colorset My color set lists = ${response.statusCode}");
    String responseBody = utf8.decode(response.bodyBytes);
    List<ColorSet> list = parseColorSet(responseBody);
  }

  void editNickname() {
    setState(() {
      isEdited = !isEdited;
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyColorSetListFromServer(widget.user.id);

  }

  void saveNickname() {
    nickname = _textController.text;
    changeNicknameFromServer(widget.user.id,nickname);
    print(nicknameChangeduser.nickname);
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
                        widget.user.nickname,
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
