import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
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
    return ConsumerStatefulTextInput(
      minLines: null,
      maxLines: null,
      expands: true,
      initialValue: initialValue,
      onChanged: onChanged,
      label: title,
      isNumeric: false,
    );
  }
}
