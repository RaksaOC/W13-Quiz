import 'package:flutter/material.dart';
import 'package:quiz/models/grocery.dart';
import 'package:quiz/ui/groceries/grocery_edit.dart';
import 'package:quiz/ui/groceries/grocery_tile.dart';

class GroceriesTab extends StatefulWidget {
  final List<Grocery> groceries;
  const GroceriesTab({super.key, required this.groceries});

  @override
  State<GroceriesTab> createState() => _GroceriesTabState();
}

class _GroceriesTabState extends State<GroceriesTab> {
  void onTap(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroceryEdit(
          grocery: widget.groceries.firstWhere((grocery) => grocery.id == id),
          onGroceryUpdated: (updatedGrocery) {
            setState(() {
              int index = widget.groceries.indexWhere(
                (grocery) => grocery.id == id,
              );
              widget.groceries.removeAt(index);
              widget.groceries.insert(index, updatedGrocery);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (widget.groceries.isNotEmpty) {
      //  Display widget.groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: widget.groceries.length,
        itemBuilder: (context, index) => GroceryTile(
          grocery: widget.groceries[index],
          onTap: (id) => onTap(context, id),
        ),
      );
    }
    return content;
  }
}
