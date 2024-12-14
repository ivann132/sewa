import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/views/homepage_view.dart';
import 'package:sewa/app/modules/login/views/login_view.dart';

import '../views/no_connection_view.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((connectivityResults) {
      _updateConnectionStatus(connectivityResults.first);
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Get.snackbar('No Internet Connection', 'Please check your connection',icon: const Icon(Icons.wifi_off,color: Colors.red,));
      Get.offAll(() => const NoConnectionView());
    } else {
      if (Get.currentRoute == '/NoConnectionView') { Get.offAll(() => const HomepageView()); }
    }
  }
}