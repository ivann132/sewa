import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditprofileView extends StatelessWidget {
  EditprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namacontrol = TextEditingController();
    final TextEditingController alamatcontrol = TextEditingController();
    final TextEditingController nomercontrol = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Get.back();}, icon: const Icon(Icons.arrow_back)),
        elevation: 0,
        title: const Text('Ganti Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 50,),
              SizedBox(height: 20,),
              TextFormField(
                controller: namacontrol,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: alamatcontrol,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: nomercontrol,
                decoration: InputDecoration(
                  labelText: 'nomer telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

            ],),),),
    );
  }
}
