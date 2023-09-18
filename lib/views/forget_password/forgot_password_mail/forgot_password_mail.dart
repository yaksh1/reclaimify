// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/views/forget_password/forgot_password_otp/forgot_password_otp.dart';

class ForgotPasswordMailOption extends StatefulWidget {
  const ForgotPasswordMailOption({super.key});

  @override
  State<ForgotPasswordMailOption> createState() =>
      _ForgotPasswordMailOptionState();
}

class _ForgotPasswordMailOptionState extends State<ForgotPasswordMailOption> {
  TextEditingController? _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

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
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height10*2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:height10*3.5),
                  child: SquareTile(
                    imagePath: emailSvg, //!
                    height: height10 * 15,
                  ),
                ),
                BigText(
                  text: "E-mail Verification",
                  color: AppColors.primaryBlack,
                  weight: FontWeight.w800,
                  size: width10 * 2.5,
                ),
                SizedBox(
                  height: height10,
                ),
                SmallText(
                  text: "Enter your email to reset the password.",
                  size: width10 * 1.5,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  height: height10 * 2.5,
                ),
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height10),
                        child: TextForm(
                          hintText: "Enter your email",
                          label: Text("E-mail"),
                          obscureText: false,
                          enabledSuggestions: true,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          controller: _email,
                          icon: Icons.mail_outline_rounded,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      blueButton(
                        onPressed: () {
                          Get.to(() => ForgotPasswordOtp());
                          //TODO: send verification code
                        },
                        text: 'Next',
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

