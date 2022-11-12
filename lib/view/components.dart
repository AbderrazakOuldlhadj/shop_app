import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const primaryColor = Colors.deepOrange;
const titleTextStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
const subTitleTextStyle = TextStyle(fontSize: 20);

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    gravity: ToastGravity.CENTER,
  );
}
