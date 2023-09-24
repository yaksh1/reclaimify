
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar{
    void mySnackBar({String header="", String content="",
      Color bgColor = Colors.white, Color borderColor = Colors.white,double blur =0}) {
    Get.snackbar(
      header,
      content,
      barBlur: blur,
      boxShadows: [
        BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
            spreadRadius: 1,
            offset: Offset(0, 1))
      ],
      backgroundColor: bgColor,
      borderColor: borderColor,
      borderWidth: 1,
      borderRadius: 20,
    );
  }
}