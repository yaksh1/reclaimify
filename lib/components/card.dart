import 'package:flutter/material.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';

class card extends StatelessWidget {
  card({
    super.key,
    required this.path,
    required this.heading,
    required this.subHeading,
    required this.cardColor, required this.onTap,
  });

  final double width10 = Dimensions.width10;
  final double height10 = Dimensions.height10;
  final double radius10 = Dimensions.radius10;
  final String path;
  final String heading;
  final String subHeading;
  final Color cardColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height10 * 1.7, horizontal: width10 * 1.5),
        height: height10 * 19,
        width: width10 * 35,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(radius10 * 1.9),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(path),
            BigText(
              text: heading,
              color: AppColors.darkGrey,
              size: width10 * 2.5,
            ),
            SmallText(
              text: subHeading,
              size: width10 * 1.5,
              color: AppColors.smallText,
            )
          ],
        ),
      ),
    );
  }
}
