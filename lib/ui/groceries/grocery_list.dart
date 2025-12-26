import 'package:flutter/material.dart';
import 'package:quiz/ui/tabs/grocery_tab.dart';
import 'package:quiz/ui/tabs/search_tab.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';
import '../../models/tab.dart' as app_tab;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  int _currentTabIndex = 0; // by default
  List<Grocery> groceries = dummyGroceryItems;

  void onCreate() async {
    // Navigate to the form screen using the Navigator push
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );
    if (newGrocery != null) {
      setState(() {
        groceries.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(onPressed: () => onCreate(), icon: const Icon(Icons.add)),
        ],
      ),

      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          GroceriesTab(groceries: groceries),
          SearchTab(groceries: groceries),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: app_tab.Tab.values
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              ),
            )
            .toList(),

        // const [
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.local_grocery_store),
        //     label: 'Groceries',
        //   ),
        //   BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Groceries'),
        // ],
      ),
    );
  }
}
