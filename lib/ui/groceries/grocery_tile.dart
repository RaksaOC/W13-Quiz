import 'package:flutter/material.dart';
import 'package:quiz/models/grocery.dart';

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery, this.onTap});
  final Function(String)? onTap;

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap != null ? onTap!(grocery.id) : null,
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Row(
        spacing: 10,
        children: [
          Text(grocery.name),
          Text(
            "(" +
                grocery.category.toString().split(".")[1][0].toUpperCase() +
                grocery.category.toString().split(".")[1].substring(1) +
                ")",
            style: TextStyle(color: grocery.category.color),
          ),
        ],
      ),
      trailing: Text(
        grocery.quantity > 1
            ? grocery.quantity.toString() + " Items"
            : grocery.quantity.toString() + " Item",
      ),
    );
  }
}
