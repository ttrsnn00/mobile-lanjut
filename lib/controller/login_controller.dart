import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  // Instance GetStorage & Secure Storage
  final tmp = GetStorage();

  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<void> login() async {
    final emailInput = emailController.text.trim();
    final passwordInput = passwordController.text.trim();

    if (emailInput.isEmpty || passwordInput.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Email dan password tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber.shade100,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': emailInput, 'password': passwordInput}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Ambil objek user jika backend mengembalikannya dalam key 'user' / 'data'
        final userData = data['user'] ?? data['data'] ?? {};

        // Storing data dari token sampai email menggunakan tmp (GetStorage)
        tmp.write('token', data['access_token'] ?? data['token']);
        tmp.write('id', userData['id']);
        tmp.write('name', userData['name']);
        tmp.write('email', userData['email'] ?? emailInput);

        // Opsi menyimpan token di secure storage

        Get.snackbar(
          'Sukses',
          data['message'] ?? 'Login berhasil!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );

        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Gagal Login',
          data['message'] ?? 'Email atau password salah',
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
