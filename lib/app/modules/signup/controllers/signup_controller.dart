import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/signup/views/EmailVerified_view.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  RxBool isEmailVerified = false.obs;
  RxBool canResendEmail = true.obs;

  @override
  void onInit() {
    super.onInit();
    user = auth.currentUser;
    isEmailVerified.value = user?.emailVerified ?? false;

    if (!isEmailVerified.value) {
      sendVerificationEmail();
    }

    checkEmailVerifiedPeriodically();
  }

  Future<void> sendVerificationEmail() async {
    try {
      await user?.sendEmailVerification();
      canResendEmail.value = false;
      await Future.delayed(const Duration(seconds: 5));
      canResendEmail.value = true;
    } catch (e) {
      print("Error sending email verification: $e");
    }
  }

  Future<void> checkEmailVerified() async {
    await user?.reload();
    user = auth.currentUser;
    isEmailVerified.value = user?.emailVerified ?? false;
  }

  Future<void> checkEmailVerifiedPeriodically() async {
    while (!isEmailVerified.value) {
      await Future.delayed(const Duration(seconds: 5));
      await checkEmailVerified();
      if (isEmailVerified.value) {
        Get.offAll(() => const EmailVerifiedView());
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}