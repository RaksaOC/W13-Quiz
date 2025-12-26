import 'package:flutter/material.dart';

enum Tab {
  groceries("Groceries", Icons.local_grocery_store),
  search("Search", Icons.search);

  final String label;
  final IconData icon;

  const Tab(this.label, this.icon);
}
