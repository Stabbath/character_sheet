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
          child: TextFormField(
            initialValue: className,
            decoration: const InputDecoration(labelText: 'Class'),
            onChanged: onNameChanged,
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 60,
          child: TextFormField(
            initialValue: classLevel.toString(),
            decoration: const InputDecoration(labelText: 'Level'),
            keyboardType: TextInputType.number,
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
