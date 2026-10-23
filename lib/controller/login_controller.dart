import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  // Sementara disimpan di memori. Untuk persisten, pakai shared_preferences.
  static String? accessToken;

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
        Uri.parse('http://127.0.0.1:8000/api/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // wajib untuk Laravel API
        },
        body: jsonEncode({
          'email': emailInput, // BUKAN 'username'
          'password': passwordInput,
        }),
      );

      debugPrint('LOGIN ${response.statusCode}: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        accessToken = data['access_token'];

        Get.snackbar(
          'Sukses',
          data['message'] ?? 'Login berhasil',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );

        Get.offAllNamed('/dashboard');
      } else {
        String errorMessage = data['message'] ?? 'Kredensial tidak valid';
        if (data['errors'] != null) {
          errorMessage = (data['errors'] as Map).values.first[0];
        }
        Get.snackbar(
          'Gagal Login',
          errorMessage,
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
