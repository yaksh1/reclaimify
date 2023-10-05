import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/dual_color_text.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';

class PostReviseView extends StatelessWidget {
  const PostReviseView({super.key, required this.file});
  final Uint8List file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! <---- image -----> //
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(file),
                        ),
                      ),
                    ),
                    //! <---- post details -----> //
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                              text: "Cat Found",
                              color: AppColors.darkGrey,
                              size: 25),
                          SmallText(
                            text:
                                "White air pods found with case near KS building",
                            weight: FontWeight.w300,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          postDetails(
                            text1: "Type: ",
                            text2: "Found",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          postDetails(
                            text1: "Category: ",
                            text2: "cutie",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          postDetails(
                            text1: "Location: ",
                            text2: "inside kambal",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          postDetails(
                            text1: "Date Found: ",
                            text2: "today",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 5.0.h),
              ),
                    SizedBox(height: 20.h,),
                    //! <---- post button -----> //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:16.0),
                      child: blueButton(
                          onPressed: () {
                            
                          },
                          text: "POST",
                          
                          fontweight: FontWeight.w600,
                          height: 40.h,
                          textColor: AppColors.darkGrey,
                          color: AppColors.lightMainColor2),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}

class postDetails extends StatelessWidget {
  const postDetails({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return DualColorText(
      text1: text1,
      text2: text2,
      weight1: FontWeight.w600,
      weight2: FontWeight.w300,
      size: 20,
      color2: AppColors.slateGrey,
      color: AppColors.darkGrey,
    );
  }
}
