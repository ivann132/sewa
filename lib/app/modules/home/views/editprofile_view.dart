import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditprofileView extends StatefulWidget {
  const EditprofileView({super.key});

  @override
  State<EditprofileView> createState() => _EditprofileViewState();
}

class _EditprofileViewState extends State<EditprofileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController namacontrol = TextEditingController();
  final TextEditingController nomercontrol = TextEditingController();
  File? _localImageFile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      // Load name from Firestore
      setState(() {
        namacontrol.text = userDoc['name'];
        nomercontrol.text = userDoc['phone'] ?? '';
      });

      // Load image from local storage if available
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${user.uid}_profile.jpg';
      setState(() {
        _localImageFile = File(imagePath);
      });
      if (await _localImageFile!.exists()) {
        print("Profile image loaded from path: $imagePath");
      } else {
        print("No profile image found at path: $imagePath");
        _localImageFile = null;  // Set to null if the image doesn't exist
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final localImagePath = '${directory.path}/${_auth.currentUser!.uid}_profile.jpg';

      // Copy the image to local storage and update the file path
      final savedImage = await File(image.path).copy(localImagePath);
      setState(() {
        _localImageFile = savedImage;
      });

      print("New profile image saved at path: $localImagePath");
    }
  }

  Future<void> _saveProfileChanges() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': namacontrol.text.trim(),
        'phone': nomercontrol.text.trim(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfileChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _localImageFile != null ? FileImage(_localImageFile!) : null,
                child: _localImageFile == null ? const Icon(Icons.camera_alt, size: 50) : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namacontrol,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nomercontrol,
              decoration: const InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
