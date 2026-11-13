// lib/data/models/order_models.dart
import 'plant_models.dart';

class OrderModel {
  final int id;
  final int totalPrice;
  final String status;
  final String createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<OrderItemModel> parsedItems = itemsList
        .map((i) => OrderItemModel.fromJson(i))
        .toList();

    return OrderModel(
      id: json['id'],
      totalPrice: json['total_price'],
      status: json['status'],
      createdAt: json['created_at'],
      items: parsedItems,
    );
  }
}

class OrderItemModel {
  final int quantity;
  final int price;
  final PlantModel plant;

  OrderItemModel({
    required this.quantity,
    required this.price,
    required this.plant,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      quantity: json['quantity'],
      price: json['price'],
      plant: PlantModel.fromJson(json['plant']),
    );
  }
}
