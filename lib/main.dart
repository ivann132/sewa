import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/controllers/auth_controller.dart';
import 'app/controllers/notification_handler.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/utils/loading.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  final firebaseMessagingHandler = FirebaseMessagingHandler();
  await firebaseMessagingHandler.initPushNotification();
  await firebaseMessagingHandler.initLocalNotification();
  runApp(MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  final authControl = Get.put(AuthController(), permanent: true);

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authControl.streamAuthStatus,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: "Application",
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.SPLASH,
            getPages: AppPages.routes,
            debugShowCheckedModeBanner: false,
          );
        }
        return const Loading();
      },
    );
  }
}
