import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData? icon;
  final Color? color;

  Category({
    required this.id,
    required this.name,
    this.icon,
    this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: _getIcon(json['icon']),
      color: Colors.orange,
    );
  }

  static IconData? _getIcon(String? name) {
    switch (name) {
      case 'apple':
        return Icons.apple;
      case 'eco':
        return Icons.eco;
      case 'local_drink':
        return Icons.local_drink;
      default:
        return Icons.category;
    }
  }
}