import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increaseQty(String productId) {
    _items[productId]!.quantity++;
    notifyListeners();
  }

  void decreaseQty(String productId) {
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    _items.forEach((key, item) {
      total += item.product.price * item.quantity;
    });
    return total;
  }

  int get totalItems => _items.length;

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
