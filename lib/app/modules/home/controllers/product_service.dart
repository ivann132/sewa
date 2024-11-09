import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts() async {
    try {
      final querySnapshot = await _firestore.collection('product').get();
      return querySnapshot.docs.map((doc) => Product(
        namaproduct: doc['namaproduct'],
        imageUrl: doc['imageUrl'],
        price: doc['price'],
        category: doc['category'],
      )).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('product')
          .where('category', isEqualTo: category)
          .get();

      return snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
    } catch (e) {
      print("Error fetching products by category: $e");
      return [];
    }
  }


}