import 'package:firebase_auth/firebase_auth.dart';
import 'package:reclaimify/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  User? getCurrentUser();
  Future<String> getName();
  Future<String> getPhone({required String uid});

  Future<AuthUser> createUser(
      {required String email,
      required String password,
      required String username});

  Future<void> logOut();
  Future<void> sendEmailVerification();

  Future<User?> signInWithGoogle();
  Future passwordReset({required String email});
  Future changePassword();
}
