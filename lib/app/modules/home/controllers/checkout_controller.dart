import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/home_controller.dart';
import 'package:sewa/app/modules/home/views/homepage_view.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final homecontrol = Get.put(HomeController());

  var selectedDelivery = ''.obs;
  var discount = 0.0.obs;
  var rentalPeriod = 1.obs;
  var deliveryFee = 0.obs;
  var marketplaceFee = 2000.obs;
  var selectedPaymentMethod = ''.obs;
  var walletNumber = ''.obs;

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void setWalletNumber(String number) {
    walletNumber.value = number;
  }

  Future<void> completePayment() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final totalAmount = calculateTotal();

      // Save purchase history to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('purchaseHistory').add({
        'walletNumber': walletNumber.value,
        'paymentMethod': selectedPaymentMethod.value,
        'totalAmount': totalAmount,
        'timestamp': Timestamp.now(),
        'items': homecontrol.cart.map((item) => {
          'name': item.namaproduct,
          'price': item.price,
          'quantity': item.quantity,
        }).toList(),
      });

      // Clear cart after payment
      homecontrol.cart.clear();
      homecontrol.cart.refresh();
      update();
      Get.offAll(const HomepageView());
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() {
    firestore.collection('products').get();
  }

  void selectDelivery(String delivery, int fee) {
    selectedDelivery.value = delivery;
    deliveryFee.value = fee;
  }

  double calculateTotal() {
    double itemTotal = homecontrol.cart.fold(0, (sum, item) => sum + (item.price * item.quantity * rentalPeriod.value as num).toInt());
    return itemTotal + deliveryFee.value + marketplaceFee.value - discount.value;
  }
}
