import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String namaproduct;
  String imageUrl;
  String price;
  String category;

  Product({
    required this.namaproduct,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      namaproduct: doc['namaproduct'] ?? '',
      imageUrl: doc['imageUrl'] ?? '',
      price: doc['price'].toString(),
      category: doc['category'] ?? '',
    );
  }

}