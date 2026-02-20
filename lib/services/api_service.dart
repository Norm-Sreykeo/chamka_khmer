import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../models/category.dart';

class ApiService {

  Future<List<Product>> getProducts() async {
    final data = await rootBundle.loadString('lib/assets/data/products.json');
    final List jsonResult = json.decode(data);
    return jsonResult.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Category>> getCategories() async {
    final data = await rootBundle.loadString('lib/assets/data/categories.json');
    final List jsonResult = json.decode(data);
    return jsonResult.map((e) => Category.fromJson(e)).toList();
  }
}

