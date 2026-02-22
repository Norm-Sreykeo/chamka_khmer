import 'package:flutter/material.dart';
import '../models/product.dart';

class Order {
  final List<Product> products;
  final double total;
  final DateTime date;

  Order({
    required this.products,
    required this.total,
    required this.date,
  });
}

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void placeOrder(List<Product> products, double total) {
    _orders.add(
      Order(
        products: products,
        total: total,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
