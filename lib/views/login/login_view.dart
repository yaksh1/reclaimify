// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/dual_color_text.dart';
import 'package:reclaimify/components/error_dialog.dart';
import 'package:reclaimify/components/small_grey_text.dart';
import 'package:reclaimify/components/small_text.dart';

import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/services/auth/auth_exceptions.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/utils/routes.dart';
import 'package:reclaimify/views/forget_password/forgot_pass_option.dart';
import 'package:reclaimify/views/landing%20page/landing_page.dart';
import 'package:reclaimify/views/register/register_view.dart';
import 'package:reclaimify/views/verify%20email/verify_email_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // TextEditingController? _phone;
  // TextEditingController? _name;
  TextEditingController? _email;
  TextEditingController? _password;
  var logger = Logger();

  double height10 = Dimensions.height10;
  double width10 = Dimensions.width10;
  double radius10 = Dimensions.radius10;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    // _name = TextEditingController();
    // _phone = TextEditingController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _email?.dispose();
  //   _password?.dispose();
  //   _name?.dispose();
  //   _phone?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   title:const Text("Login"),
      // ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              // color: AppColors.onBoardingPage2Color,
              margin: EdgeInsets.symmetric(horizontal: width10 * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //! svg picture //
                  SvgPicture.asset(loginSvg,
                      height: height10 * 15,
                      width: width10 * 15,
                      fit: BoxFit.scaleDown),
                  //! ---- register title ---- //
                  SizedBox(height: height10 * 2),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: BigText(
                        text: "Login",
                        color: AppColors.primaryBlack,
                        size: width10 * 3,
                      ),
                    ),
                  ),
                  //! ---- enter your credentials ---- //
                  Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SmallGreyText(text: "Enter your credentials")),
                  ),

                  // ---- white spaces ---- //
                  SizedBox(height: height10),
                  //! ---- email field ---- //
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

                  //! ---- password field ---- //
                  Padding(
                    padding: EdgeInsets.only(top: height10),
                    child: TextForm(
                      hintText: "Enter your password",
                      label: Text("Password"),
                      obscureText: true,
                      enabledSuggestions: true,
                      autocorrect: false,
                      controller: _password,
                      icon: Icons.key_rounded,
                    ),
                  ),

                  //! ---- forgot password? ---- //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          ForgotPasswordScreen.ForgotPasswordBottomSheet(
                              context);
                        },
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SmallText(
                              text: "Forgot password?",
                              size: width10 * 1.2,
                              weight: FontWeight.w400,
                            )),
                      )
                    ],
                  ),

                  //! ---- white spaces ---- //
                  SizedBox(height: height10 * 4),

                  //! --- log in button ---- //
                  MaterialButton(
                    onPressed: () async {
                      final email = _email!.text;
                      final password = _password!.text;
                      try {
                        // AuthService.firebase()
                        //     .logIn(email: email, password: password);
                        await AuthService.firebase()
                            .logIn(email: email, password: password);
                        final user = AuthService.firebase().currentUser;
                        if (user?.isEmailVerified ?? false) {
                          // user's email is verified
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              landingPageRoute, (route) => false);
                        } else {
                          // user's email is not verified

                          Get.to(() => VerifyEmailView());
                        }
                      } on UserNotFoundAuthException {
                        showErrorDialog(context,
                            'User not found. Please double-check your entered details');
                      } on WrongPasswordAuthException {
                        showErrorDialog(
                            context, 'Wrong Password. Please check again.');
                      } on GenericAuthException {
                        showErrorDialog(context, "Authentication error");
                      }
                    },

                    //* styles of button
                    textColor: AppColors.grey,
                    color: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius10 * 0.8)),
                    height: height10 * 6,
                    minWidth: double.infinity,
                    child: Text("Login",
                        style: TextStyle(
                            // fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: width10 * 2.2)),
                  ),

                  //! ---- white spaces ---- //
                  SizedBox(height: height10 * 4),

                  //! ---- or continue with --- //
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: AppColors.slateGrey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Or continue with",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: AppColors.slateGrey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // white spaces
                  SizedBox(height: height10 * 3),

                  //! ---- log in options ---- //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        facebookLogo,
                        height: height10 * 4,
                      ),
                      SizedBox(
                        width: width10 * 2,
                      ),
                      SvgPicture.asset(
                        googleLogo,
                        height: height10 * 4,
                      ),
                    ],
                  ),

                  // white spaces
                  SizedBox(height: height10 * 3),

                  //! dont have an account?
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, (route) => false);
                    },
                    child: Ink(
                      child: DualColorText(
                        text1: "Don't have an account? ",
                        text2: "Sign up",
                        weight: FontWeight.w400,
                        size: width10 * 1.6,
                        color: AppColors.slateGrey,
                      ),
                    ),
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
