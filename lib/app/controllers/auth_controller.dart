import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/login/views/login_view.dart';
import '../modules/home/views/homepage_view.dart';
import '../modules/signup/views/Verifyemail_view.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  RxBool isLoggedIn = false.obs;


  Future login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Get.snackbar('Success', 'Login Successful',
          backgroundColor: Colors.green);
      Get.to(HomepageView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Login Failed:$e', backgroundColor: Colors.red);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> emailVerify(String email) async {
    try {
      UserCredential usercredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: 'password',
      );

      await _firestore.collection('users').doc(usercredential.user!.uid).set(
          {
            'uid': usercredential.user!.uid,
            'email' : email,
            'createdAt' : FieldValue.serverTimestamp(),
          });

      await usercredential.user!.sendEmailVerification();
      Get.snackbar('Success', 'Email verifikasi telah dikirim. Silakan periksa email Anda.');
      Get.to(VerifyEmailView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Error:$e');
    }
  }

  Future<void> forgetPass(String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent.");
      Get.to(const LoginView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Error:$e');
    }
  }
}
