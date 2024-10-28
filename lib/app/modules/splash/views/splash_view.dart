import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';
// import 'splash02.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity, // Memastikan lebar penuh
            height: double.infinity,
            color: Colors.orange[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/logo.jpeg'),
                  radius: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'KUBU BARAT CAMP\nOUTDOOR ACTIVITY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.SPLASH02),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
        ),
    );
  }
}
