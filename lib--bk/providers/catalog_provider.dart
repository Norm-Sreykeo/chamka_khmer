import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../services/api_service.dart';
class CatalogProvider extends ChangeNotifier {
  final List<Category> _categories = [];
  final List<Product> _products = [];
  final List<Product> _cart = []; // Cart list

  bool _isLoading = true;
  String? _selectedCategoryId;

  CatalogProvider() {
    _loadData();
  }

  List<Category> get categories => _categories;
  List<Product> get products => _products;
  List<Product> get cartItems => _cart; // Expose cart items
  bool get isLoading => _isLoading;
  String? get selectedCategoryId => _selectedCategoryId;

  List<Product> get filteredProducts {
    if (_selectedCategoryId == null) return _products;

    return _products
        .where((p) => p.categoryId == _selectedCategoryId)
        .toList();
  }

  /// Add product to cart
  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  /// Remove product from cart
  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  /// LOAD JSON DATA
  Future<void> _loadData() async {
    try {
      _isLoading = true;
      notifyListeners();

      final categoriesJson =
          await LocalDataService.loadCategories();

      final productsJson =
          await LocalDataService.loadProducts();

      _categories.clear();
      _products.clear();

      _categories.addAll(
        categoriesJson.map((e) => Category.fromJson(e)),
      );
      _products.addAll(
        productsJson.map((e) => Product.fromJson(e)),
      );
    } catch (e) {
      debugPrint("Load error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(String? id) {
    _selectedCategoryId = id;
    notifyListeners();
  }
}