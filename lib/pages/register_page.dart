import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Controller
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(title: const Text('Register Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Halaman Register',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('Kembali ke Login'),
            ),
          ],
        ),
      ),
    );
  }
}
