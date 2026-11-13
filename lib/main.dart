import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';

import 'package:shiroine/modules/cart/cart_controller.dart';

void main() async {
  // Inisialisasi CartController secara global

  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi GetStorage
  await GetStorage.init();
  Get.put(CartController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Tanaman',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      initialRoute: AppPages.getInitialRoute(),
      getPages: AppPages.routes,
    );
  }
}
