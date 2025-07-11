import 'food_model.dart';

class CartItem {
  final String id;
  final FoodModel food;
  int quantity;
  final List<String> specialInstructions;
  final Map<String, dynamic>? customizations;

  CartItem({
    required this.id,
    required this.food,
    required this.quantity,
    required this.specialInstructions,
    this.customizations,
  });

  double get totalPrice => food.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'food': food.toMap(),
      'quantity': quantity,
      'specialInstructions': specialInstructions,
      'customizations': customizations,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      food: FoodModel.fromMap(map['food']),
      quantity: map['quantity'] ?? 1,
      specialInstructions: List<String>.from(map['specialInstructions'] ?? []),
      customizations: map['customizations'],
    );
  }

  CartItem copyWith({
    String? id,
    FoodModel? food,
    int? quantity,
    List<String>? specialInstructions,
    Map<String, dynamic>? customizations,
  }) {
    return CartItem(
      id: id ?? this.id,
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      customizations: customizations ?? this.customizations,
    );
  }
}