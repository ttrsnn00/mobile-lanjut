import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../core/theme/app_theme.dart';
import '../home/home_page.dart';
import '../cart/cart_page.dart';
import '../profile/profile_page.dart';
import '../cart/cart_controller.dart';
import 'main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    final cartController = Get.put(CartController());

    final pages = [const HomePage(), const CartPage(), const ProfilePage()];

    return Obx(
      () => Scaffold(
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            backgroundColor: AppColors.surface,
            elevation: 0,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Obx(
                  () => badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -8, end: -10),
                    showBadge: cartController.totalItems > 0,
                    badgeContent: Text(
                      cartController.totalItems.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: AppColors.terracotta,
                      padding: EdgeInsets.all(5),
                    ),
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                ),
                activeIcon: Obx(
                  () => badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -8, end: -10),
                    showBadge: cartController.totalItems > 0,
                    badgeContent: Text(
                      cartController.totalItems.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: AppColors.terracotta,
                      padding: EdgeInsets.all(5),
                    ),
                    child: const Icon(Icons.shopping_bag_rounded),
                  ),
                ),
                label: 'Keranjang',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
