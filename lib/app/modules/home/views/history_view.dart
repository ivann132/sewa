import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderHistoryPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('orderHistory').orderBy('orderDate', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              var items = order['items'] as List<dynamic>;

              return Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date: ${order['orderDate'].toDate()}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ...items.map((item) {
                        return Text('${item['name']} - Rp. ${item['price']} x ${item['quantity']}');
                      }).toList(),
                      Divider(),
                      Text('Total Price: Rp. ${order['totalPrice']}'),
                      Text('Payment Method: ${order['paymentMethod']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
