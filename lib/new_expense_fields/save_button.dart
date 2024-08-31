import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onSubmitExpenseData});
  final void Function() onSubmitExpenseData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSubmitExpenseData,
      child: const Text(
        'save expense',
      ),
    );
  }
}
