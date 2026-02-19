import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final DateTime date;
  final String status;
  final String paymentMethod;
  final String address;

  Order({
    required this.id,
    required this.items,
    required this.date,
    required this.status,
    required this.paymentMethod,
    required this.address,
  });

  double get totalAmount =>
      items.fold(0, (sum, item) => sum + item.totalPrice);
}
