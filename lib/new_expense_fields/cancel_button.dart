import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.onCancelExpense});
  final void Function() onCancelExpense;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onCancelExpense,
      child: const Text(
        'Cancel',
      ),
    );
  }
}
