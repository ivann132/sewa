import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class Splash03 extends StatelessWidget {
  const Splash03({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Memastikan lebar penuh
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        // color: Colors.orange[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'KUBU BARAT CAMP\nOUTDOOR ACTIVITY',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              foregroundImage: AssetImage('assets/images/logo.jpeg'),
              radius: 50,
            ),
            const SizedBox(height: 40),
            const Text(
              'Yuk, jelajahi aplikasi kami sekarang dan temukan peralatan Outdoor yang anda cari. Jangan lupa untuk follow akun sosial media kami untuk mendapatkan update terbaru dan promo menarik.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: Colors.grey, size: 10),
                SizedBox(width: 8),
                Icon(Icons.circle, color: Colors.brown, size: 10),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.LOGIN),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Sign In', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.SIGNUP),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Register', style: TextStyle(fontSize: 18,color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
