import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/signup/controllers/userprofile_service.dart';
import 'package:sewa/app/modules/signup/views/userinfo_view.dart';

class PassCreatedView extends StatelessWidget {
  PassCreatedView({super.key});
  final profil = Get.put(UserProfileService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Password created',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your password has been created',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize:
                  const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.offAll(UserinfoView());
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
