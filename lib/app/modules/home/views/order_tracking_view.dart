import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/location_controller.dart';

class OrderTrackingPage extends StatelessWidget {
  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
      ),
      body: Obx(() {
        return Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: locationController.currentPosition != null
                    ? LatLng(
                  locationController.currentPosition!.latitude,
                  locationController.currentPosition!.longitude,
                )
                    : LatLng(-7.9797, 112.6304), // Default location
                initialZoom: 14,
              ),
              children: [TileLayer(urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],), MarkerLayer(markers: [const Marker(
                point: LatLng(-7.9811, 112.6266), // Example driver location
                child: Icon(
                  Icons.directions_bike,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
                ...locationController.markers.map(
                      (latLng) => Marker(
                    point: latLng,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),])],
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/driver_avatar.png'),
                      ),
                      title: Text('Cameron Williamson'),
                      subtitle: Text('Delivery Man'),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Time:'),
                        Text('15 mins'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
