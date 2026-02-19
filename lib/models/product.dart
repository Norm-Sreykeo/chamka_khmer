class Product {
  final String id;
  final String name;
  final String categoryId;
  final String imageUrl;
  final double price;
  final double rating;
  final String? description;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imageUrl,
    required this.price,
    required this.rating,
    this.description,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        categoryId: json['categoryId'],
        imageUrl: json['imageUrl'],
        price: (json['price'] as num).toDouble(),
        rating: (json['rating'] as num).toDouble(),
        description: json['description'],
        isFavorite: json['isFavorite'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'categoryId': categoryId,
        'imageUrl': imageUrl,
        'price': price,
        'rating': rating,
        'description': description,
        'isFavorite': isFavorite,
      };
}
