// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';

class MyTextFields extends StatelessWidget {
  final String text;
  final bool obscureText;
  final bool enableSuggestions;
  final TextInputType? inputType;
  final bool autocorrect;
  final TextEditingController? controller;
  const MyTextFields(
      {super.key,
      required this.text,
      this.controller,
      required this.obscureText,
      required this.enableSuggestions,
      required this.autocorrect, this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: TextField(
        
        controller: controller,
        keyboardType: inputType,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: text,
          hintStyle:TextStyle(color:AppColors.textBoxPlaceholder,fontFamily: 'Poppins'),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textBoxPlaceholder)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryBlack)),
        ),
      ),
    );
  }
}
