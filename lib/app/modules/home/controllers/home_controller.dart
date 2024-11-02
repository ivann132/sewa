import 'package:get/get.dart';
import '../../../data/product.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<Product> productMenu = [];
  List<Product> _cart = [];

  List<Product> get cart => _cart;

  set cart(List<Product> value) {
    _cart = value;
  }

  // List<Product> get cart => cart;

  @override
  void onInit() {
    super.onInit();
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
    update();
  }

  Future<void> removeFromCart (Product productitem) async {
    cart.remove(productitem);
    update();
  }
}
