import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/category.dart';
import '../models/product.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore}) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  FirebaseFirestore get _firestoreInstance =>
      _firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _categoriesRef =>
      _firestoreInstance.collection('categories');

  CollectionReference<Map<String, dynamic>> get _productsRef =>
      _firestoreInstance.collection('products');

  Future<List<Category>> getCategories() async {
    final snap = await _categoriesRef.get();
    return snap.docs
        .map(
          (d) => Category.fromJson(<String, dynamic>{...d.data(), 'id': d.id}),
        )
        .toList();
  }

  Future<List<Product>> getProducts() async {
    final snap = await _productsRef.get();
    return snap.docs
        .map(
          (d) => Product.fromJson(<String, dynamic>{...d.data(), 'id': d.id}),
        )
        .toList();
  }

  Future<bool> hasAnyData() async {
    final categories = await _categoriesRef.limit(1).get();
    if (categories.docs.isNotEmpty) return true;
    final products = await _productsRef.limit(1).get();
    return products.docs.isNotEmpty;
  }

  Future<void> seedFromAssetsIfEmpty() async {
    final alreadyHasData = await hasAnyData();
    if (alreadyHasData) return;

    final categoriesRaw = await rootBundle.loadString(
      'lib/assets/data/categories.json',
    );
    final productsRaw = await rootBundle.loadString(
      'lib/assets/data/products.json',
    );

    final List<dynamic> categoriesJson = json.decode(categoriesRaw);
    final List<dynamic> productsJson = json.decode(productsRaw);

    final batch = _firestoreInstance.batch();

    for (final c in categoriesJson) {
      final map = Map<String, dynamic>.from(c as Map);
      final id = map['id'] as String;
      map.remove('id');
      batch.set(_categoriesRef.doc(id), map, SetOptions(merge: true));
    }

    for (final p in productsJson) {
      final map = Map<String, dynamic>.from(p as Map);
      final id = map['id'] as String;
      map.remove('id');

      final imageUrl = map['imageUrl'];
      if (imageUrl is String && imageUrl.startsWith('data:image')) {
        if (imageUrl.length > 20000) {
          map['imageUrl'] = '';
          map['hasLocalBase64Image'] = true;
        }
      }

      batch.set(_productsRef.doc(id), map, SetOptions(merge: true));
    }

    await batch.commit();
  }
}
