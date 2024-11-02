import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/signup/views/fillingbirthdate_view.dart';

import '../views/userinfo_view.dart';

class UserProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getUserLocation() async {
    String? location;
    String? nama;
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
        location = userDoc['location'];
        nama = userDoc['name'];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> checkProfileCompletion(firstname, lastname) async {
    final userId = _auth.currentUser?.uid;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      if (userDoc.data()?['name'] == null) {
        Get.to(() => const UserinfoView());
      }
    } else {
      // Create a new document for the user if it doesn't exist
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': null,
      });
      Get.to(() => const UserinfoView());
    }
  }

  Future<void> saveUserName(String fullname) async {
    final userId = _auth.currentUser?.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': fullname,
    }, SetOptions(merge: true)); // Use merge to avoid overwriting other fields
    // Navigate to the main screen after completion
    Get.offAll(() => FillingbirthdateView());
  }
}