class Product {
  final String id;
  final String name;
  final String categoryId;
  final String imageUrl;
  final double price;
  final double rating;
  final String unit;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.unit,
    required this.description,
  });
}
