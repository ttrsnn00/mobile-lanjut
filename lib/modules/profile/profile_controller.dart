import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/providers/api_provider.dart';
import '../../routes/app_routes.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;
  var isLoading = true.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async {
    String? token = box.read('token');
    if (token != null) {
      var user = await ApiProvider().getUserProfile(token);
      if (user != null) {
        userName.value = user['name'] ?? '';
        userEmail.value = user['email'] ?? '';
      }
    }
    isLoading(false);
  }

  void logout() {
    box.remove('token');
    Get.offAllNamed(AppRoutes.LOGIN);
    Get.snackbar('Berhasil', 'Anda telah keluar dari aplikasi');
  }
}
