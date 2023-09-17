// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("An error occurred",
        style: TextStyle(
                fontWeight: FontWeight.w800, color: AppColors.darkGrey)),
        content: Text(
          text,
          style: TextStyle(
                fontWeight: FontWeight.w400, color: AppColors.darkGrey)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK')),
        ],
      );
    },
  );
}
