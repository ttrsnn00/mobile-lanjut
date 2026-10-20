import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Controller
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0), // Menambahkan padding agar rapi
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Halaman Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // === KODE DISISIPKAN DI SINI ===
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Username / Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: controller.passwordController,
                obscureText: true, // Opsional: menyembunyikan input password
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => controller.login(),
                child: const Text('Login'),
              ),
              // ================================

              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Get.toNamed('/register'),
                child: const Text('Ke Halaman Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
