import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
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
          child: ConsumerStatefulTextInput(
            onChanged: onSpellNameChanged, 
            initialValue: spellName,
            textInputType: TextInputType.text,
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
