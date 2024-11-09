import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/data/product.dart';
import 'package:sewa/app/modules/home/views/cart_view.dart';
import 'package:sewa/app/modules/home/views/daftarpaket_view.dart';
import 'package:sewa/app/modules/home/views/history_view.dart';
import 'package:sewa/app/modules/home/views/notif_view.dart';
import 'package:sewa/app/modules/home/views/product_tile.dart';
import 'package:sewa/app/modules/home/views/profile_view.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/product_service.dart';
import 'search_page.dart';
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
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.to(CartView());
                  },
              ),
              Obx(() {
                return homecontrol.itemCount.value > 0 // Only show count if items are in the cart
                    ? Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${homecontrol.itemCount.value}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )
                    : Container();
              }),
            ],
          ),
          IconButton(onPressed: () => Get.to(const NotifView()), icon: const Icon(Icons.notifications))
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(onChanged: (value) => value,
                onTap: () => Get.to(SearchPage()),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),),
                  hintText: "Search here...",
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Get.to(() => SearchPage());
                    },
                  ),
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

                  TextButton.icon(onPressed: () {}, icon: const Icon(Icons.filter_alt, color: Colors.black), label: const Text('Filter', style: TextStyle(color: Colors.black),),)

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
                  TextButton.icon(onPressed: () {Get.back();}, label: const Text('Home', style: TextStyle(color: Colors.black)), icon: const Icon(Icons.home, color: Colors.black),),
                  TextButton.icon(onPressed: () {Get.to(PurchaseHistoryScreen());}, label: const Text('History', style: TextStyle(color: Colors.black)), icon: const Icon(Icons.history, color: Colors.black),),
                  TextButton.icon(onPressed: () {Get.to(const ProfileView());}, label: const Text('Account', style: TextStyle(color: Colors.black)), icon: const Icon(Icons.person_outline, color: Colors.black),)
                ],
              ),
            )
          ]
      ),
    );
  }
}
