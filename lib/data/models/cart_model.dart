import 'plant_models.dart';

class CartModel {
  final PlantModel plant;
  int quantity;

  CartModel({required this.plant, this.quantity = 1});
}
