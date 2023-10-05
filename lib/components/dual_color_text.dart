import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';

class DualColorText extends StatelessWidget {
  const DualColorText({
    super.key,
    required this.text1,
    required this.text2,
    this.size = 30,
    this.align = TextAlign.center,
    this.color = AppColors.grey,
    this.weight1 = FontWeight.normal,
    required this.color2,
    this.weight2 = FontWeight.normal,
  });

  final String text1;
  final String text2;
  final double size;
  final TextAlign align;
  final Color color;
  final Color color2;
  final FontWeight weight1;
  final FontWeight weight2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: align,
      text: TextSpan(
        text: text1,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: weight1,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: size,
              color: color2,
              fontWeight: weight2,
            ),
          ),
        ],
      ),
    );
  }
}
