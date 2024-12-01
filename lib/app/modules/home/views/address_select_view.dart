import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddressSelectView extends StatefulWidget {
  const AddressSelectView({super.key});

  @override
  State<AddressSelectView> createState() => _AddressSelectViewState();
}

class _AddressSelectViewState extends State<AddressSelectView> {
  Position? _currentPosition;
  String _locationMessage = "Mencari Lat dan Long...";
  bool _loading = false;

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    setState(() {
      _loading = true;
    });
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
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        _currentPosition = position;
        _locationMessage =
        "Latitude: ${position.latitude}, Longitude:${position.longitude}";
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _locationMessage = 'Gagal mendapatkan lokasi';
      });
    }
  }

  void _openGoogleMaps() {
    if (_currentPosition != null) {
      final url =
          'https://www.google.com/maps?q=${_currentPosition!.latitude},${_currentPosition!.longitude}';
      _launchURL(url);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Titik Koordinat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_locationMessage),
            const SizedBox(height: 20),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Cari Lokasi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openGoogleMaps,
              child: const Text('Buka Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
