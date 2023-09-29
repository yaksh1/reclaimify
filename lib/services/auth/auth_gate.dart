import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reclaimify/views/landing%20page/landing_page.dart';
import 'package:reclaimify/views/login/login_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return LoginView();
            }
            return LandingPage();
          } else {
            return Scaffold(
              body: Center(

              child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
