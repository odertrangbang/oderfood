import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/food_model.dart';

class CartService extends ChangeNotifier {
  List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  
  int get totalQuantity {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  void addItem(FoodModel food, {int quantity = 1, List<String>? specialInstructions, Map<String, dynamic>? customizations}) {
    final existingIndex = _items.indexWhere((item) => 
        item.food.id == food.id && 
        listEquals(item.specialInstructions, specialInstructions ?? []) &&
        mapEquals(item.customizations, customizations));
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      final cartItem = CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        food: food,
        quantity: quantity,
        specialInstructions: specialInstructions ?? [],
        customizations: customizations,
      );
      _items.add(cartItem);
    }
    notifyListeners();
  }

  void removeItem(String cartItemId) {
    _items.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void updateQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(cartItemId);
      return;
    }
    
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void increaseQuantity(String cartItemId) {
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String cartItemId) {
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        removeItem(cartItemId);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String foodId) {
    return _items.any((item) => item.food.id == foodId);
  }

  int getQuantityInCart(String foodId) {
    final items = _items.where((item) => item.food.id == foodId);
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  CartItem? getCartItem(String cartItemId) {
    try {
      return _items.firstWhere((item) => item.id == cartItemId);
    } catch (e) {
      return null;
    }
  }

  List<CartItem> getItemsByFood(String foodId) {
    return _items.where((item) => item.food.id == foodId).toList();
  }

  double getDeliveryFee() {
    if (_items.isEmpty) return 0.0;
    return 25000.0; // 25k VND delivery fee
  }

  double getTax() {
    return totalAmount * 0.1; // 10% tax
  }

  double getDiscount() {
    // Implement discount logic here
    if (totalAmount > 200000) { // Over 200k VND
      return totalAmount * 0.05; // 5% discount
    }
    return 0.0;
  }

  double getFinalTotal() {
    return totalAmount + getDeliveryFee() + getTax() - getDiscount();
  }

  Map<String, dynamic> getCartSummary() {
    return {
      'subtotal': totalAmount,
      'deliveryFee': getDeliveryFee(),
      'tax': getTax(),
      'discount': getDiscount(),
      'total': getFinalTotal(),
      'itemCount': itemCount,
      'totalQuantity': totalQuantity,
    };
  }

  void updateSpecialInstructions(String cartItemId, List<String> instructions) {
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      final updatedItem = _items[index].copyWith(specialInstructions: instructions);
      _items[index] = updatedItem;
      notifyListeners();
    }
  }

  void updateCustomizations(String cartItemId, Map<String, dynamic> customizations) {
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      final updatedItem = _items[index].copyWith(customizations: customizations);
      _items[index] = updatedItem;
      notifyListeners();
    }
  }

  // Save cart to local storage (implement with SharedPreferences)
  Future<void> saveCartToLocal() async {
    // Implementation would use SharedPreferences to persist cart data
    try {
      // final prefs = await SharedPreferences.getInstance();
      // final cartData = _items.map((item) => item.toMap()).toList();
      // await prefs.setString('cart_data', jsonEncode(cartData));
    } catch (e) {
      print('Save cart error: $e');
    }
  }

  // Load cart from local storage
  Future<void> loadCartFromLocal() async {
    // Implementation would use SharedPreferences to load persisted cart data
    try {
      // final prefs = await SharedPreferences.getInstance();
      // final cartDataString = prefs.getString('cart_data');
      // if (cartDataString != null) {
      //   final List<dynamic> cartData = jsonDecode(cartDataString);
      //   _items = cartData.map((item) => CartItem.fromMap(item)).toList();
      //   notifyListeners();
      // }
    } catch (e) {
      print('Load cart error: $e');
    }
  }

  // Check if cart has any unavailable items
  bool hasUnavailableItems() {
    return _items.any((item) => !item.food.isAvailable);
  }

  // Remove unavailable items from cart
  void removeUnavailableItems() {
    _items.removeWhere((item) => !item.food.isAvailable);
    notifyListeners();
  }

  // Get cart validation errors
  List<String> getValidationErrors() {
    List<String> errors = [];
    
    if (_items.isEmpty) {
      errors.add('Cart is empty');
    }
    
    for (var item in _items) {
      if (!item.food.isAvailable) {
        errors.add('${item.food.name} is no longer available');
      }
      if (item.quantity <= 0) {
        errors.add('Invalid quantity for ${item.food.name}');
      }
    }
    
    return errors;
  }
}