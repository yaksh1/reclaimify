import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/routes.dart';
import 'package:reclaimify/views/landing%20page/landing_page.dart';
import 'package:reclaimify/views/login/login_view.dart';
import 'package:reclaimify/views/register/register_view.dart';
import 'package:reclaimify/views/verify%20email/verify_email_view.dart';

void main() async {
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            fontFamily: 'Inter'),
        defaultTransition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 500),
        // home: isViewed!=0? OnBoardingView() : const HomePage(),
        home: const HomePage(),
        // home: const Gallery(),
        routes: {
          registerRoute: (context) => const Register(),
          loginRoute: (context) => const LoginView(),
          verifyEmailRoute: (context) => const VerifyEmailView(),
          landingPageRoute:(context) => const LandingPage(),
        }
        ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // return OnBoardingView();
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const LandingPage();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              // write loading code here
              return const CircularProgressIndicator();
          }
        });
  }
}
