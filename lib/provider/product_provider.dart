import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Category> _categories = [];

  bool _loading = false;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get loading => _loading;

  Future<void> loadData() async {
    _loading = true;
    notifyListeners();

    try {
      _products = await _apiService.getProducts();
      _categories = await _apiService.getCategories();
    } catch (e) {
      debugPrint("Error loading data: $e");
    }

    _loading = false;
    notifyListeners();
  }

  /// filter by category
  List<Product> getProductsByCategory(String categoryId) {
    return _products
        .where((p) => p.categoryId == categoryId)
        .toList();
  }
}