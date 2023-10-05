// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/dual_color_text.dart';
import 'package:reclaimify/components/email_text_field.dart';
import 'package:reclaimify/components/google_sign_in.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/name_text_field.dart';
import 'package:reclaimify/components/password_text_field.dart';
import 'package:reclaimify/components/small_grey_text.dart';
import 'package:reclaimify/components/square_tile.dart';

import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/services/auth/auth_exceptions.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/services/auth/auth_user.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/utils/routes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  //! <---- global key -----> //
  final _formkey = GlobalKey<FormState>();

  double height10 = Dimensions.height10;
  double width10 = Dimensions.width10;
  double radius10 = Dimensions.radius10;
  final mySnackbar = MySnackBar();
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

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
              child: Form(
                key: _formkey,
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
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: NameTextField(controller: _name),
                    ),

                    //! ---- email field ---- //
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: EmailTextField(controller: _email),
                    ),

                    //! ---- password field ---- //
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: PasswordTextField(
                        controller: _password,
                      ),
                    ),

                    //! ---- white spaces ---- //
                    SizedBox(height: height10),

                    //! ---- sign up button ---- //
                    MaterialButton(
                      onPressed: () async {
                        final email = _email.text.trim();
                        final password = _password.text.trim();
                        final name = _name.text.trim();
                        try {
                          await AuthService.firebase().createUser(
                              email: email, password: password, username: name);

                          // ---- when clicked on sign up button ---- //
                          AuthService.firebase().sendEmailVerification();
                         
                          //$ --- DEBUG --- //

                          Logger().d("Registered using $email");

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute, (route) => false);
                        } on WeakPasswordAuthException {
                          mySnackbar.mySnackBar(
                              header: "Weak-password",
                              content: "Please enter a strong password.",
                              bgColor: Colors.red.shade200,
                              borderColor: Colors.red);
                        } on EmptyFieldAuthException {
                          mySnackbar.mySnackBar(
                              header: "Empty Field",
                              content:
                                  "Email or password is empty, kindly check again.",
                              bgColor: Colors.red.shade200,
                              borderColor: Colors.red);
                        } on EmailAlreadyInUseAuthException {
                          mySnackbar.mySnackBar(
                              header: "Email already in use",
                              content: "This email is already in use",
                              bgColor: Colors.red.shade200,
                              borderColor: Colors.red);
                        } on InvalidEmailAuthException {
                          mySnackbar.mySnackBar(
                              header: "Invalid email",
                              content: "Please enter a valid email id",
                              bgColor: Colors.red.shade200,
                              borderColor: Colors.red);
                        } on GenericAuthException {
                          mySnackbar.mySnackBar(
                              header: "Error Occurred",
                              content: "Failed to register.",
                              bgColor: Colors.red.shade200,
                              borderColor: Colors.red);
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
                        SquareTile(
                          imagePath: facebookLogo,
                          onTap: () {},
                          height: height10 * 4,
                        ),
                        SizedBox(
                          width: width10 * 2,
                        ),
                        SquareTile(
                          imagePath: googleLogo,
                          onTap: () {
                            Google().googleLogIn();
                          },
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
      ),
    );
  }
}
