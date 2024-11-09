import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/home_controller.dart';
import 'package:sewa/app/modules/home/views/checkout_view.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final homecontrol = Get.put(HomeController());

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
                    ListView.builder(itemCount: controller.cart.length,itemBuilder: (context, index) {
                      final product = controller.cart[index];
                      final String productName = product.namaproduct;
                      final int productPrice = product.price;

                      return Container(
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),margin: EdgeInsets.only(left: 20,top: 20, right: 20), padding: EdgeInsets.all(8.0),
                        child: ListTile(leading: Image.asset(product.imageUrl),
                          title: Text(productName, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
                          subtitle: Text('Rp $productPrice /24 Jam',style: TextStyle(color: Colors.grey[800]),),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  controller.decreaseQuantity(index);
                                },
                              ),
                              Text(product.quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  controller.increaseQuantity(index);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  controller.removeFromCart(product);
                                },
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                      );

                    })

                ),
              ),

              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Order Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("Rp. ${homecontrol.totalPrice}"),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        Get.to(CheckoutPage());
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
              ),


            ],
          ),
        );
  }
}
