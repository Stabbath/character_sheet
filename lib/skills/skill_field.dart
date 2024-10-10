import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'skills_provider.dart'; // Make sure to import the file where the provider is defined

class SkillField extends ConsumerWidget {
  final String label;
  final int skillValue;

  const SkillField({
    super.key,
    required this.label,
    required this.skillValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(skillsProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 50,
          child: TextField(
            controller: TextEditingController(text: skillValue.toString()),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              final int? newValue = int.tryParse(value);
              if (newValue != null) {
                notifier.updateSkill(label.toLowerCase(), newValue);
              }
            },
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
