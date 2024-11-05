import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/home_controller.dart';
import '../../../data/product.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final homecontrol = Get.put(HomeController());

  Future<void> removeFromCartcar (Product product) async {
    homecontrol.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
          appBar: AppBar(elevation: 0,
            title: Text("cart"),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Expanded(
                child: GetBuilder<HomeController>(
                  builder: (controller) =>
                    ListView.builder(itemCount: homecontrol.cart.length,itemBuilder: (context, index) {
                      final Product product = homecontrol.cart[index];
                      final String productName = product.namaproduct;
                      final String productPrice = product.price;

                      return Container(
                        decoration: BoxDecoration(color: Colors.grey[500], borderRadius: BorderRadius.circular(8)),margin: EdgeInsets.only(left: 20,top: 20, right: 20),
                        child: ListTile(

                          title: Text(productName, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
                          subtitle: Text(productPrice,style: TextStyle(color: Colors.grey[800]),),
                          trailing: IconButton(onPressed: () => removeFromCartcar(product), icon: Icon(Icons.delete)),
                        ),
                      );

                    })

                ),
              ),

              ElevatedButton(
                onPressed: () async {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize:
                  const Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        );
  }
}
