class Product {
  final String id;
  final String name;
  final String categoryId;
  final String imageUrl;
  final double price;
  final double rating;
  final String unit;
  final String description;
  final int? stock;

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      unit: json['unit'],
      description: json['description'],
      stock: json['stock'], // nullable
    );
  }
}
