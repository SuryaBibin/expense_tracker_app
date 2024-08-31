import 'package:expense_tracker/new_expense_fields/cancel_button.dart';
import 'package:expense_tracker/new_expense_fields/category_dropdown_button.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/new_expense_fields/amount_textfield.dart';
import 'package:expense_tracker/new_expense_fields/date_picker.dart';

import 'package:expense_tracker/new_expense_fields/save_button.dart';
import 'package:expense_tracker/new_expense_fields/title_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });

  final void Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  var _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title,amount,date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
          category: _selectedCategory,
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!),
    );
    Navigator.pop(context);
  }

  void _cancelExpense() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        print(constraints.maxWidth);
        double width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:
                              TitleTextField(titleController: _titleController),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: AmountTextField(
                              amountController: _amountController),
                        ),
                      ],
                    )
                  else
                    TitleTextField(titleController: _titleController),
                  if (width >= 600)
                    Row(
                      children: [
                        const CategoryDropdownButton(),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: DatePicker(
                            presentDatePicker: _presentDatePicker,
                            selectedDate: _selectedDate,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: AmountTextField(
                            amountController: _amountController,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DatePicker(
                            presentDatePicker: _presentDatePicker,
                            selectedDate: _selectedDate,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        CancelButton(onCancelExpense: _cancelExpense),
                        SaveButton(onSubmitExpenseData: _submitExpenseData),
                      ],
                    )
                  else
                    Row(
                      children: [
                        const CategoryDropdownButton(),
                        const Spacer(),
                        CancelButton(onCancelExpense: _cancelExpense),
                        SaveButton(onSubmitExpenseData: _submitExpenseData),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
