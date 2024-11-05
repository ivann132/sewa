import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/views/cart_view.dart';
import 'package:sewa/app/modules/home/views/editprofile_view.dart';
import 'package:sewa/app/modules/home/views/notif_view.dart';

import '../../../controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key,});

  @override
  Widget build(BuildContext context) {
    final authControl = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Profil"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(authControl.auth.currentUser?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  // backgroundImage: NetworkImage(userData['photoUrl']),
                ),
                const SizedBox(height: 20,),
                Text(userData['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40,),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(EditprofileView());
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Ganti Profil'),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(CartView());
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('My Cart'),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(NotifView());
                  },
                  icon: const Icon(Icons.notifications),
                  label: const Text('Notification'),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    authControl.logout();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
