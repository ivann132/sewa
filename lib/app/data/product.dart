import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String namaproduct;
  String imageUrl;
  int price;
  String category;
  int quantity;
  bool isSelected;

  Product({
    required this.namaproduct,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.quantity = 1,
    this.isSelected = false,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      namaproduct: data.containsKey('namaproduct') ? data['namaproduct'] : '',
      imageUrl: data.containsKey('imageUrl') ? data['imageUrl'] : '',
      price: data.containsKey('price') ? data['price'] : 0, // default price to 0 if not found
      category: data.containsKey('category') ? data['category'] : '',
      quantity: data.containsKey('quantity') ? data['quantity'] : 1,
      isSelected: data.containsKey('isSelected') ? data['isSelected'] : false, // default to false if missing
    );
  }

}