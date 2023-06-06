import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
