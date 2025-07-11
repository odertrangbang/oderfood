import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_model.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FoodModel>> getAllFoods() async {
    try {
      final querySnapshot = await _firestore
          .collection('foods')
          .where('isAvailable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => FoodModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Get all foods error: $e');
      return [];
    }
  }

  Future<List<FoodModel>> getFoodsByCategory(String category) async {
    try {
      final querySnapshot = await _firestore
          .collection('foods')
          .where('category', isEqualTo: category)
          .where('isAvailable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => FoodModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Get foods by category error: $e');
      return [];
    }
  }

  Future<List<String>> getAllCategories() async {
    try {
      final querySnapshot = await _firestore
          .collection('foods')
          .where('isAvailable', isEqualTo: true)
          .get();

      Set<String> categories = {};
      for (var doc in querySnapshot.docs) {
        final food = FoodModel.fromMap(doc.data());
        categories.add(food.category);
      }

      return categories.toList()..sort();
    } catch (e) {
      print('Get categories error: $e');
      return [];
    }
  }

  Future<FoodModel?> getFoodById(String foodId) async {
    try {
      final doc = await _firestore.collection('foods').doc(foodId).get();
      if (doc.exists) {
        return FoodModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      print('Get food by ID error: $e');
      return null;
    }
  }

  Future<List<FoodModel>> searchFoods(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection('foods')
          .where('isAvailable', isEqualTo: true)
          .orderBy('name')
          .get();

      final allFoods = querySnapshot.docs
          .map((doc) => FoodModel.fromMap(doc.data()))
          .toList();

      return allFoods.where((food) =>
          food.name.toLowerCase().contains(query.toLowerCase()) ||
          food.description.toLowerCase().contains(query.toLowerCase()) ||
          food.category.toLowerCase().contains(query.toLowerCase()) ||
          food.ingredients.any((ingredient) =>
              ingredient.toLowerCase().contains(query.toLowerCase()))).toList();
    } catch (e) {
      print('Search foods error: $e');
      return [];
    }
  }

  Future<List<FoodModel>> getPopularFoods({int limit = 10}) async {
    try {
      final querySnapshot = await _firestore
          .collection('foods')
          .where('isAvailable', isEqualTo: true)
          .orderBy('rating', descending: true)
          .orderBy('reviewCount', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => FoodModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Get popular foods error: $e');
      return [];
    }
  }

  Future<List<FoodModel>> getRecommendedFoods({int limit = 5}) async {
    try {
      final querySnapshot = await _firestore
          .collection('foods')
          .where('isAvailable', isEqualTo: true)
          .where('rating', isGreaterThanOrEqualTo: 4.0)
          .orderBy('rating', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => FoodModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Get recommended foods error: $e');
      return [];
    }
  }

  Stream<List<FoodModel>> getFoodsStream() {
    return _firestore
        .collection('foods')
        .where('isAvailable', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FoodModel.fromMap(doc.data()))
            .toList());
  }

  // Admin functions
  Future<void> addFood(FoodModel food) async {
    try {
      await _firestore.collection('foods').doc(food.id).set(food.toMap());
    } catch (e) {
      print('Add food error: $e');
      rethrow;
    }
  }

  Future<void> updateFood(FoodModel food) async {
    try {
      await _firestore.collection('foods').doc(food.id).update(food.toMap());
    } catch (e) {
      print('Update food error: $e');
      rethrow;
    }
  }

  Future<void> deleteFood(String foodId) async {
    try {
      await _firestore.collection('foods').doc(foodId).delete();
    } catch (e) {
      print('Delete food error: $e');
      rethrow;
    }
  }

  Future<void> updateFoodAvailability(String foodId, bool isAvailable) async {
    try {
      await _firestore.collection('foods').doc(foodId).update({
        'isAvailable': isAvailable,
      });
    } catch (e) {
      print('Update food availability error: $e');
      rethrow;
    }
  }

  Future<void> updateFoodRating(String foodId, double newRating, int newReviewCount) async {
    try {
      await _firestore.collection('foods').doc(foodId).update({
        'rating': newRating,
        'reviewCount': newReviewCount,
      });
    } catch (e) {
      print('Update food rating error: $e');
      rethrow;
    }
  }
}