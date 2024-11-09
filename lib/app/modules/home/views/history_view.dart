import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/history_controller.dart';


class PurchaseHistoryScreen extends StatelessWidget {
  final PurchaseHistoryController purchaseHistoryController =
  Get.put(PurchaseHistoryController());

  PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase History'),
      ),
      body: Obx(() {
        if (purchaseHistoryController.purchaseHistory.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: purchaseHistoryController.purchaseHistory.length,
            itemBuilder: (context, index) {
              var purchase = purchaseHistoryController.purchaseHistory[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Total: Rp ${purchase['totalAmount']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment Method: ${purchase['paymentMethod']}'),
                      Text('Wallet Number: ${purchase['walletNumber']}'),
                      Text('Date: ${purchase['timestamp'].toDate()}'),
                      const SizedBox(height: 8),
                      const Text('Items:'),
                      ...purchase['items'].map<Widget>((item) {
                        return Text('${item['name']} x${item['quantity']} - Rp ${item['price']}');
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
