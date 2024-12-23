import 'package:get/get.dart';
import 'package:sewa/app/modules/splash/bindings/splash_binding.dart';
import 'package:sewa/app/modules/splash/views/splash02.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/homepage_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/views/splash03.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomepageView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.SIGNUP,
        page: () => SignupView(),
        binding: SignupBinding()
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding()
    ),
    GetPage(
        name: _Paths.SPLASH,
        page: () => SplashView(),
        binding: SplashBinding()
    ),
    GetPage(
        name: _Paths.SPLASH02,
        page: () => Splash02(),
        binding: SplashBinding()
    ),
    GetPage(
        name: _Paths.SPLASH03,
        page: () => Splash03(),
        binding: SplashBinding()
    ),
  ];
}
