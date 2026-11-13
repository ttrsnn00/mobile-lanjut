import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';
import '../profile/order_history_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller secara langsung untuk halaman profil
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green.shade100,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                controller.userName.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.userEmail.value,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              ListTile(
                leading: const Icon(Icons.history, color: Color(0xFF2E7D32)),
                title: const Text('Riwayat Pesanan'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.to(() => const OrderHistoryPage());
                },
              ),
              const Divider(),
              const SizedBox(height: 20),

              // Tombol Logout
              ElevatedButton.icon(
                onPressed: controller.logout,
                icon: const Icon(Icons.logout),
                label: const Text('Keluar Aplikasi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
