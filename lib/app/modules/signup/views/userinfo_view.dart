import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/home_controller.dart';
import 'package:sewa/app/modules/signup/controllers/userprofile_service.dart';
import 'package:sewa/app/modules/signup/views/fillingbirthdate_view.dart';

class UserinfoView extends StatefulWidget {
  const UserinfoView({super.key});

  @override
  State<UserinfoView> createState() => _UserinfoViewState();
}

class _UserinfoViewState extends State<UserinfoView> {
  final TextEditingController firstnamecontrol = TextEditingController();
  final TextEditingController lastnamecontrol = TextEditingController();
  final UserProfileService profileService = UserProfileService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> saveFullName() async {
    final String firstName = firstnamecontrol.text.trim();
    final String lastName = lastnamecontrol.text.trim();
    final String fullName = "$firstName $lastName"; // Merging first and last name
    final userId = auth.currentUser?.uid;

    // Save to Firestore under 'name' field
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({
      'name': fullName,
    }, SetOptions(merge: true)); // Using merge to avoid overwriting existing fields
    Get.offAll(FillingbirthdateView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Lastly, tell us more about yourself',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text('Please enter your legal name. This information will be used to verify your account.'),
              // Email or Phone Input
              TextFormField(
                controller: firstnamecontrol,
                decoration: InputDecoration(
                  labelText: 'First name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: lastnamecontrol,
                decoration: InputDecoration(
                  labelText: 'Last name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign in Button
              ElevatedButton(
                onPressed: () async {
                  saveFullName();
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
