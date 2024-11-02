import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/data/product.dart';
import 'package:sewa/app/modules/home/views/product_tile.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/product_service.dart';
import 'cart_view.dart';
import 'category_icon.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  late Product product;
  final authControl = Get.find<AuthController>();
  final ProductService _productService = ProductService();
  final homecontrol = Get.put(HomeController());
  String? selectedCategory;
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _productService.fetchProducts();
    setState(() {
      homecontrol.productMenu = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:AppBar(backgroundColor: Colors.transparent,foregroundColor: Colors.grey[800],
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Kubu Barat Camp", style: TextStyle(fontSize: 14, color: Colors.black),),
          ],),
        actions: [
          IconButton(onPressed: () => Get.to(CartView()), icon: const Icon(Icons.shopping_cart)),
          IconButton(onPressed: () => authControl.logout(), icon: const Icon(Icons.notifications))
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),),
                  hintText: "Search here...",
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true,),
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryIcon(name: "Baju Camp", icon: Icons.perm_identity),
                  CategoryIcon(name: "Tenda", icon: Icons.cabin),
                  CategoryIcon(name: "Audio", icon: Icons.speaker),
                  CategoryIcon(name: "Daftar Paket", icon: Icons.list_alt),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Products",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 18,
                    ),
                  ),

                  TextButton.icon(onPressed: () {}, icon: const Icon(Icons.filter_alt), label: const Text('Filter'),)

              ],)


            ),

            const SizedBox(height: 10),

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
          ]
      ),
    );
  }
}
