import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class CategoryDropdownButton extends StatefulWidget {
  const CategoryDropdownButton({super.key});

  @override
  State<CategoryDropdownButton> createState() {
    return _CategoryDropdownButtonState();
  }
}

class _CategoryDropdownButtonState extends State<CategoryDropdownButton> {
  @override
  Widget build(BuildContext context) {
    var _selectedCategory = Category.leisure;

    return DropdownButton(
        value: _selectedCategory,
        items: Category.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name.toUpperCase(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedCategory = value;
          });
        });
  }
}
