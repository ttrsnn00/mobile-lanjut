import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/order_models.dart';
import '../../data/providers/api_provider.dart';

class OrderHistoryController extends GetxController {
  var orders = <OrderModel>[].obs;
  var isLoading = true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() async {
    isLoading(true);
    String? token = box.read('token');

    if (token != null) {
      var fetchedOrders = await ApiProvider().getOrderHistory(token);
      orders.assignAll(fetchedOrders);
    }
    isLoading(false);
  }
}
