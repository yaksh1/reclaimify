

import 'package:flutter/material.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';

class PlusButtonCard extends StatelessWidget {
  PlusButtonCard({
    super.key,
    required this.cardColor,
    required this.onPressed,
    required this.icon,
    required this.heading,
    required this.subHeading,
  });

  final double width10 = Dimensions.width10;
  final double height10 = Dimensions.height10;
  final double radius10 = Dimensions.radius10;
  final Color cardColor;
  final VoidCallback onPressed;
  final Widget icon;
  final String heading;
  final String subHeading;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height10 * 1.7, horizontal: width10 * 1.5),
      height: height10 * 19,
      width: width10 * 35,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(radius10 * 1.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height10 * 16.5,
            width: width10 * 7,
            child: MaterialButton(
              elevation: 7,
              onPressed: onPressed,
              textColor: AppColors.mainColor,
              color: AppColors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius10 * 1.6)),
              height: height10 * 6,
              child: icon,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BigText(
                text: heading,
                color: AppColors.darkGrey,
                size: width10 * 2.5,  
              ),
              SmallText(
                text: subHeading,
                size: width10*1.2 ,
                color: AppColors.smallText,
              )
            ],
          ),
        ],
      ),
    );
  }
}
