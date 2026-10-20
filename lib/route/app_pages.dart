import 'package:get/get.dart';

import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/dashboard_page.dart';

class AppPages {
  static const initial = '/login';

  static final routes = [
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/register', page: () => const RegisterPage()),
    GetPage(name: '/dashboard', page: () => const DashboardPage()),
  ];
}
