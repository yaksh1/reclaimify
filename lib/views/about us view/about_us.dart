import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/text_strings.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h,vertical: 16.h),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: "About Us", color: AppColors.darkGrey,weight: FontWeight.w600,),
                SizedBox(height: 20.h,),
                SmallText(
                  text: AboutUsText,
                  color: AppColors.darkGrey,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}