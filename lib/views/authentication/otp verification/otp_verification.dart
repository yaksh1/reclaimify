// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/services/auth/auth_gate.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/utils/routes.dart';
import 'package:reclaimify/views/authentication/forget_password/forgot_password_phone/forgot_password-phone.dart';
import 'package:reclaimify/views/authentication/forget_password/forgot_password_reset/reset_password.dart';
import 'package:reclaimify/views/authentication/login/login_view.dart';
import 'package:reclaimify/views/authentication/phone%20enter%20view/phone_login_verification.dart';
import 'package:reclaimify/views/landing%20page/landing_page.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key, required this.phoneNum});
  final String phoneNum;
  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  var currentUser = AuthService.firebase().getCurrentUser();
  //! <---- save user phone Number -----> //
  savePhoneNumber(String phoneNo) async {
    await FirebaseFirestore.instance
        .collection("phoneNumbers")
        .doc(currentUser!.uid)
        .set({
      "uid":currentUser!.uid,
      "email":currentUser!.email,
      "phoneNumber": phoneNo,
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code = '';
    double height10 = Dimensions.height10;
    double width10 = Dimensions.width10;
    // double radius10 = Dimensions.radius10;
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
                    height: height10 * 18, onTap: () {},
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
                  text: "Enter the OTP code sent to +91-${widget.phoneNum} ",
                  size: width10 * 1.6,
                  alignment: TextAlign.center,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  height: height10 * 3,
                ),
                //! otp text field

                Pinput(
                  length: 6,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                  onCompleted: (pin) => Logger().d(pin),
                ),
                //! white spaces
                SizedBox(
                  height: height10 * 3,
                ),
                //! next button
                blueButton(
                    onPressed: () async {
                      try {
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: PhoneLoginVerification.verify,
                                smsCode: code);
                        await auth.signInWithCredential(credential);
                        await savePhoneNumber(widget.phoneNum);
                        // Get.offAll(() => LandingPage());
                      } catch (e) {
                        Logger().d(code);
                        MySnackBar().mySnackBar(
                          header: "Error",
                          content: "Wrong OTP",
                          bgColor: Colors.red.shade100,
                          borderColor: Colors.red,
                        );
                      }
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
                  onTap: () async {},
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
