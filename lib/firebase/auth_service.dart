import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IAuthService {
  Future<UserCredential> login(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<UserCredential> signUp({
    required String fullName,
    required String email,
    required String password,
  });
}

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .update({
        'emailVerified': true,
      });
      log("User verfication ${userCredential.user?.emailVerified}");
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
  Future<UserCredential> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // Check if email already in use
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'البريد الإلكتروني مستخدم بالفعل.',
        );
      }

      // Create user in Firebase Auth
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user display name
      await userCredential.user?.updateDisplayName(fullName);

      log("Verification email sent! Check your inbox.");
      await userCredential.user?.sendEmailVerification();
      // Save additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': fullName,
        'email': email,
        'isAdmin': false, // Assign role
        'insults': 0, // Initialize counter
        'emailVerified': false,
        'topRank': 0,
        'createdAt': FieldValue.serverTimestamp(), // Track creation time
      });
      log("User data saved in Firestore.");
      // Send email verification
      return userCredential;
    } on FirebaseAuthException catch (err) {
      log("Failed to sign up: $err");
      rethrow;
    } catch (e) {
      log("Error saving user data: $e");
      rethrow;
    }
  }
}
