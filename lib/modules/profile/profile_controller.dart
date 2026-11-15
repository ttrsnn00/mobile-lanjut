import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/providers/api_provider.dart';
import '../../routes/app_routes.dart';

class ProfileController extends GetxController {
  var userData = <String, dynamic>{}.obs;
  var isLoading = true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      isLoading(true);
      String? token = box.read('token');

      if (token != null) {
        var response = await ApiProvider().getUserProfile(token);
        if (response != null) {
          userData.assignAll(response);
        }
      }
    } catch (e) {
      print('Error fetchUserProfile: $e');
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    box.remove('token');
    Get.offAllNamed(AppRoutes.LOGIN);
    Get.snackbar(
      'Logout',
      'Anda telah keluar dari aplikasi',
      backgroundColor: Colors.blueGrey.shade100,
      colorText: Colors.blueGrey.shade900,
    );
  }
}
