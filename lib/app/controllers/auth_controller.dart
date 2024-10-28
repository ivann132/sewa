import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/signup/views/Verifyemail_view.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

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
      Get.offAllNamed(Routes.HOME);
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

  Future<void> EmailVerify(String email) async {
    try {
      UserCredential usercredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: 'password',
      );
      await usercredential.user!.sendEmailVerification();
      Get.snackbar('Success', 'Email verifikasi telah dikirim. Silakan periksa email Anda.');
      Get.offAll(VerifyEmailView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Error:$e');
    }
  }
}
