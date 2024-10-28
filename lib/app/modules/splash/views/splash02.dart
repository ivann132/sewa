import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/splash/views/splash03.dart';

import '../../../routes/app_pages.dart';

class Splash02 extends StatelessWidget {
  const Splash02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Memastikan lebar penuh
        height: double.infinity,
        padding: const EdgeInsets.all(20),
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
              'Hai Para Petualang!\n\nKami menyediakan berbagai macam peralatan dan kebutuhan Outdoor anda!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: Colors.brown, size: 10),
                SizedBox(width: 8),
                Icon(Icons.circle, color: Colors.grey, size: 10),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(const Splash03()); // Navigate to page 3
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
