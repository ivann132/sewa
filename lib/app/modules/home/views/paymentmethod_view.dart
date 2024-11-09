import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewa/app/modules/home/controllers/checkout_controller.dart';

class PaymentMethodPage extends StatelessWidget {
  final controller = Get.find<CheckoutController>();

  PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Masukkan nomor e-wallet',
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              keyboardType: TextInputType.phone,
              onChanged: controller.setWalletNumber,
            ),
            const SizedBox(height: 16),
            const Text('Pilih metode pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Column(
              children: [
                _buildPaymentOption("Dana"),
                _buildPaymentOption("Gopay"),
                _buildPaymentOption("Shoopepay"),
                _buildPaymentOption("Ovo"),
                _buildPaymentOption("Qris"),
              ],
            ),
            const Divider(),
            _buildOrderSummary(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await controller.completePayment();
                _showPaymentSuccessDialog(context);
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
                'Payment',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String paymentMethod) {
    return Obx(() {
      return ListTile(
        title: Text(paymentMethod),
        trailing: Radio<String>(
          value: paymentMethod,
          groupValue: controller.selectedPaymentMethod.value,
          onChanged: (value) {
            if (value != null) controller.selectPaymentMethod(value);
          },
        ),
      );
    });
  }

  Widget _buildOrderSummary() {
    final currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0);
    return Obx(() {
      final totalPrice = currencyFormatter.format(controller.calculateTotal());
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  void _showPaymentSuccessDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text(
                'Congrats! Your payment is successfully processed',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize:
                  const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Home', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }
}
