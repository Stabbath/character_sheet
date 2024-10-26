import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

class SkillField extends ConsumerWidget {
  final String label;
  final Provider<dynamic> skillProvider;

  const SkillField({
    super.key,
    required this.label,
    required this.skillProvider,
  });

  SkillField.fromKeyPaths({
    super.key,
    required this.label,
    required skillKeyPath,
  }) : skillProvider = getKeyPathProvider(skillKeyPath);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skill = ref.watch(skillProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        SizedBox(
          width: 50,
          child: TextField(
            controller: TextEditingController(text: skill.toString()),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              final int? newValue = int.tryParse(value);
              if (newValue != null) {
                ref.read(skill.notifier).update(label.toLowerCase(), newValue);
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
