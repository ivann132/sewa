import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/product_service.dart';
import '../../../data/product.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _productService = ProductService();
  List<Product> productMenu = [];
  List<Product> cart = [];
  List<Product> productsearch = [];
  var itemCount = 0.obs;
  double get totalPrice => cart.fold(0, (sum, item) => sum + (item.price * item.quantity));
  final user = FirebaseAuth.instance.currentUser;


  @override
  void onInit() {
    super.onInit();
    _loadProducts();
  }

  Future<void> _loadProducts({String? category}) async {
    List<Product> products = category == null
        ? await _productService.fetchProducts()
        : await _productService.fetchProductsByCategory(category);
    productMenu = products;
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      productsearch = productMenu; // Show all if search query is empty
    } else {
      productsearch = productMenu
          .where((product) => product.namaproduct.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> addToCart (Product productitem) async {
    cart.add(productitem);
    itemCount.value = cart.length;
    update();
    await saveCartToFirestore();
  }

  Future<void> removeFromCart (Product productitem) async {
    cart.remove(productitem);
    itemCount.value = cart.length;
    update();
    await saveCartToFirestore();
  }

  Future<void> saveCartToFirestore() async {
    final user = this.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'items': cart,
        'totalPrice': totalPrice,
      });
    }
  }

  void increaseQuantity(int index) {
    cart[index].quantity++;
    totalPrice;
    update();
    saveCartToFirestore();
  }

  void decreaseQuantity(int index) {
    if (cart[index].quantity > 1) {
      cart[index].quantity--;
      totalPrice;
      update();
      saveCartToFirestore();
    }
  }
}
