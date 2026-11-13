import 'package:get/get.dart';
import 'package:shiroine/data/models/cart_model.dart';
import 'package:shiroine/data/models/plant_models.dart';
import 'package:get_storage/get_storage.dart';

import '../cart/cart_success_page.dart';

import '../../data/providers/api_provider.dart';

class CartController extends GetxController {
  var isCheckingOut = false.obs;
  final box = GetStorage();

  void checkout() async {
    if (cartItems.isEmpty) return;

    isCheckingOut(true);

    String? token = box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'Sesi telah habis, silakan login kembali');
      isCheckingOut(false);
      return;
    }

    // Siapkan data sesuai format yang diminta Laravel
    var itemsData = cartItems
        .map(
          (item) => {
            'plant_id': item.plant.id,
            'quantity': item.quantity,
            'price': item.plant.price,
          },
        )
        .toList();

    Map<String, dynamic> orderData = {
      'total_price': totalPrice,
      'items': itemsData,
    };

    // Panggil API
    bool success = await ApiProvider().checkout(orderData, token);

    if (success) {
      cartItems.clear(); // Kosongkan keranjang jika berhasil
      Get.to(() => const CheckoutSuccessPage());
    } else {
      Get.snackbar('Gagal', 'Terjadi kesalahan saat checkout');
    }
    isCheckingOut(false);
  }

  // Obx list untuk menyimpan item keranjang
  var cartItems = <CartModel>[].obs;

  // Mendapatkan total item di keranjang
  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Mendapatkan total harga belanjaan
  int get totalPrice => cartItems.fold(
    0,
    (sum, item) => sum + (item.plant.price * item.quantity),
  );

  void addToCart(PlantModel plant) {
    // Cek apakah tanaman sudah ada di keranjang
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.plant.id == plant.id,
    );

    if (existingItem != null) {
      existingItem.quantity++;
      cartItems.refresh(); // Refresh state Obx
    } else {
      cartItems.add(CartModel(plant: plant));
    }

    Get.snackbar(
      'Berhasil',
      '${plant.name} ditambahkan ke keranjang',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void decreaseQuantity(CartModel cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      cartItems.refresh();
    } else {
      cartItems.remove(cartItem);
    }
  }

  void removeFromCart(CartModel cartItem) {
    cartItems.remove(cartItem);
  }
}
