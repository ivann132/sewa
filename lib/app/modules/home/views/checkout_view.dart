import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewa/app/modules/home/views/paymentmethod_view.dart';
import '../controllers/checkout_controller.dart';

class CheckoutPage extends StatelessWidget {
  final controller = Get.put(CheckoutController());

  CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkouts'),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display list of products
              const Text("Delivery to: Salatiga City, Central Java"),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.homecontrol.cart.length,
                itemBuilder: (context, index) {
                  final item = controller.homecontrol.cart[index];
                  return ListTile(
                    leading: Image.asset(item.imageUrl),
                    title: Text(item.namaproduct),
                    subtitle: Text("Rp. ${item.price}"),
                    trailing: Text("${item.quantity} quantity"),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Apply a discount',
                  suffixIcon: Icon(Icons.discount),
                ),
                onChanged: (value) {
                  // Handle discount code logic
                  controller.discount.value = value.isNotEmpty ? double.parse(value) : 0.0;
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _showDeliveryOptions(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.selectedDelivery.value.isEmpty ? "Select the delivery" : controller.selectedDelivery.value,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Apply a rental period (days)'),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => controller.rentalPeriod.value--,
                        icon: const Icon(Icons.remove),
                      ),
                      Obx(() => Text(controller.rentalPeriod.value.toString())),
                      IconButton(
                        onPressed: () => controller.rentalPeriod.value++,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              // Order Summary
              const Text(
                "Order Summary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildOrderSummary(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  Get.to(PaymentMethodPage());
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
                  'Checkout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showDeliveryOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Mobil"),
              trailing: const Text("Rp 8.000"),
              onTap: () {
                controller.selectDelivery("Mobil", 8000);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Motor"),
              trailing: const Text("Rp 3.000"),
              onTap: () {
                controller.selectDelivery("Motor", 3000);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildOrderSummary() {
    final currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0);
    return Obx(() {
      final totalPrice = currencyFormatter.format(controller.calculateTotal());
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow("Total order", currencyFormatter.format(controller.homecontrol.cart.fold(0, (sum, item) => sum + (item.price * item.quantity)))),
          _buildSummaryRow("Delivery", currencyFormatter.format(controller.deliveryFee.value)),
          _buildSummaryRow("Marketplace fee", currencyFormatter.format(controller.marketplaceFee.value)),
          const Divider(),
          _buildSummaryRow("Total", totalPrice, isBold: true),
        ],
      );
    });
  }

  Widget _buildSummaryRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
