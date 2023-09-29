// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/error_dialog.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/services/auth/auth_exceptions.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/views/forget_password/forgot_password_otp/forgot_password_otp.dart';

class ForgotPasswordPhoneOption extends StatefulWidget {
  const ForgotPasswordPhoneOption({super.key});
  static String verify = '';

  @override
  State<ForgotPasswordPhoneOption> createState() =>
      _ForgotPasswordPhoneOptionState();
}

class _ForgotPasswordPhoneOptionState extends State<ForgotPasswordPhoneOption> {
  TextEditingController _phone = TextEditingController();
  double height10 = Dimensions.height10;
  double width10 = Dimensions.width10;
  double radius10 = Dimensions.radius10;

  @override
  void initState() {
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

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
              children: [
                //! svg picture
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height10 * 3.5),
                  child: SquareTile(
                    imagePath: phoneSvg,
                    height: height10 * 15,
                    onTap: () {},
                  ),
                ),
                //! title
                BigText(
                  text: "Phone Verification",
                  color: AppColors.primaryBlack,
                  weight: FontWeight.w800,
                  size: width10 * 2.5,
                ),
                SizedBox(
                  height: height10,
                ),
                //! subtitle
                SmallText(
                  text: "Enter your phone number to reset the password.",
                  size: width10 * 1.5,
                  alignment: TextAlign.center,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  height: height10 * 3,
                ),
                //! textfield
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
                          autocorrect: false,
                          controller: _phone,
                          icon: PhosphorIcons.duotone.phone,
                        ),
                      ),
                      SizedBox(
                        height: height10 * 2,
                      ),
                      blueButton(
                          onPressed: () async {
                            final phoneNo = _phone.text.trim();

                            try {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: "+91${phoneNo}",
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  ForgotPasswordPhoneOption.verify =
                                      verificationId;
                                  Get.to(()=> ForgotPasswordOtp());
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'invalid-phone-number') {
                                MySnackBar().mySnackBar(
                                    content:
                                        "Please enter a valid phone number",
                                    header: "Invalid phone number format");
                              }
                              Logger().d("invalid format");
                            } on GenericAuthException {
                              showErrorDialog(context, 'Something went wrong.');
                            } catch (e) {
                              Logger().d(e.toString());
                            }
                          },
                          text: "Send Code"),
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

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
