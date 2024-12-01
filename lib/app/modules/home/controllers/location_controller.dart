import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  Position? currentPosition;
  var locationMessage = ''.obs;
  var currentAddress = ''.obs;
  var markers = <LatLng>[].obs;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      currentPosition = position;
      locationMessage.value = "Latitude: ${position.latitude}, Longitude:${position.longitude}";


      // Update marker
      markers.clear();
      markers.add(LatLng(position.latitude, position.longitude));

      // Get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      currentAddress.value =
      "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}";
    } catch (e) {
      currentAddress.value = 'Failed to fetch location';
      locationMessage.value = 'Failed to fetch latitude and longitude';
    }
  }
}
