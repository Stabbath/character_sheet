import 'package:character_sheet/components/generic/cycle_checkbox.dart';
import 'package:character_sheet/core/layout/data_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import 'consumer_stateful_text_input.dart';

class ProficiencySkillField extends ConsumerWidget {
  final String label;
  final Map<String, DataBinding> dataBindings;

  const ProficiencySkillField({
    super.key,
    required this.label,
    required this.dataBindings,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillBonus = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['bonus']!.getInSheet(state) : null));
    final skillBonusUpdater = dataBindings['bonus']!.createStateUpdater(ref.read(sheetDataProvider.notifier));

    final skillProficiency = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['proficiency']!.getInSheet(state) : null));
    final skillProficiencyUpdater = dataBindings['proficiency']!.createStateUpdater(ref.read(sheetDataProvider.notifier));

    const proficiencyValues = [0, 0.5, 1, 2];

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
          child: CycleCheckbox(
            symbols: [
              Text('0'),
              Text('0.5'),
              Text('1'),
              Text('2'),
            ],
            initialIndex: proficiencyValues.indexOf(skillProficiency),
            onChangedIndex: ((index) => skillProficiencyUpdater(proficiencyValues[index])),
          ),
        ),
        SizedBox(
          width: 50,
          child: ConsumerStatefulTextInput(
            initialValue: skillBonus.toString(),
            textInputType: TextInputType.number,
            onChanged: (value) => skillBonusUpdater(int.tryParse(value) ?? 0),
          ),
        ),
      ],
    );
  }
}
