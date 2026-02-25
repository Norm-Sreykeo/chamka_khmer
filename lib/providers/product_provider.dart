import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../services/firestore_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  FirestoreService? _firestoreService;

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
      if (Firebase.apps.isNotEmpty) {
        final firestoreService = _firestoreService ??= FirestoreService();
        await firestoreService.seedFromAssetsIfEmpty();
        _products = await firestoreService.getProducts();
        _categories = await firestoreService.getCategories();

        if (_products.isEmpty || _categories.isEmpty) {
          _products = await _apiService.getProducts();
          _categories = await _apiService.getCategories();
        }
      } else {
        _products = await _apiService.getProducts();
        _categories = await _apiService.getCategories();
      }
    } catch (e) {
      debugPrint("Error loading data: $e");
      try {
        _products = await _apiService.getProducts();
        _categories = await _apiService.getCategories();
      } catch (e) {
        debugPrint("Error loading fallback data: $e");
      }
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
