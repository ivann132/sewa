import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PurchaseHistoryController extends GetxController {
  var purchaseHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchPurchaseHistory();
  }

  // Fetch purchase history from Firestore
  void _fetchPurchaseHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('purchaseHistory')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        purchaseHistory.value = snapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }
}
