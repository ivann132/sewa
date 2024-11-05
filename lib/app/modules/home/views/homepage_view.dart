import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/data/product.dart';
import 'package:sewa/app/modules/home/views/daftarpaket_view.dart';
import 'package:sewa/app/modules/home/views/history_view.dart';
import 'package:sewa/app/modules/home/views/notif_view.dart';
import 'package:sewa/app/modules/home/views/product_tile.dart';
import 'package:sewa/app/modules/home/views/profile_view.dart';

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

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts({String? category}) async {
    List<Product> products = category == null
        ? await _productService.fetchProducts()
        : await _productService.fetchProductsByCategory(category);
    setState(() {
      homecontrol.productMenu = products;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    _loadProducts(category: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:AppBar(
        backgroundColor: Colors.transparent,foregroundColor: Colors.grey[800],
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Kubu Barat Camp", style: TextStyle(fontSize: 14, color: Colors.black),),
          ],),
        actions: [
          IconButton(onPressed: () => Get.to(CartView()), icon: const Icon(Icons.shopping_cart)),
          IconButton(onPressed: () => Get.to(const NotifView()), icon: const Icon(Icons.notifications))
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryIcon(name: "All", icon: Icons.speaker, onTap: () => _loadProducts()),
                  CategoryIcon(name: "Baju Camp", icon: Icons.perm_identity, onTap: () => _onCategorySelected("Baju Camp")),
                  CategoryIcon(name: "Audio", icon: Icons.cabin, onTap: () => _onCategorySelected("Audio")),
                  CategoryIcon(name: "Daftar Paket", icon: Icons.list_alt, onTap: () => Get.to(DaftarpaketView())),
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

            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(onPressed: () {Get.back();}, label: const Text('Home'), icon: Icon(Icons.home),),
                  TextButton.icon(onPressed: () {Get.to(const HistoryView());}, label: const Text('History'), icon: Icon(Icons.history),),
                  TextButton.icon(onPressed: () {Get.to(const ProfileView());}, label: const Text('Account'), icon: Icon(Icons.person_outline),)
                ],
              ),
            )
          ]
      ),
    );
  }
}
