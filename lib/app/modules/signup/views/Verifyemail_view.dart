import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/signup_controller.dart';


class VerifyEmailView extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verify your email',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Please check your inbox and tap the link in the email we’ve just sent to:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              controller.user?.email ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: controller.canResendEmail.value ? controller.sendVerificationEmail : null,
              child: Text(
                'Resend it',
                style: TextStyle(
                  color: controller.canResendEmail.value ? Colors.brown : Colors.grey,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () { Get.back();},
              child: const Text(
                'I’ll do it later',
                style: TextStyle(color: Colors.brown),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize:
                const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                // Open email app
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: controller.user?.email,
                );
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                }
              },
              child: const Text(
                'Open email',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

