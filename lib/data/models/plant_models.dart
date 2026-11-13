class PlantModel {
  final int id;
  final String name;
  final String category; // 'Tanaman Hias', 'Bibit Tanaman', 'Tanaman Buah'
  final int price;
  final int stock;
  final String imageUrl;
  final String description;
  final String careInstructions;

  PlantModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.description,
    required this.careInstructions,
  });

  // Mapping dari JSON Laravel API
  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      id: json['id'],
      name: json['name'],
      category: json['category'] ?? 'Tanaman Hias',
      price: int.parse(json['price'].toString()),
      stock: int.parse(json['stock'].toString()),
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
      careInstructions: json['care_instructions'] ?? '',
    );
  }

  // Data sementara untuk testing UI Flutter
  static List<PlantModel> dummyPlants = [
    PlantModel(
      id: 1,
      name: 'Monstera Deliciosa',
      category: 'Tanaman Hias',
      price: 85000,
      stock: 12,
      imageUrl:
          'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=500',
      description: 'Tanaman hias indoor populer dengan daun berlubang estetik yang cocok untuk sudut ruangan.',
      careInstructions: 'Cahaya tidak langsung, siram 2-3 kali seminggu saat media tanam mulai kering.',
    ),
    PlantModel(
      id: 2,
      name: 'Bibit Alpukat Aligator',
      category: 'Bibit Tanaman',
      price: 35000,
      stock: 30,
      imageUrl:
          'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=500',
      description: 'Bibit hasil okulasi cepat berbuah dengan ukuran buah jumbo dan daging tebal.',
      careInstructions: 'Butuh sinar matahari penuh, siram pagi dan sore pada fase awal tanam.',
    ),
    PlantModel(
      id: 3,
      name: 'Tabulampot Jeruk Nagami',
      category: 'Tanaman Buah',
      price: 150000,
      stock: 5,
      imageUrl:
          'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?w=500',
      description: 'Tanaman buah dalam pot yang sudah mulai berbuah, kulit buah manis dan bisa dimakan langsung.',
      careInstructions: 'Sinar matahari penuh minimal 6 jam, beri pupuk NPK buah setiap 2 minggu.',
    ),
    PlantModel(
      id: 4,
      name: 'Calathea Orbifolia',
      category: 'Tanaman Hias',
      price: 65000,
      stock: 8,
      imageUrl:
          'https://images.unsplash.com/photo-1597055181300-e3633a917c9c?w=500',
      description: 'Daun lebar bermotif garis perak hijau yang menenangkan dan aman untuk hewan peliharaan.',
      careInstructions: 'Tempat teduh dengan kelembapan tinggi, hindari sinar matahari langsung.',
    ),
  ];
}
