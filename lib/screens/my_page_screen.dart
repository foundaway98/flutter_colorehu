import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorehu/providers/user_provider.dart';
import 'package:flutter_colorehu/widgets/color_box_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/api_adapter.dart';
import '../models/model_colorset.dart';
import '../models/model_signin.dart';
import 'package:cyclop/cyclop.dart';
import 'package:colornames/colornames.dart';

class MyPageScreen extends StatefulWidget {
  final User user;
  const MyPageScreen({super.key, required this.user});
  static String routeName = "screens/my_page_screen.dart";

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late Future<List<ColorSet>> colorList;
  late UserProvider _userProvider;
  bool isEdited = false;
  String nickname = "";
  late User nicknameChangeduser;

  final _textController = TextEditingController();

  void showToast() {
    print("toast 시작");
    Fluttertoast.showToast(
      msg: "중복된 닉네임입니다",
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.amber,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  deleteFromServer(int cid) async {
    final response = await http.get(
      Uri.http('54.252.58.5:8000', 'colorset/deleteset/$cid'),
    );
    print("delete colorset recommend lists = ${response.statusCode}");
    // String responseBody = utf8.decode(response.bodyBytes);
    // List<ColorSet> list = parseColorSet(responseBody);
    // return list;
  }

  changeNicknameFromServer(int id, String nickname) async {
    final response = await http.get(
      Uri.http('54.252.58.5:8000', 'signin/update/$id/$nickname'),
    );
    print("change nickname user = ${response.statusCode}");
    if (response.statusCode == 400) {
      showToast();
    } else {
      nicknameChangeduser = User.fromJson(jsonDecode(response.body));
      setState(() {
        nickname = _textController.text;
        _userProvider.nickname = nickname;
        isEdited = !isEdited;
      });
    }
  }

  Future<List<ColorSet>> loadMyColorSetListFromServer(int id) async {
    final response = await http.get(
      Uri.http('54.252.58.5:8000', 'colorset/loadset/$id'),
    );
    print("get colorset My color set lists = ${response.statusCode}");
    String responseBody = utf8.decode(response.bodyBytes);
    List<ColorSet> list = parseColorSet(responseBody);
    print(list[0].colorsetstr);
    return list;
  }

  void editNickname() {
    setState(() {
      isEdited = !isEdited;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    colorList = loadMyColorSetListFromServer(_userProvider.id);
    nickname = _userProvider.nickname;
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
                        _userProvider.nickname,
                        style: const TextStyle(fontSize: 24),
                      ),
                IconButton(
                  onPressed: () {
                    nickname = _textController.text;
                    isEdited
                        ? changeNicknameFromServer(widget.user.id, nickname)
                        : editNickname();
                  },
                  icon: isEdited
                      ? const Icon(Icons.save_alt_outlined)
                      : const Icon(Icons.edit_outlined),
                )
              ],
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: FutureBuilder(
                future: colorList,
                builder: (context, futureResult) {
                  if (futureResult.hasData && futureResult.data!.isNotEmpty) {
                    return makeList(futureResult);
                  }
                  return const Center(
                    child: Text("색 조합을 만들어보세요"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<ColorSet>> futureResult) {
    return ListView.separated(
      shrinkWrap: false,
      itemCount: futureResult.data!.length,
      itemBuilder: (context, index) {
        bool isVisible = true;
        var colorPack = [];
        var color = futureResult.data![index];
        colorPack.add(color.color1);
        colorPack.add(color.color2);
        colorPack.add(color.color3);
        colorPack.add(color.color4);
        colorPack.add(color.color5);
        return Visibility(
          visible: isVisible,
          child: Column(
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
                            : const SizedBox(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('삭제'),
                                content: const Text("색 조합을 삭제하시겠습니까?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteFromServer(
                                          futureResult.data![index].id);
                                      setState(() {
                                        isVisible = false;
                                      });
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    child: const Text('삭제'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          "x",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 5);
      },
    );
  }
}
