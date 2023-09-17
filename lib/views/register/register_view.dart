// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/dual_color_text.dart';
import 'package:reclaimify/components/error_dialog.dart';
import 'package:reclaimify/components/small_grey_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/components/text_fields.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/services/auth/auth_exceptions.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/utils/routes.dart';
import 'package:reclaimify/views/login/login_view.dart';
import 'package:reclaimify/views/verify%20email/verify_email_view.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController? _name;
  TextEditingController? _email;
  TextEditingController? _password;

  double height10 = Dimensions.height10;
  double width10 = Dimensions.width10;
  double radius10 = Dimensions.radius10;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
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
                  SvgPicture.asset(registerSvg,
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
                        text: "Register.",
                        color: AppColors.primaryBlack,
                        size: width10 * 3,
                      ),
                    ),
                  ),
                  //! ---- enter your information ---- //
                  Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SmallGreyText(text: "Enter your information")),
                  ),
                  // ---- white spaces ---- //
                  SizedBox(height: height10),

                  //! ---- name field ---- //
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height10),
                    child: TextForm(
                      hintText: "Enter your username",
                      label: Text("Username"),
                      obscureText: false,
                      enabledSuggestions: true,
                      autocorrect: false,
                      controller: _name,
                      icon: Icons.person,
                    ),
                  ),

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
                    padding: EdgeInsets.symmetric(vertical: height10),
                    child: TextForm(
                      hintText: "Enter your password",
                      label: Text("Password"),
                      obscureText: true,
                      enabledSuggestions: false,
                      autocorrect: false,
                      controller: _password,
                      icon: Icons.key_rounded,
                    ),
                  ),

                  //! ---- white spaces ---- //
                  SizedBox(height: height10 * 2),

                  //! ---- sign up button ---- //
                  MaterialButton(
                    onPressed: () async {
                      final email = _email!.text;
                      final password = _password!.text;
                      try {
                        await AuthService.firebase()
                            .createUser(email: email, password: password);

                        // ---- when clicked on sign up button ---- //
                        AuthService.firebase().sendEmailVerification();
                        Navigator.of(context).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                      } on WeakPasswordAuthException {
                        showErrorDialog(
                            context, 'Weak-password, please modify it.');
                      } on EmptyFieldAuthException {
                        showErrorDialog(context,
                            'Email or password is empty, kindly check again.');
                      } on EmailAlreadyInUseAuthException {
                        showErrorDialog(context, 'Email already in use.');
                      } on InvalidEmailAuthException {
                        showErrorDialog(
                            context, 'Invalid email, please check again.');
                      } on GenericAuthException {
                        showErrorDialog(context, "Failed to register");
                      }
                    },
                    //* styles of button
                    textColor: AppColors.grey,
                    color: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius10 * 0.8)),
                    height: height10 * 6,
                    minWidth: double.infinity,
                    child: Text("Sign Up",
                        style: TextStyle(
                            // fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: width10 * 2.2)),
                  ),

                  // ---- white spaces ---- //
                  SizedBox(height: height10 * 2),

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
                  SizedBox(height: height10 * 2),

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

                  // ---- white spaces ---- //
                  SizedBox(height: height10 * 4),

                  //! ---- already have an account? login route ---- //
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false);
                    },
                    child: Ink(
                      child: DualColorText(
                        text1: "Already have an account? ",
                        text2: "Login",
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
