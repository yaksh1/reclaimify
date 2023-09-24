// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/views/forget_password/forgot_password_reset/reset_password.dart';

class ForgotPasswordOtp extends StatelessWidget {
  const ForgotPasswordOtp({super.key});

  @override
  Widget build(BuildContext context) {
    var otp;
    double height10 = Dimensions.height10;
    double width10 = Dimensions.width10;
    double radius10 = Dimensions.radius10;
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //! svg image
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height10 * 2),
                  child: SquareTile(
                    imagePath: otpSvg, //!
                    height: height10 * 18, onTap: () {  },
                  ),
                ),
                //! heading
                BigText(
                  text: "OTP Verification",
                  color: AppColors.primaryBlack,
                  weight: FontWeight.w800,
                  size: width10 * 2.8,
                ),
                SizedBox(
                  height: height10,
                ),
                //! code sent at
                SmallText(
                  text: "Enter the OTP code sent at yakshgandhi1@gmail.com ",
                  size: width10 * 1.6,
                  alignment: TextAlign.center,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  height: height10 * 3,
                ),
                //! otp text field
                OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  numberOfFields: 6,
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1),
                  cursorColor: AppColors.primaryBlack,
                  focusedBorderColor: AppColors.mainColor,
                  onCodeChanged: (value) => log(value),
                  onSubmit: (code) => {
                    otp = code,
                    log(code),
                    AuthService.firebase().verifyOtp(otp),
                  },
                ),

                //! white spaces
                SizedBox(
                  height: height10 * 3,
                ),
                //! next button
                blueButton(
                    onPressed: () async {
                      var isVerified = await AuthService.firebase().verifyOtp(otp);
                      isVerified ? Get.offAll(ResetPassword()) : Get.back();
                    },
                    text: "Verify Now"),
                //! white spaces
                SizedBox(
                  height: height10 * 3,
                ),
                //!texts
                SmallText(
                  text: "Didn't receive the code?",
                  size: width10 * 1.5,
                  weight: FontWeight.w400,
                  alignment: TextAlign.center,
                ),

                //!white spaces
                SizedBox(
                  height: height10 * 2,
                ),

                InkWell(
                  onTap: () async {
                    //TODO navigate
                  },
                  child: IconAndTextWidget(
                    icon: Icons.replay_outlined,
                    text: "Resend",
                    iconColor: Colors.redAccent,
                    textColor: Colors.redAccent,
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
