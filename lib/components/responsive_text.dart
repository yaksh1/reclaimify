import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';

class ResponsiveText extends StatelessWidget {
  ResponsiveText(
      {required this.text,
      this.textAlign = TextAlign.left,
      this.style = const TextStyle(fontSize: 14,color: AppColors.grey),
      Key? key})
      : super(key: key);

  String text;
  TextStyle style;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: text,
        style: style,
      ),
    );
  }
}
