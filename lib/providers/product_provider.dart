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

  List<Product> getProductsByCategory(String categoryId) {
    return getProductsByCategoryAndSubCategory(categoryId);
  }

  List<Product> getProductsByCategoryAndSubCategory(
    String categoryId, {
    String? subCategory,
  }) {
    return _products.where((p) {
      if (p.categoryId != categoryId) return false;
      if (subCategory == null || subCategory.isEmpty) return true;
      return p.subCategory == subCategory;
    }).toList();
  }
}
