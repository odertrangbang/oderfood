class FoodModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final bool isAvailable;
  final double rating;
  final int reviewCount;
  final List<String> ingredients;
  final String? cookingTime;
  final bool isVegetarian;
  final bool isSpicy;
  final Map<String, dynamic>? nutritionInfo;
  final DateTime createdAt;

  FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.isAvailable,
    required this.rating,
    required this.reviewCount,
    required this.ingredients,
    this.cookingTime,
    required this.isVegetarian,
    required this.isSpicy,
    this.nutritionInfo,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'isAvailable': isAvailable,
      'rating': rating,
      'reviewCount': reviewCount,
      'ingredients': ingredients,
      'cookingTime': cookingTime,
      'isVegetarian': isVegetarian,
      'isSpicy': isSpicy,
      'nutritionInfo': nutritionInfo,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      isAvailable: map['isAvailable'] ?? true,
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      ingredients: List<String>.from(map['ingredients'] ?? []),
      cookingTime: map['cookingTime'],
      isVegetarian: map['isVegetarian'] ?? false,
      isSpicy: map['isSpicy'] ?? false,
      nutritionInfo: map['nutritionInfo'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  FoodModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    List<String>? images,
    bool? isAvailable,
    double? rating,
    int? reviewCount,
    List<String>? ingredients,
    String? cookingTime,
    bool? isVegetarian,
    bool? isSpicy,
    Map<String, dynamic>? nutritionInfo,
    DateTime? createdAt,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      images: images ?? this.images,
      isAvailable: isAvailable ?? this.isAvailable,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      ingredients: ingredients ?? this.ingredients,
      cookingTime: cookingTime ?? this.cookingTime,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isSpicy: isSpicy ?? this.isSpicy,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}