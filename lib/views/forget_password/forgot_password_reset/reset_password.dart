// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/password_text_field.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
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
    TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

    //! <---- global form key -----> //
  final _formKey = GlobalKey<FormState>();

  double height10 = Dimensions.height10;
  double width10 = Dimensions.width10;
  double radius10 = Dimensions.radius10;
  var newPassword = '';

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
                  padding: EdgeInsets.only(bottom: height10*2 ),
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
                  key: _formKey,
                  child: Column(
                    children: [
                      //! new password
                      PasswordTextField(
                          controller: _newPassword,
                          labelText: "New password",
                          hintText: "Enter new password"),
                      //! white space
                      SizedBox(
                        height: 5,
                      ),
                      //! confirm password
                      PasswordTextField(
                          controller: _confirmPassword,
                          labelText: "Confirm password",
                          hintText: "Enter your new password again"),

                      //! white space
                      SizedBox(
                        height: 5,
                      ),
                      //! button
                      blueButton(onPressed: () {
                        if (_formKey.currentState!.validate() &&
                                _newPassword.text == _confirmPassword.text) {
                              setState(() {
                                newPassword = _newPassword.text;
                              });
                              changePassword();
                            }
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
  final user = FirebaseAuth.instance.currentUser;
  Future changePassword() async {
    try {
      await user!.updatePassword(newPassword);
      AuthService.firebase().logOut();
      MySnackBar().mySnackBar(
        header: "Password Changed",
        content: "Your Password has been changed, login again!",
      );
      Get.to(() => LoginView());
    } catch (e) {
      MySnackBar().mySnackBar(
        header: "Error",
        content: e.toString(),
        bgColor: Colors.red.shade100,
        borderColor: Colors.red,
      );
    }
  }
}
