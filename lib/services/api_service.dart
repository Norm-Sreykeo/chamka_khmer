import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../models/category.dart';

class ApiService {

  /// Load Products
  static Future<List<Product>> loadProducts() async {
    final data = await rootBundle.loadString('assets/data/products.json');
    final List jsonResult = json.decode(data);
    return jsonResult.map((e) => Product.fromJson(e)).toList();
  }

  /// Load Categories
  static Future<List<Category>> loadCategories() async {
    final data = await rootBundle.loadString('assets/data/categories.json');
    final List jsonResult = json.decode(data);
    return jsonResult.map((e) => Category(
      id: e['id'],
      name: e['name'],
    )).toList();
  }
}
