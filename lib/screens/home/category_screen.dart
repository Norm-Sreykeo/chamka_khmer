import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final categories = [
      {"id": "fruit", "name": "ផ្លែឈើ"},
      {"id": "vegetable", "name": "បន្លែ"},
      {"id": "meat", "name": "សាច់"},
      {"id": "drink", "name": "ភេសជ្ជៈ"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (_, i) {
          final cat = categories[i];

          return ListTile(
            leading: const Icon(Icons.category),
            title: Text(cat["name"]!),
            onTap: () {
              Navigator.pop(context, cat["id"]);
            },
          );
        },
      ),
    );
  }
}
