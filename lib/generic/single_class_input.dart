import 'package:flutter/material.dart';

import '../character_classes/character_class_model.dart';

class SingleClassInput extends StatelessWidget {
  final int index;
  final CharacterClassModel characterClass;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<int> onLevelChanged;

  const SingleClassInput({
    super.key,
    required this.index,
    required this.characterClass,
    required this.onNameChanged,
    required this.onLevelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: characterClass.name,
            decoration: const InputDecoration(labelText: 'Class'),
            onChanged: onNameChanged,
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 60,
          child: TextFormField(
            initialValue: characterClass.level.toString(),
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
