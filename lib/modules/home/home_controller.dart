import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/plant_models.dart';
import '../../data/providers/api_provider.dart';

class HomeController extends GetxController {
  final categories = ['Semua', 'Tanaman Hias', 'Bibit Tanaman', 'Tanaman Buah'];

  var selectedCategory = 'Semua'.obs;
  var searchQuery = ''.obs;
  var allPlants = <PlantModel>[].obs;
  var isLoading = true.obs; // Tambahkan indikator loading

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchPlantsFromApi(); // Panggil fungsi API saat halaman dimuat
  }

  void fetchPlantsFromApi() async {
    try {
      isLoading(true);
      // Ambil token dari GetStorage
      String? token = box.read('token');

      // Request ke API Laravel
      var plants = await ApiProvider().getPlants(token: token);

      if (plants.isNotEmpty) {
        allPlants.assignAll(plants);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data dari server');
    } finally {
      isLoading(false);
    }
  }

  List<PlantModel> get filteredPlants {
    return allPlants.where((plant) {
      final matchesCategory =
          selectedCategory.value == 'Semua' ||
          plant.category == selectedCategory.value;
      final matchesSearch = plant.name.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
