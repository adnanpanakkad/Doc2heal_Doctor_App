import 'dart:developer';
import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   User? doctor = FirebaseAuth.instance.currentUser;

   Future<String?> userEmailSignup(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      log('Account created');

      return userCredential.user?.uid;
    } catch (e) {
      log('User Email Signup Error: $e');
      throw Exception('User Email Signup Error: $e');
    }
  }

   Future<String?> userEmailLogin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log('User logged in');
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      doctor != null ? const BottombarScreens() : const LoginScreen();
      log('User Email Login Error: ${e.message}');
      throw Exception('User Email Login Error: ${e.message}');
    } catch (e) {
      log('User Email Login Error: $e');
      throw Exception('User Email Login Error: $e');
    }
  }
}
