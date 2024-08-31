import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {super.key, this.selectedDate, required this.presentDatePicker});

  final DateTime? selectedDate;
  final void Function() presentDatePicker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          selectedDate == null
              ? 'No date selected'
              : formatter.format(selectedDate!),
        ),
        IconButton(
            onPressed: presentDatePicker,
            icon: const Icon(Icons.calendar_month))
      ],
    );
  }
}
