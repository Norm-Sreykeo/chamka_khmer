import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/order.dart' as app_models;

class OrderProvider extends ChangeNotifier {
  final List<app_models.Order> _orders = [];

  List<app_models.Order> get orders => List.unmodifiable(_orders);

  String _generateOrderId() {
    final ms = DateTime.now().millisecondsSinceEpoch;
    return 'ORD-$ms';
  }

  void placeOrder({
    required List<CartItem> items,
    required String paymentMethod,
    required String address,
    String status = 'កំពុងរៀបចំ',
  }) {
    _orders.insert(
      0,
      app_models.Order(
        id: _generateOrderId(),
        items: items
            .map((i) => CartItem(product: i.product, quantity: i.quantity))
            .toList(),
        date: DateTime.now(),
        status: status,
        paymentMethod: paymentMethod,
        address: address,
      ),
    );

    notifyListeners();
  }
}
