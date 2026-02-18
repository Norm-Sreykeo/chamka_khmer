class Category {
  final String id;
  final String name;
  final String imagePath;

  const Category({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
    );
  }
}
