import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import '../modules/main/main_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/detail_plant/detail_page.dart';
import '../modules/cart/cart_page.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/login_page.dart';
import '../modules/auth/register_page.dart';
import 'app_routes.dart';

class AppPages {
  // Fungsi ini menentukan rute awal berdasarkan keberadaan token
  static String getInitialRoute() {
    final box = GetStorage();
    String? token = box.read('token');

    // Jika ada token, masuk ke MAIN. Jika tidak, masuk ke LOGIN.
    return token != null ? AppRoutes.MAIN : AppRoutes.LOGIN;
  }

  static final routes = [
    GetPage(
      name: AppRoutes.MAIN,
      page: () => const MainPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.PLANT_DETAIL, page: () => const DetailPage()),
    GetPage(name: AppRoutes.CART, page: () => const CartPage()),
  ];
}
