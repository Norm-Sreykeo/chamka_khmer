import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ApiService {

  /// Fetch products from local JSON (mock API)
  Future<List<Product>> getProducts() async {
    final response =
        await rootBundle.loadString('assets/data/products.json');

    final List data = json.decode(response);

    return data.map((e) => Product.fromJson(e)).toList();
  }
}

// // import 'package:http/http.dart' as http;

// Future<List<Product>> getProducts() async {
//   final response =
//       await http.get(Uri.parse("https://api.yourapp.com/products"));

//   final List data = json.decode(response.body);

//   return data.map((e) => Product.fromJson(e)).toList();
// }
