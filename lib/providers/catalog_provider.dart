import 'dart:async';

import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';

class CatalogProvider extends ChangeNotifier {
  final List<Category> _categories = [];
  final List<Product> _products = [];
  bool _isLoading = true;
  String? _selectedCategoryId;

  CatalogProvider() {
    _loadData();
  }

  List<Category> get categories => List.unmodifiable(_categories);
  List<Product> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String? get selectedCategoryId => _selectedCategoryId;

  List<Product> get filteredProducts {
    if (_selectedCategoryId == null) {
      return products;
    }
    return _products
        .where((product) => product.categoryId == _selectedCategoryId)
        .toList();
  }

  Future<void> _loadData() async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    _categories.addAll(const [
      Category(id: 'fruit', name: 'ផ្លែឈើ'),
      Category(id: 'veg', name: 'បន្លែ'),
      Category(id: 'herb', name: 'ស្លឹកឱសថ'),
      Category(id: 'dry', name: 'ផលិតផលស្ងួត'),
    ]);

    _products.addAll(const [
      Product(
        id: 'p1',
        name: 'ស្វាយ',
        categoryId: 'fruit',
        imageUrl:
            'https://images.unsplash.com/photo-1547514701-42782101795e?auto=format&fit=crop&w=600&q=60',
        price: 6000,
        rating: 4.8,
        unit: 'គីឡូ',
        description: 'ស្វាយទុំក្លិនក្រអូប ពិសេសសម្រាប់ទទួលទានផ្ទាល់។',
      ),
      Product(
        id: 'p2',
        name: 'ផ្លែមៀន',
        categoryId: 'fruit',
        imageUrl:
            'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=600&q=60',
        price: 8000,
        rating: 4.6,
        unit: 'គីឡូ',
        description: 'ផ្លែមៀនស្រស់ ជ្រើសរើសពីចម្ការដែលមានគុណភាព។',
      ),
      Product(
        id: 'p3',
        name: 'ល្ហុង',
        categoryId: 'fruit',
        imageUrl:
            'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=600&q=60',
        price: 5500,
        rating: 4.5,
        unit: 'គីឡូ',
        description: 'ល្ហុងស្រស់សម្រាប់ធ្វើម្ហូប ឬទទួលទាន។',
      ),
      Product(
        id: 'p4',
        name: 'ត្រសក់',
        categoryId: 'veg',
        imageUrl:
            'https://images.unsplash.com/photo-1508747703725-719777637510?auto=format&fit=crop&w=600&q=60',
        price: 3000,
        rating: 4.4,
        unit: 'គីឡូ',
        description: 'ត្រសក់ស្រស់ ងាយស្រួលធ្វើសាឡាដ។',
      ),
      Product(
        id: 'p5',
        name: 'ត្រប់',
        categoryId: 'veg',
        imageUrl:
            'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?auto=format&fit=crop&w=600&q=60',
        price: 3500,
        rating: 4.3,
        unit: 'គីឡូ',
        description: 'ត្រប់ពណ៌ស្វាយ ស្រស់ និងមានរសជាតិឈ្ងុយ។',
      ),
      Product(
        id: 'p6',
        name: 'ស្លឹកក្រូច',
        categoryId: 'herb',
        imageUrl:
            'https://images.unsplash.com/photo-1482012792084-a0c3725f289f?auto=format&fit=crop&w=600&q=60',
        price: 2000,
        rating: 4.7,
        unit: 'បាច់',
        description: 'ស្លឹកក្រូចស្រស់ សម្រាប់បន្ថែមក្លិនឆ្ងាញ់។',
      ),
      Product(
        id: 'p7',
        name: 'ខ្ទឹមស',
        categoryId: 'dry',
        imageUrl:
            'https://images.unsplash.com/photo-1506806732259-39c2d0268443?auto=format&fit=crop&w=600&q=60',
        price: 4000,
        rating: 4.5,
        unit: 'គីឡូ',
        description: 'ខ្ទឹមសស្ងួត សម្រាប់ម្ហូបប្រចាំថ្ងៃ។',
      ),
    ]);

    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }
}
