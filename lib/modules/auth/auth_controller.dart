import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Tambahkan import GetStorage

import '../../routes/app_routes.dart';
import '../../data/providers/api_provider.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  // Inisialisasi instance GetStorage
  final box = GetStorage();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Logika Login
  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan Password tidak boleh kosong!',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    try {
      isLoading(true);

      var response = await ApiProvider().login(
        emailController.text,
        passwordController.text,
      );

      // Cari bagian logika login ini:
      if (response != null && response.containsKey('access_token')) {
        String token = response['access_token'];

        // Simpan token ke GetStorage
        box.write('token', token);
        print("Token didapat: $token");

        Get.offAllNamed(AppRoutes.MAIN);
        Get.snackbar(
          'Sukses',
          'Berhasil masuk ke aplikasi',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal login, periksa kembali email & password Anda.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading(false);
    }
  }

  // Logika Register
  void register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua kolom wajib diisi!',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    try {
      isLoading(true);

      // Memanggil API Provider untuk Register
      var response = await ApiProvider().register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      // Biasanya API Laravel Sanctum langsung mengembalikan token setelah register sukses
      if (response != null && response.containsKey('access_token')) {
        // <-- Ubah di sini
        String token = response['access_token'];

        // Simpan token agar user langsung berstatus login
        box.write('token', token);

        Get.offAllNamed(AppRoutes.MAIN);
        Get.snackbar(
          'Sukses',
          'Akun berhasil dibuat dan langsung masuk!',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );
      } else {
        // Jika API Anda tidak mengembalikan token saat register, arahkan ke Login
        Get.offAllNamed(AppRoutes.MAIN);
        Get.snackbar(
          'Sukses',
          'Akun berhasil dibuat! Silakan login dengan akun baru Anda.',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mendaftar. Email mungkin sudah digunakan.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading(false);
    }
  }

  // Logika Logout
  void logout() {
    // Hapus Token dari GetStorage
    box.remove('token');

    Get.offAllNamed(AppRoutes.MAIN);
    Get.snackbar(
      'Logout',
      'Anda telah keluar dari aplikasi',
      backgroundColor: Colors.blueGrey.shade100,
      colorText: Colors.blueGrey.shade900,
    );
  }
}
