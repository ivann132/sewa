import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/location_controller.dart';
import 'order_tracking_view.dart';

class SelectLocationPage extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());

  SelectLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: locationController.currentPosition != null
                    ? LatLng(
                  locationController.currentPosition!.latitude,
                  locationController.currentPosition!.longitude,
                )
                    : const LatLng(-7.9797, 112.6304), // Default to Malang
                initialZoom: 15,
              ),
              children: [
                TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.sewa',),
                Obx( () => MarkerLayer(
                  markers: locationController.markers.map(
                        (latLng) {
                      return Marker(
                        point: latLng,
                        child: const Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.red,
                        ),
                      );
                    },
                  ).toList(),),),],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      locationController.currentAddress.value.isEmpty
                          ? "Fetching address..."
                          : locationController.currentAddress.value,
                      style: const TextStyle(fontSize: 16),
                    )),
                    Obx(() => Text(
                      locationController.locationMessage.value.isEmpty
                          ? "Fetching latitude and longitude" :
                      locationController.locationMessage.value,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: locationController.getCurrentLocation,
                          child: const Text('Use Current Location'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to tracking page
                            Get.to(() => OrderTrackingPage());
                          },
                          child: const Text('Save Address'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
