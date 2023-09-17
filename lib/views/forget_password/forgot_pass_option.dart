// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/text_strings.dart';
import 'package:reclaimify/views/forget_password/forgot_password_btn_widget.dart';
import 'package:reclaimify/views/forget_password/forgot_password_mail/forgot_password_mail.dart';
import 'package:reclaimify/views/forget_password/forgot_password_phone/forgot_password-phone.dart';

class ForgotPasswordScreen {
  static Future<dynamic> ForgotPasswordBottomSheet(BuildContext context) {
  double width10 = Dimensions.width10;
  double height10 = Dimensions.height10;
  double radius10 = Dimensions.radius10;
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical:height10*3,horizontal: width10*3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: BigText(
                text: forgotPasswordTitle,
                color: AppColors.primaryBlack,
                size: width10*2.5,
              ),
            ),
          
            SmallText(
                text: forgotPasswordSubtitle,
                color: AppColors.primaryBlack,
                size: width10*1.6,
              ),
            
            SizedBox(
              height: height10*2,
            ),
            ForgotPasswordBtnWidget(
              btnIcon: Icons.mail_outline_outlined,
              title: "E-mail",
              subtitle: "Reset via mail verification",
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ForgotPasswordMailOption());
              },
            ),
            SizedBox(
              height: height10,
            ),
            ForgotPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_outlined,
              title: "Phone",
              subtitle: "Reset via phone verification",
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ForgotPasswordPhoneOption());
              },
            ),
          ],
        ),
      ),
    );
  }
}
