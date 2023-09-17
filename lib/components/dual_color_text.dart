import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclaimify/utils/colors.dart';

class DualColorText extends StatelessWidget {
  const DualColorText({
    super.key,
    required this.text1,
    required this.text2,
    this.size = 30,
    this.align = TextAlign.center,
    this.color = AppColors.grey, required this.weight,
  });

  final String text1;
  final String text2;
  final double size;
  final TextAlign align;
  final Color color;
  final FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: align,
      text: TextSpan(
        text: text1,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: weight,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: size,
              color: AppColors.mainColor,
              fontWeight: weight,
            ),
          ),
        ],
      ),
    );
  }
}
