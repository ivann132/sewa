import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewa/app/modules/home/views/paymentmethod_view.dart';
import '../controllers/checkout_controller.dart';

class CheckoutPage extends StatelessWidget {
  final controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkouts'),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display list of products
              Text("Delivery to: Salatiga City, Central Java"),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return ListTile(
                    leading: Image.network(item['image_url']),
                    title: Text(item['name']),
                    subtitle: Text("Rp. ${item['price']}"),
                    trailing: Text("1 quantity"),
                  );
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Apply a discount',
                  suffixIcon: Icon(Icons.discount),
                ),
                onChanged: (value) {
                  // Handle discount code logic
                  controller.discount.value = value.isNotEmpty ? double.parse(value) : 0.0;
                },
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () => _showDeliveryOptions(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.selectedDelivery.value.isEmpty ? "Select the delivery" : controller.selectedDelivery.value,
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Apply a rental period (days)'),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => controller.rentalPeriod.value--,
                        icon: Icon(Icons.remove),
                      ),
                      Obx(() => Text(controller.rentalPeriod.value.toString())),
                      IconButton(
                        onPressed: () => controller.rentalPeriod.value++,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              // Order Summary
              Text(
                "Order Summary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              _buildOrderSummary(),
              SizedBox(height: 16),
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
              title: Text("Mobil"),
              trailing: Text("Rp 8.000"),
              onTap: () {
                controller.selectDelivery("Mobil", 8000);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Motor"),
              trailing: Text("Rp 3.000"),
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
          _buildSummaryRow("Total price", currencyFormatter.format(controller.items.fold(0, (sum, item) => sum + (item['price'] as num).toInt()))),
          _buildSummaryRow("Delivery", currencyFormatter.format(controller.deliveryFee.value)),
          _buildSummaryRow("Marketplace fee", currencyFormatter.format(controller.marketplaceFee.value)),
          Divider(),
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
