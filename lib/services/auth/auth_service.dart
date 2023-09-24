import 'package:firebase_auth/firebase_auth.dart';
import 'package:reclaimify/services/auth/auth_provider.dart';
import 'package:reclaimify/services/auth/auth_user.dart';
import 'package:reclaimify/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  const AuthService(this.provider);

  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser?> logIn({required String email, required String password}) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> phoneAuthentication(String phoneNo) =>
      provider.phoneAuthentication(phoneNo);

  @override
  Future<bool> verifyOtp(String otp) => provider.verifyOtp(otp);

  @override
  Future<User?> signInWithGoogle() => provider.signInWithGoogle();
  
}
