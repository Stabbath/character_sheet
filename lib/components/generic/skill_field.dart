import 'package:character_sheet/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/layout/data_bindings.dart';
import 'consumer_stateful_text_input.dart';

class SkillField extends ConsumerWidget {
  final String label;
  final DataBinding skillDataBinding;

  const SkillField({
    super.key,
    required this.label,
    required this.skillDataBinding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skill = ref.watch(sheetDataProvider.select((state) => state != null ? skillDataBinding.getInSheet(state) : null));
    final skillUpdater = skillDataBinding.createStateUpdater(ref.read(sheetDataProvider.notifier));

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
