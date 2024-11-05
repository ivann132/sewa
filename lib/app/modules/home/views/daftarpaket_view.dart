import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/home_controller.dart';
import 'package:sewa/app/modules/home/controllers/product_service.dart';
import 'package:sewa/app/modules/home/views/cart_view.dart';
import 'package:sewa/app/modules/home/views/notif_view.dart';
import 'package:sewa/app/modules/home/views/product_tile.dart';

import '../../../data/product.dart';

class DaftarpaketView extends StatefulWidget {
  DaftarpaketView({super.key});

  @override
  State<DaftarpaketView> createState() => _DaftarpaketViewState();
}

class _DaftarpaketViewState extends State<DaftarpaketView> {
  final homecontrol = Get.put(HomeController());

  final prodser = Get.put(ProductService());

  get category => 'Daftar Paket';

  Future<void> _loadProducts() async {
    List<Product> products = category == null
        ? await  prodser.fetchProducts() : await prodser.fetchProductsByCategory(category);
    setState(() {
      homecontrol.productMenu = products;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Kubu Barat Camp', style: TextStyle(fontSize: 18),),
        actions: [
          IconButton(onPressed: () {Get.to(CartView());}, icon: Icon(Icons.shopping_cart)),
          IconButton(onPressed: () {Get.to(NotifView());}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: homecontrol.productMenu.length,
              itemBuilder: (context, index) => ProductTile(product: homecontrol.productMenu[index]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,),
            ),
          ),
        ],
      ),
    );
  }
}
