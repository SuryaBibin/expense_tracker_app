import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expense, required this.onRemoveExpense});

  final List<Expense> expense;
  final Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: ((context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.7),
            margin: EdgeInsets.symmetric(
                horizontal: CardTheme.of(context).margin!.horizontal),
          ),
          key: ValueKey(expense[index]),
          onDismissed: (direction) {
            onRemoveExpense(expense[index]);
          },
          child: ExpenseItem(expense: expense[index]))),
    );
  }
}
