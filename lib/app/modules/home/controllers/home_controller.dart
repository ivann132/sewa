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
  var cart = <Product>[].obs;
  List<Product> productsearch = [];
  var itemCount = 0.obs;
  final user = FirebaseAuth.instance.currentUser;

  double get calculateTotal => cart.fold(0, (sum, item) => sum + (item.price * item.quantity));


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
    int index = cart.indexWhere((item) => item == productitem);
    if (index >= 0) {
      // Jika produk sudah ada di cart, tambahkan quantity-nya
      cart[index].quantity += 1;
      cart.refresh();  // Memperbarui UI setelah mengubah quantity
    } else {
      // Jika produk belum ada di cart, tambahkan produk ke cart
      productitem.quantity = 1;
      cart.add(productitem);
    }
    itemCount.value = cart.length;
    await saveCartToFirestore();
  }

  Future<void> removeFromCart (Product productitem) async {
    cart.remove(productitem);
    itemCount.value = cart.length;
    cart.refresh();
    update();
    await saveCartToFirestore();
  }

  Future<void> saveCartToFirestore() async {
    final user = this.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'items': cart,
        'totalPrice': calculateTotal,
      });
    }
  }

  void increaseQuantity(int index) {
    cart[index].quantity++;
    cart.refresh();
    update();
    saveCartToFirestore();
  }

  void decreaseQuantity(int index) {
    if (cart[index].quantity > 1) {
      cart[index].quantity--;
      cart.refresh();
      update();
      saveCartToFirestore();
    }
  }
}
