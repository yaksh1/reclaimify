import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';

class blueButton extends StatelessWidget {
  blueButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.borderRadius = 8,
    this.color = AppColors.mainColor,
    this.fontweight = FontWeight.bold,
    this.fontSize = 18,  this.height = 60,  this.textColor = AppColors.grey,
  });

  final double radius10 = Dimensions.radius10;
  final double height10 = Dimensions.height10;
  final double width10 = Dimensions.width10;
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double borderRadius;
  final Color color;
  final Color textColor;
  final FontWeight fontweight;
  final double fontSize;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: width,
      child: MaterialButton(
        
        onPressed: onPressed,
        textColor: textColor,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        height: height,
        child: Text(
          text,
          style: TextStyle(fontWeight: fontweight, fontSize: fontSize),
        ),
      ),
    );
  }
}
