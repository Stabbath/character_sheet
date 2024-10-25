import 'package:flutter/material.dart';

class TextBlockInput extends StatelessWidget {
  final String title;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const TextBlockInput({
    super.key,
    this.title = '',
    this.initialValue = '',
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: null,
      maxLines: null,
      expands: true,
      controller: TextEditingController(text: initialValue),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: title.isEmpty ? null : title,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
