import 'package:flutter/material.dart';

class SingleSpellInput extends StatelessWidget {
  final String spellName;
  final bool isPrepared;
  final ValueChanged<String> onSpellNameChanged;
  final ValueChanged<bool> onPreparedChanged;
  final VoidCallback onRemove;

  const SingleSpellInput({
    super.key,
    required this.spellName,
    required this.isPrepared,
    required this.onSpellNameChanged,
    required this.onPreparedChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(labelText: 'Spell'),
            controller: TextEditingController(text: spellName),
            onChanged: onSpellNameChanged,
          ),
        ),
        const SizedBox(width: 8),
        Checkbox(
          value: isPrepared,
          onChanged: (value) => onPreparedChanged(value ?? false),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: onRemove,
        ),
      ],
    );
  }
}
