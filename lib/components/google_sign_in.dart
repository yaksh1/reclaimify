import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/views/landing%20page/landing_page.dart';

class Google {

  void googleLogIn() async {
    User? googleUser;
    googleUser = await AuthService.firebase().signInWithGoogle();
    if (googleUser != null) {
      MySnackBar().mySnackBar(
          header: "Hello!",
          content: "Logged in as ${googleUser.email}",
          bgColor: Colors.green.shade100,
          borderColor: Colors.green);
      Logger().d("Google signed in as " + googleUser.displayName!);
      Get.offAll(LandingPage());
    }
    ;
  }
}
