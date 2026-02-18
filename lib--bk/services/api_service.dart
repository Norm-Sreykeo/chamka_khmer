
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalDataService {
  /// Load categories from assets/data/categories.json
  static Future<List<dynamic>> loadCategories() async {
    try {
      final data =
          await rootBundle.loadString('assets/data/categories.json');
      return json.decode(data);
    } catch (e) {
      debugPrint("Error loading categories.json: $e");
      return [];
    }
  }

  /// Load products from assets/data/products.json
  static Future<List<dynamic>> loadProducts() async {
    try {
      final data =
          await rootBundle.loadString('assets/data/products.json');
      return json.decode(data);
    } catch (e) {
      debugPrint("Error loading products.json: $e");
      return [];
    }
  }
}