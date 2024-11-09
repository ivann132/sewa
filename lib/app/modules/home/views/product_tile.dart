import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/data/product.dart';

import '../controllers/home_controller.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({super.key, required this.product});
  final homecontrol = Get.find<HomeController>();

  Future<void> buttonaddToCart(dynamic context) async {
    homecontrol.addToCart(product);
    showDialog(context: context,barrierDismissible: false, builder: (context) => AlertDialog(backgroundColor: Colors.grey[800], content: const Text("Successfully added to cart", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),actions: [IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.done),color: Colors.white,)],));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            product.imageUrl,
            height: 100,
          ),

          Text(
            product.namaproduct,
            style: const TextStyle(fontSize: 20),
          ),

          Text('Rp.${product.price}/24 Jam'),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              padding: const EdgeInsets.symmetric(vertical: 5),
              minimumSize:
              const Size(double.infinity, 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              buttonaddToCart(context);
              },
            child: const Text(
              'Add to cart',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
