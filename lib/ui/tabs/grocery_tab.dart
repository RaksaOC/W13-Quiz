import 'package:flutter/material.dart';
import 'package:quiz/models/grocery.dart';
import 'package:quiz/ui/groceries/grocery_tile.dart';

class GroceriesTab extends StatelessWidget {
  final List<Grocery> groceries;
  GroceriesTab({super.key, required this.groceries});

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (groceries.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (context, index) => GroceryTile(grocery: groceries[index]),
      );
    }
    return content;
  }
}
