import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonSnackBarWidget {
  static Future<bool?> commonSnackBar(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 12.0);
  }
}
