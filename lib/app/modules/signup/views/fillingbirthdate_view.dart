import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/signup/views/filledbod_view.dart';

class FillingbirthdateView extends StatefulWidget {
  const FillingbirthdateView({super.key});

  @override
  State<FillingbirthdateView> createState() => _FillingbirthdateViewState();
}

class _FillingbirthdateViewState extends State<FillingbirthdateView> {
  DateTime? selectedDate;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1), // Default date
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> saveUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;
    if (selectedDate == null) return; // Ensure a date is selected

    // Save the date of birth and marketing consent to Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'dateOfBirth': selectedDate, // Firestore will automatically store this as a timestamp
    }, SetOptions(merge: true));

    Get.offAll(FilledbodView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is your date of birth?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("We need your DOB to verify your account"),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Date of birth",
                    hintText: "MM/DD/YYYY",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: selectedDate == null
                        ? ''
                        : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
                  ),
                ),
              ),
            ),

            const Spacer(),
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
              onPressed: selectedDate != null
                  ? () {
                // Handle account creation logic
                saveUserData();
              }
                  : null,
              child: const Text(
                'Create account',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
