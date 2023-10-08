import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:reclaimify/firebase_options.dart';
import 'package:reclaimify/services/auth/auth_gate.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/routes.dart';
import 'package:reclaimify/views/authentication/forget_password/forgot_password_otp/forgot_password_otp.dart';
import 'package:reclaimify/views/authentication/login/login_view.dart';
import 'package:reclaimify/views/authentication/register/register_view.dart';
import 'package:reclaimify/views/authentication/verify%20email/verify_email_view.dart';
import 'package:reclaimify/views/landing%20page/landing_page.dart';
import 'package:reclaimify/views/post%20list%20view/posts_list.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ScreenUtilInit(
      designSize: Size(360, 780),
      builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              fontFamily: 'Inter'),
          defaultTransition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
          // home: isViewed!=0? OnBoardingView() : const HomePage(),
          home: const PostsView(),
          // home: const Gallery(),
          routes: {
            registerRoute: (context) => const Register(),
            loginRoute: (context) => const LoginView(),
            verifyEmailRoute: (context) => const VerifyEmailView(),
            landingPageRoute:(context) => const LandingPage(),
            otpScreenRoute:(context)=>const ForgotPasswordOtp(),
          }
          ), 
    ),
  );
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future:AuthService.firebase().initialize(),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               // return OnBoardingView();
//               final user = AuthService.firebase().currentUser;
//               if (user != null) {
//                 if (user.isEmailVerified) {
//                   return const LandingPage();
//                 } else {
//                   return const VerifyEmailView();
//                 }
//               } else {
//                 return const LoginView();
//               }
//             default:
//               // write loading code here
//               return const CircularProgressIndicator();
//           }
//         });
//   }
// }
