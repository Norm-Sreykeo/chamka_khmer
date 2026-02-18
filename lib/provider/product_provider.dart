import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadProducts() async {
    _loading = true;
    notifyListeners();

    _products = await _apiService.getProducts();

    _loading = false;
    notifyListeners();
  }

  /// filter by category
  List<Product> byCategory(String categoryId) {
    return _products
        .where((p) => p.categoryId == categoryId)
        .toList();
  }
}
