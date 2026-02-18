// products.dart

class Product {
  final String id;
  final String name;
  final String categoryId;
  final String imageUrl;
  final int price;
  final double rating;
  final String unit;
  final String description;
  final int? stock; // nullable if stock can be null

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.unit,
    required this.description,
    this.stock,
  });

  // Factory constructor to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as int,
      rating: (json['rating'] as num).toDouble(),
      unit: json['unit'] as String,
      description: json['description'] as String,
      stock: json['stock'] != null ? json['stock'] as int : null,
    );
  }

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'unit': unit,
      'description': description,
      'stock': stock,
    };
  }
}