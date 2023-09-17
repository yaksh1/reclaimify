// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';

class ForgotPasswordOtp extends StatelessWidget {
  const ForgotPasswordOtp({super.key});

  @override
  Widget build(BuildContext context) {
    double height10 = Dimensions.height10;
    double width10 = Dimensions.width10;
    double radius10 = Dimensions.radius10;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 35.0),
                  child: SquareTile(
                    imagePath: "assets/images/otp.svg",//!
                    height: height10*15,
                  ),
                ),
                BigText(
                  text: "OTP Verification",
                  color: AppColors.primaryBlack,
                  weight: FontWeight.w800,
                  size: width10*3.4,
                ),
                SizedBox(height: height10,),
                SmallText(
                  text: "Enter the OTP code sent at yakshgandhi1@gmail.com ",
                  size: width10*1.8,
                  alignment: TextAlign.center,
                ),
                SizedBox(
                  height: height10*3,
                ),
                OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  numberOfFields:6,
                  filled:true,
                  fillColor: Colors.black.withOpacity(0.1),
                  cursorColor: AppColors.primaryBlack,
                  focusedBorderColor: AppColors.mainColor,
                ),
                SizedBox(height: height10*3,),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    textColor: AppColors.grey,
                    color: AppColors.lightMainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius10*0.8)),
                    height:height10*6 ,
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width10*1.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
