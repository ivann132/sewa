import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';

class forgetPasswordView extends StatefulWidget {
  const forgetPasswordView({super.key});

  @override
  State<forgetPasswordView> createState() => _forgetPasswordViewState();
}

class _forgetPasswordViewState extends State<forgetPasswordView> {
  final TextEditingController emailControl = TextEditingController();
  final authControl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forget Password?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Email or Phone Input
              TextFormField(
                controller: emailControl,
                decoration: InputDecoration(
                  labelText: 'Your email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign in Button
              ElevatedButton(
                onPressed: () async {
                  try {
                    await authControl.forgetPass(
                        emailControl.text);
                  } catch (error) {
                    print("Error during registration: $error");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize:
                  const Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
