import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController titleController;

  const TitleTextField({super.key, required this.titleController});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      maxLength: 50,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        label: Text(
          'Title',
        ),
      ),
    );
  }
}
