import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:flutter/material.dart';

class SingleClassInput extends StatelessWidget {
  final int index;
  final String className;
  final int classLevel;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<int> onLevelChanged;

  const SingleClassInput({
    super.key,
    required this.index,
    required this.className,
    required this.classLevel,
    required this.onNameChanged,
    required this.onLevelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConsumerStatefulTextInput(
            label: 'Class',
            border: null,
            initialValue: className,
            textInputType: TextInputType.text,
            onChanged: onNameChanged,
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 60,
          child: ConsumerStatefulTextInput(
            label: 'Level',
            border: null,
            initialValue: classLevel.toString(),
            textInputType: TextInputType.number,
            onChanged: (value) {
              final parsedValue = int.tryParse(value) ?? 0;
              onLevelChanged(parsedValue);
            },
          ),
        ),
      ],
    );
  }
}
