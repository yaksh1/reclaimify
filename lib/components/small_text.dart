// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextAlign? alignment;
  final FontWeight? weight;
  const SmallText(
      {super.key,
      this.color = AppColors.slateGrey,
      required this.text,
      this.size = 18,
      this.height = 1.2,
      this.weight = FontWeight.w500, this.alignment = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: alignment,
        style:TextStyle(
          color: color,
          fontSize: size,
          height: height,
          fontWeight: weight,
        ),);
  }
}
