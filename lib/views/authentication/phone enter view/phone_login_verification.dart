// ignore_for_file: prefer_const_constructors

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/error_dialog.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/phone_text_field.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/square_tile.dart';
import 'package:reclaimify/services/auth/auth_exceptions.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:reclaimify/views/authentication/otp%20verification/otp_verification.dart';

class PhoneLoginVerification extends StatefulWidget {
  const PhoneLoginVerification({super.key});
  static String verify = '';

  @override
  State<PhoneLoginVerification> createState() => _PhoneLoginVerificationState();
}

class _PhoneLoginVerificationState extends State<PhoneLoginVerification> {
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

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

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
                  text: "Enter your phone number for verification.",
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
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          style: TextStyle(
                            fontSize: 19,
                          ),
                          controller: _phone,
                          enableSuggestions: true,
                          autocorrect: false,
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 8),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      countryListTheme: CountryListThemeData(
                                          bottomSheetHeight: 500),
                                      onSelect: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                        });
                                      });
                                },
                                child: Text(
                                  "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                            prefixIconColor: AppColors.mainColor,
                            label: const Text("Phone"),
                            // helperText: "",
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 12),
                            helperStyle: const TextStyle(
                                color: Colors.black, fontSize: 12),
                            labelStyle: const TextStyle(
                                color: AppColors.textBoxPlaceholder),
                            hintText: "Phone",
                            hintStyle:
                                TextStyle(color: AppColors.textBoxPlaceholder),
                            fillColor: AppColors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: AppColors.darkGrey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: AppColors.primaryBlack, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: AppColors.primaryBlack, width: 2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height10 * 2,
                      ),
                      blueButton(
                          onPressed: () async {
                            final phoneNo = "+${selectedCountry.phoneCode}${_phone.text.trim()}";

                            try {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: phoneNo,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  PhoneLoginVerification.verify =
                                      verificationId;
                                  Get.to(() => OtpVerificationView(
                                        phoneNum: phoneNo,
                                      ));
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
