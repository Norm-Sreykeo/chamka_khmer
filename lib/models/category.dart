import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData? icon;
  final Color? color;
  /// Asset path for category image (e.g. lib/assets/icons/1.png)
  final String? iconAsset;

  Category({
    required this.id,
    required this.name,
    this.icon,
    this.color,
    this.iconAsset,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: _getIcon(json['icon']),
      iconAsset: json['iconAsset'] as String?,
      color: Colors.orange,
    );
  }

  static IconData? _getIcon(dynamic name) {
    if (name == null) return null;
    switch (name.toString()) {
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