import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> register() async {
    final nameInput = nameController.text.trim();
    final emailInput = emailController.text.trim();
    final passwordInput = passwordController.text.trim();

    if (nameInput.isEmpty || emailInput.isEmpty || passwordInput.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Nama, Email, dan password tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber.shade100,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': nameInput,
          'email': emailInput,
          'password': passwordInput,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Get.snackbar(
          'Sukses',
          data['message'] ?? 'Registrasi berhasil!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );

        Get.offAllNamed('/dashboard');
      } else {
        final errorData = jsonDecode(response.body);

        String errorMessage =
            errorData['message'] ?? 'Gagal melakukan registrasi';

        if (errorData['errors'] != null) {
          errorMessage = errorData['errors'].values.first[0];
        }

        Get.snackbar(
          'Gagal Registrasi',
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
