import 'package:flutter/material.dart';

class UserinfoView extends StatefulWidget {
  const UserinfoView({super.key});

  @override
  State<UserinfoView> createState() => _UserinfoViewState();
}

class _UserinfoViewState extends State<UserinfoView> {
  final TextEditingController firstnamecontrol = TextEditingController();
  final TextEditingController lastnamecontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                //   data ke Firestore
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
