// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reclaimify/components/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  final FontWeight? weight;
  final MainAxisAlignment alignment;
  final double width;
  final double iconSize;
  final double fontSize;

  const IconAndTextWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconColor,
      required this.textColor,
      this.weight,
      this.iconSize = 24,
      this.fontSize = 18,
      this.alignment = MainAxisAlignment.center,
      this.width = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        SizedBox(
          width: width,
        ),
        SmallText(
          text: text,
          color: textColor,
          weight: weight,
          size: fontSize,
        ),
      ],
    );
  }
}
