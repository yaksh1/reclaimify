// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/views/forget_password/forgot_password_otp/forgot_password_otp.dart';


class ForgotPasswordPhoneOption extends StatefulWidget {
  const ForgotPasswordPhoneOption({super.key});

  @override
  State<ForgotPasswordPhoneOption> createState() => _ForgotPasswordPhoneOptionState();
}

class _ForgotPasswordPhoneOptionState extends State<ForgotPasswordPhoneOption> {
  double height10 = Dimensions.height10;
  double width10 = Dimensions.width10;
  double radius10 = Dimensions.radius10;
  @override
  Widget build(BuildContext context) {
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
                    imagePath: "assets/images/phone.svg",
                    height: height10*15,
                  ),
                ),
                BigText(
                  text: "Phone Verification",
                  color: AppColors.primaryBlack,
                  weight: FontWeight.w800,
                  size: width10*3.2,
                ),
                SizedBox(
                  height: height10,
                ),
                SmallText(
                  text: "Enter your phone number to reset the password.",
                  size: width10*1.5,
                  alignment: TextAlign.center,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  height: height10*3,
                ),
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height10),
                        child: TextForm(
                          hintText: "Enter your phone number",
                          label: Text("Phone"),
                          obscureText: false,
                          enabledSuggestions: true,
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          icon: PhosphorIcons.duotone.phone,
                        ),
                      ),
                      SizedBox(
                        height: height10*2,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            Get.to(() => ForgotPasswordOtp());
                          },
                          textColor: AppColors.grey,
                          color: AppColors.lightMainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radius10*0.8)),
                          height: height10*6,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
