import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import 'consumer_stateful_text_input.dart';

class SkillField extends ConsumerWidget {
  final String label;
  final StateNotifierProvider<KeyPathNotifier, dynamic> skillProvider;

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
    final skillNotifier = ref.read(skillProvider.notifier);

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
          child: ConsumerStatefulTextInput(
            initialValue: skill.toString(),
            label: label,
            isNumeric: true,
            onChanged: (value) => skillNotifier.update(int.parse(value)),
          ),
        ),
      ],
    );
  }
}
