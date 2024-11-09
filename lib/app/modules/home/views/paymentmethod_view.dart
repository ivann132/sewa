import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/checkout_controller.dart';

class PaymentMethodPage extends StatelessWidget {
  final controller = Get.find<CheckoutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Masukkan nomor e-wallet',
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              keyboardType: TextInputType.phone,
              onChanged: controller.setWalletNumber,
            ),
            SizedBox(height: 16),
            Text('Pilih metode pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Obx(() => Column(
              children: [
                _buildPaymentOption("Dana"),
                _buildPaymentOption("Gopay"),
                _buildPaymentOption("Shoopepay"),
                _buildPaymentOption("Ovo"),
                _buildPaymentOption("Qris"),
              ],
            )),
            Divider(),
            _buildOrderSummary(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.completePayment,
              child: Text("Select payment method"),
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
    final total = controller.calculateTotal();
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total"),
              Text("Rp. $total"),
            ],
          ),
        ],
      );
    });
  }
}
