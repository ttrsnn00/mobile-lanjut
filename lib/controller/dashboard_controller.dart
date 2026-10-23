import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  final tmp = GetStorage();
  var token = ''.obs;
  var username = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    token.value = tmp.read('token');
    username.value = tmp.read('username');
    email.value = tmp.read('email');
  }
}
