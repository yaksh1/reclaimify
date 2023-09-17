// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';

class SmallGreyText extends StatelessWidget {
  final String text;
  const SmallGreyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
  double width10 = Dimensions.width10;
    return Text(
      text,
      style: TextStyle(color: AppColors.slateGrey, fontSize: width10 * 1.6),
    );
  }
}
