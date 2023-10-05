// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/email_text_field.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';

class ForgotPasswordMailOption extends StatefulWidget {
  const ForgotPasswordMailOption({super.key});

  @override
  State<ForgotPasswordMailOption> createState() =>
      _ForgotPasswordMailOptionState();
}

class _ForgotPasswordMailOptionState extends State<ForgotPasswordMailOption> {
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height10 = Dimensions.height10;
    double width10 = Dimensions.width10;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height10 * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height10 * 3.5),
                  child: SquareTile(
                    imagePath: emailSvg, //!
                    height: height10 * 15, onTap: () {},
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
                        child: EmailTextField(controller: _email),
                      ),
                      blueButton(
                        onPressed: () {
                          AuthService.firebase()
                              .passwordReset(email: _email.text.trim());
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
