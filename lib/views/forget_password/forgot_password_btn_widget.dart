// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';

class ForgotPasswordBtnWidget extends StatelessWidget {
  const ForgotPasswordBtnWidget({
    required this.title,
    required this.btnIcon,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final String title, subtitle;
  final IconData btnIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double width10 = Dimensions.width10;
    double height10 = Dimensions.height10;
    double radius10 = Dimensions.radius10;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:height10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical:height10*2,horizontal: width10*2),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryBlack,width:2),
            borderRadius: BorderRadius.circular(radius10*2),
            // color: Colors.grey[200],
          ),
          child: Row(
            children: [
              Icon(
                btnIcon,
                size: width10*5,
              ),
              SizedBox(
                width: width10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: title,
                    color: AppColors.primaryBlack,
                    size: width10*2.5,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SmallText(
                      text: subtitle,
                      size: width10*1.4,
                      weight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
