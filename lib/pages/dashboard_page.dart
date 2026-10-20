import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Controller
    final DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Halaman Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.offAllNamed('/login'),
              child: const Text('Logout (Ke Login)'),
            ),
          ],
        ),
      ),
    );
  }
}
