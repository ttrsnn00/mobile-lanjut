import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> login() async {
    final usernameInput = emailController.text.trim();
    final passwordInput = passwordController.text.trim();

    if (usernameInput.isEmpty || passwordInput.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Username/Email dan password tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber.shade100,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': usernameInput,
          'password': passwordInput,
          'expiresInMins': 30,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Get.snackbar(
          'Sukses',
          'Login berhasil! Selamat datang, ${data['firstName']}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );

        Get.offAllNamed('/dashboard');
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Gagal Login',
          errorData['message'] ?? 'Kredensial tidak valid',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Koneksi',
        'Gagal terhubung ke server: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
