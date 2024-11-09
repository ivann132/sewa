import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sewa/app/modules/home/views/cart_view.dart';
import 'package:sewa/app/modules/home/views/editprofile_view.dart';
import 'package:sewa/app/modules/home/views/notif_view.dart';

import '../../../controllers/auth_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key,});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authcontrol = Get.put(AuthController());
  File? _localImageFile;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        userName = userDoc['name'];
      });

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${user.uid}_profile.jpg';
      setState(() {
        _localImageFile = File(imagePath);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _localImageFile != null ? FileImage(_localImageFile!) : null,
              child: _localImageFile == null ? const Icon(Icons.account_circle, size: 50) : null,
            ),
            const SizedBox(height: 20,),
            Text(userName ?? "Loading...", style: const TextStyle(fontSize: 24),),
            const SizedBox(height: 40,),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditprofileView()),);
                },
              title: const Text('Ganti Profil'),
              leading: const Icon(Icons.person),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartView()),);
              },
              title: const Text('My Cart'),
              leading: const Icon(Icons.shopping_cart),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotifView()),);
              },
              title: const Text('Notification'),
              leading: const Icon(Icons.notifications),
            ),
            ListTile(
              onTap: () {
                authcontrol.logout();
              },
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
