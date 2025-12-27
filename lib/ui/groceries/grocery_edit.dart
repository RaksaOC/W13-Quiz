import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/grocery.dart';

Uuid uuid = const Uuid();

class GroceryEdit extends StatefulWidget {
  final Grocery grocery;
  final Function(Grocery) onGroceryUpdated;
  const GroceryEdit({
    super.key,
    required this.grocery,
    required this.onGroceryUpdated,
  });

  @override
  State<GroceryEdit> createState() {
    return _GroceryEditState();
  }
}

class _GroceryEditState extends State<GroceryEdit> {
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Default settings
  static const defautName = "New grocery";
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _nameController.text = widget.grocery.name;
    _quantityController.text = widget.grocery.quantity.toString();
    _selectedCategory = widget.grocery.category;
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    // Reset all fields to the initial values
    _formKey.currentState!.reset();
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();
    _selectedCategory = defaultCategory;
  }

  void onEdit() {
    if (_formKey.currentState!.validate()) {
      // Create updated grocery with form data
      final updatedGrocery = Grocery(
        id: widget.grocery.id, // Keep the same ID
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        category: _selectedCategory,
      );
      widget.onGroceryUpdated(updatedGrocery);

      Navigator.pop(context);
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a name";
    }

    if ( value.length > 50) {
      return "Enter a text no larger than 50 characters";
    }

    return null; //valid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit an item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: validateName,
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      initialValue: _selectedCategory,
                      items: GroceryCategory.values
                          .map(
                            (g) => DropdownMenuItem<GroceryCategory>(
                              value: g,
                              child: Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    color: g.color,
                                  ),
                                  SizedBox(width: 10),
                                  Text(g.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: onReset, child: const Text('Reset')),
                  ElevatedButton(
                    onPressed: onEdit,
                    child: const Text('Edit Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
