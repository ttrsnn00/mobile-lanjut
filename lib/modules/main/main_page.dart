import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges; // Import package badges

import '../home/home_page.dart';
import '../cart/cart_page.dart';
import '../profile/profile_page.dart';
import 'main_controller.dart';
import '../cart/cart_controller.dart'; // Import CartController untuk mendapatkan total items

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    // Panggil CartController agar kita bisa mengakses totalItems
    final cartController = Get.put(CartController());

    final pages = [const HomePage(), const CartPage(), const ProfilePage()];

    return Obx(
      () => Scaffold(
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          selectedItemColor: const Color(0xFF2E7D32),
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              // Bungkus ikon keranjang dengan Badge
              icon: Obx(
                () => badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -10, end: -12),
                  showBadge:
                      cartController.totalItems > 0, // Muncul jika ada isi
                  badgeContent: Text(
                    cartController.totalItems.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                    padding: EdgeInsets.all(5),
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
              label: 'Keranjang',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
