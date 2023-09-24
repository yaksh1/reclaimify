// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/views/forget_password/forgot_password_otp/forgot_password_otp.dart';
import 'package:reclaimify/views/login/login_view.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  double height10 = Dimensions.height10;
  double width10 = Dimensions.width10;
  double radius10 = Dimensions.radius10;
  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(vertical: height10*2 ),
                  child: SquareTile(
                    imagePath: resetPassword,
                    height: height10 * 17, onTap: () {  },
                  ),
                ),
                //! heading
                BigText(
                  text: "Reset your password",
                  color: AppColors.primaryBlack,
                  weight: FontWeight.w800,
                  size: width10 * 2.5,
                ),
                SizedBox(
                  height: height10,
                ),
                //! text
                SmallText(
                  text: "Create a new password for your account below.",
                  size: width10 * 1.5,
                  weight: FontWeight.w400,
                  alignment: TextAlign.center,
                ),
                SizedBox(
                  height: height10 * 3,
                ),
                Form(
                  child: Column(
                    children: [
                      //! new password
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height10),
                        child: TextForm(
                          hintText: "Enter new password",
                          label: Text("Enter new password"),
                          obscureText: true,
                          enabledSuggestions: false,
                          autocorrect: false,
                          icon: PhosphorIcons.duotone.lock,
                        ),
                      ),
                      //! confirm password
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height10),
                        child: TextForm(
                          hintText: "Confirm password",
                          label: Text("Confirm password"),
                          obscureText: true,
                          enabledSuggestions: false,
                          autocorrect: false,
                          icon: PhosphorIcons.duotone.lock,
                        ),
                      ),
                      //! white space
                      SizedBox(
                        height: height10 * 2,
                      ),
                      //! button
                      blueButton(onPressed: () {
                        //TODO: change password from backend
                      }, text: "Change Password"),

                      //! white space
                      SizedBox(
                        height: height10 * 4,
                      ),

                      //! back to sign in
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(() => LoginView());
                        },
                        child: IconAndTextWidget(
                            icon: PhosphorIcons.duotone.signIn,
                            text: "Back to sign in",
                            iconColor: Colors.redAccent,
                            textColor: Colors.redAccent),
                      )
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
