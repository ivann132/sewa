import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifView extends StatelessWidget {
  const NotifView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.transparent,foregroundColor: Colors.grey[800],
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifikasi", style: TextStyle(fontSize: 14, color: Colors.black),),
          ],),
        actions: [
          IconButton(onPressed: () {Get.back();}, icon: const Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}
