import 'package:character_sheet/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'consumer_stateful_text_input.dart';

class SkillField extends ConsumerWidget {
  final String label;
  final String skillKey;

  const SkillField({
    super.key,
    required this.label,
    required this.skillKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skill = ref.watch(sheetDataProvider.select((state) => state?.get(skillKey)));

    final skillUpdater = ref.read(sheetDataProvider.notifier).getUpdater(skillKey);

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
            textInputType: TextInputType.number,
            onChanged: (value) => skillUpdater(int.parse(value)),
          ),
        ),
      ],
    );
  }
}
