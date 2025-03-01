import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<UserCredential> login(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<UserCredential> signUp(String fullName, String email, String password);
}

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user?.emailVerified == false) {
        await userCredential.user?.sendEmailVerification();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'البريد الإلكتروني غير مفعل. تم إرسال بريد التفعيل.',
        );
      }
      log("User logged in: ${userCredential.user?.email}");
      return userCredential;
    } on FirebaseAuthException catch (err) {
      log("Failed to login: $err");
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      log("Password reset email sent");
    } on FirebaseAuthException catch (err) {
      log("Failed to send password reset email: $err");
      rethrow;
    }
  }

  @override
  Future<UserCredential> signUp(
      String fullName, String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(fullName);
      await userCredential.user?.sendEmailVerification();
      log("Verification email sent! Check your inbox.");
      return userCredential;
    } on FirebaseAuthException catch (err) {
      log("Failed to sign up: $err");
      rethrow;
    }
  }
}
