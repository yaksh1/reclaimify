import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, PhoneAuthProvider;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/firebase_options.dart';
import 'package:reclaimify/services/auth/auth_exceptions.dart';
import 'package:reclaimify/services/auth/auth_provider.dart';
import 'package:reclaimify/services/auth/auth_user.dart';

class FirebaseAuthProvider implements AuthProvider {
  //! <---- variables -----> //
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final auth = FirebaseAuth.instance;
  User? userForGoogle;
  var verificationId = ''.obs;
  //! <---- create user -----> //
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    // implement createUser
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //$ save user to database
      await saveUSerEmailPass(email, username);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == "channel-error") {
        throw EmptyFieldAuthException();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  //! <---- get current user -----> //
  @override
  // implement currentUser
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  //! <---- get current user -----> //
  @override
  Future<AuthUser?> logIn(
      {required String email, required String password}) async {
    // implement logIn
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == "wrong-password") {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  //! <---- logout -----> //
  @override
  Future<void> logOut() async {
    // implement logOut
    final currentUser = FirebaseAuth.instance.currentUser;
    if (googleSignIn.currentUser != null) {
      Logger().d("Sign out using google");
      await googleSignIn.signOut();
    }
    if (currentUser != null) {
      Logger().d("Sign out using firebaseAuth");
      await FirebaseAuth.instance.signOut();
    }
    try {
      await googleSignIn.disconnect();
    } catch (e) {
      Logger().d("failed to disconnect on signout");
    }
  }

  //! <---- send email verification -----> //
  @override
  Future<void> sendEmailVerification() async {
    // implement sendEmailVerification
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  //! <---- initialize app -----> //
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  //! <---- phone auth -----> //

  @override
  Future<void> phoneAuthentication(String phoneNo) async {
    Logger().d(phoneNo);
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          MySnackBar().mySnackBar(
              content: "Please enter a valid phone number",
              header: "Invalid phone number format");
        } else {
          throw GenericAuthException();
        }
      },
    );
  }

  @override
  Future<bool> verifyOtp(var otp) async {
    Logger().d("OTP:$otp");
    var credentials = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp!));
    return credentials.user != null ? true : false;
  }

  //! <---- google sign in -----> //
  @override
  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // if user canceled the operation
    if (googleUser == null) {
      return null;
    }

    // Obtain the auth details from the request

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      //$ save user in data collection
      await saveUser(googleUser);

      userForGoogle = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Get.showSnackbar(const GetSnackBar(
          message:
              "You already have an account with this email. Use other login method.",
          duration: Duration(seconds: 3),
        ));
      } else if (e.code == 'invalid-credential') {
        Get.showSnackbar(const GetSnackBar(
          message: "Invalid Credential!",
          duration: Duration(seconds: 3),
        ));
      } else if (e.code == 'wrong-password') {
        Get.showSnackbar(const GetSnackBar(
          message: "Wrong password!",
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: "Unknown Error. Try again later",
        duration: Duration(seconds: 3),
      ));
    }
    return userForGoogle;
  }

  //! <---- save google user data -----> //
  saveUser(GoogleSignInAccount? googleUser) {
    FirebaseFirestore.instance.collection("users").doc(googleUser!.email).set({
      "email": googleUser.email,
      "name": googleUser.displayName,
      "profilePic": googleUser.photoUrl
    });

    Logger().d("Saved user data");
  }

  //! <---- save email pass data -----> //
  saveUSerEmailPass(String email, String username) {
    FirebaseFirestore.instance.collection("users").doc(email).set({
      'email': email,
      'name': username,
    });
  }
}
