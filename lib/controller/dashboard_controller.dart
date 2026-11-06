import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
// Sesuaikan import model dengan lokasi file DashboardModel Anda
import 'package:shiroine/binding/dashboard.dart';

class DashboardController extends GetxController {
  final tmp = GetStorage();

  var token = ''.obs;
  var username = ''.obs;
  var email = ''.obs;

  final isLoading = false.obs;
  final totalUser = 0.obs;
  final totalRuangan = 0.obs;
  final totalBooking = 0.obs;
  final tersedia = 0.obs;

  // Ganti 127.0.0.1 dengan 10.0.2.2 jika dijalankan di Emulator Android
  final String baseUrl = 'http://127.0.0.1:8000/api';

  @override
  void onInit() {
    super.onInit();
    token.value = tmp.read('token') ?? '';
    username.value = tmp.read('name') ?? '';
    email.value = tmp.read('email') ?? '';
    dashboard();
  }

  Future<void> dashboard() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/dashboard'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        // Oper Map responseBody ke fromJson, bukan String response.body
        DashboardModel data = DashboardModel.fromJson(responseBody);

        totalUser.value = data.totalUser;
        totalRuangan.value = data.totalRuangan;
        totalBooking.value = data.totalBooking;
        tersedia.value = data.ruanganTersedia;
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal memuat data dashboard (${response.statusCode})',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan jaringan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Memastikan loading selalu mati meski request sukses maupun gagal
      isLoading.value = false;
    }
  }
}
