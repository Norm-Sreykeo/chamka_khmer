// This file will contain the QuantitySelector widget implementation.
import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
        Text('1'),
        IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ],
    );
  }
}