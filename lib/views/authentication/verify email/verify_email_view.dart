// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/views/authentication/login/login_view.dart';


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    double height10 = Dimensions.height10;
    double radius10 = Dimensions.radius10;
    double width10 = Dimensions.width10;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width10 * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //! svg picture
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height10 * 3.5),
                    child: SvgPicture.asset(mailSentSvg,
                        height: height10 * 15,
                        width: width10 * 15,
                        fit: BoxFit.scaleDown),
                  ),

                  //! title
                  BigText(
                      text: "Email has been sent!",
                      color: AppColors.primaryBlack,
                      size: width10 * 2.5),

                  //! white spaces
                  SizedBox(
                    height: height10,
                  ),

                  //!texts
                  SmallText(
                    text:
                        "Please check your inbox and confirm your email address.",
                    size: width10 * 1.5,
                    weight: FontWeight.w400,
                    alignment: TextAlign.center,
                  ),

                  //!white spaces
                  SizedBox(
                    height: height10 * 5,
                  ),

                  //! log in
                  blueButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Get.to(() => LoginView());
                      },
                      borderRadius: radius10*3,
                      width: width10*20,
                      text: "LOG IN"),

                  //!white spaces
                  SizedBox(
                    height: height10 * 4,
                  ),

                  //!texts
                  SmallText(
                    text: "Didn't receive the link?",
                    size: width10 * 1.5,
                    weight: FontWeight.w400,
                    alignment: TextAlign.center,
                  ),

                  //!white spaces
                  SizedBox(
                    height: height10 *2,
                  ),

                  //! resend
                  InkWell(
                    onTap:() async {
                      await AuthService.firebase().sendEmailVerification();
                    },
                    child: IconAndTextWidget(
                        icon: Icons.replay_outlined,
                        text: "Resend",
                        iconColor: Colors.redAccent,
                        textColor: Colors.redAccent,),
                  ),

                  //white spaces
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
