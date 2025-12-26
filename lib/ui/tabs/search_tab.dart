import 'package:flutter/material.dart';
import 'package:quiz/models/grocery.dart';
import 'package:quiz/ui/groceries/grocery_tile.dart';

class SearchTab extends StatefulWidget {
  final List<Grocery> groceries;
  SearchTab({super.key, required this.groceries});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String searchText = "";

  void onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  List<Grocery> get filteredList {
    List<Grocery> results = [];
    for (Grocery g in widget.groceries) {
      if (
      // for names
      g.name.toLowerCase().startsWith(searchText.toLowerCase()) ||
          // for category names too :)
          g.category.label.toLowerCase().startsWith(searchText.toLowerCase())) {
        results.add(g);
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          TextField(onChanged: onSearchChanged),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) =>
                  GroceryTile(grocery: filteredList[index]),
            ),
          ),
        ],
      ),
    );
  }
}
