import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/home_controller.dart';

import '../views/paymentsucces_view.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final homecontrol = Get.put(HomeController());

  var selectedDelivery = ''.obs;
  var discount = 0.0.obs;
  var rentalPeriod = 1.obs;
  var items = [].obs;
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
    try {
      // Assume `cart` is your list of items in the cart controller
      List<Map<String, dynamic>> items = homecontrol.cart.map((item) => {
        'namaproduct': item.namaproduct,
        'price': item.price,
        'quantity': item.quantity,
      }).toList();

      // Add the order to Firestore
      await firestore.collection('orderHistory').add({
        'items': items, // All items in the order
        'totalPrice': calculateTotal(), // Ensure this returns the correct sum
        'paymentMethod': selectedPaymentMethod.value, // Bound to UI selection
        'walletNumber': walletNumber.value, // Bound to UI input
        'deliveryMethod': selectDelivery, // Use dynamic selection
        'orderDate': DateTime.now(),
      });

      // Navigate to the success page
      Get.to(PaymentSuccessPage());

    } catch (e) {
      print("Error saving order: $e");
      Get.snackbar("Error", "Could not save the order. Please try again.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() {
    firestore.collection('products').get().then((querySnapshot) {
      items.value = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void selectDelivery(String delivery, int fee) {
    selectedDelivery.value = delivery;
    deliveryFee.value = fee;
  }

  double calculateTotal() {
    double itemTotal = items.fold(0, (sum, item) => sum + item['price']);
    return itemTotal + deliveryFee.value + marketplaceFee.value - discount.value;
  }
}
