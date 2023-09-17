// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/login/login_view.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // title
                const BigText(
                    text: "Verify email.", color: AppColors.darkGrey, size: 55),

                // white spaces
                const SizedBox(
                  height: 50,
                ),

                //texts
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: AppColors.slateGrey),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        children: [
                          SmallText(
                            text:
                                "We've sent you an email verification. Please confirm your email address.",
                            size: 20,
                            color: AppColors.primaryBlack,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SmallText(
                            text:
                                "If you haven't received a verification yet. click below.",
                            size: 20,
                            color: AppColors.primaryBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //white spaces
                const SizedBox(
                  height: 50,
                ),

                // verification button
                MaterialButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
                  },
                  //* styles of button
                  textColor: AppColors.grey,
                  color: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  height: 60,
                  minWidth: 347,
                  child: Text(
                    "Send email verification",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),

                //white spaces
                const SizedBox(
                  height: 50,
                ),

                // back to sign up page
                MaterialButton(
                  onPressed: () async {
                    await AuthService.firebase().logOut();
                    Get.to(()=>LoginView());
                  },
                  //* styles of button
                  textColor: AppColors.grey,
                  color: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  height: 60,
                  minWidth: 347,
                  child: Text(
                    "Log in",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            // fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 22)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
