import 'package:get/get.dart';

class MainController extends GetxController {
  // Index 0 = Home, 1 = Cart, 2 = Profile
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
