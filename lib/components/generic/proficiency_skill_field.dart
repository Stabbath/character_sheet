import 'package:character_sheet/components/generic/cycle_checkbox.dart';
import 'package:character_sheet/core/layout/data_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/layout/formulae.dart';
import '../../core/providers.dart';
import 'consumer_stateful_text_input.dart';

class ProficiencySkillField extends ConsumerWidget {
  final String label;
  final Map<String, DataBinding> dataBindings;
  final DataBinding proficiencyBinding;

  const ProficiencySkillField({
    super.key,
    required this.label,
    required this.dataBindings,
    required this.proficiencyBinding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillBonus = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['bonus']!.getInSheet(state) : null));
    final skillBonusUpdater = dataBindings['bonus']!.createStateUpdater(ref.read(sheetDataProvider.notifier));

    final skillProficiency = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['proficiency']!.getInSheet(state) : null));
    final skillProficiencyUpdater = dataBindings['proficiency']!.createStateUpdater(ref.read(sheetDataProvider.notifier));

    const proficiencyValues = [0, 0.5, 1, 2];

    final Formula proficiencyFormula = ref.watch(layoutProvider.select((state) => state?.getFormulaFromOutKey(proficiencyBinding.outKey)))!;
    final total = (skillProficiency * proficiencyFormula.evaluate(ref) + skillBonus).floor();

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
              Text('-'),
              Text('H'),
              Text('P'),
              Text('E'),
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
            textAlign: TextAlign.center,
            onChanged: (value) => skillBonusUpdater(int.tryParse(value) ?? 0),
          ),
        ),
        const Icon(
          Icons.drag_handle,
        ),
        SizedBox(
          width: 50,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(4.0), // Optional: rounded corners
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              total >= 0 ? '+$total' : '$total',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          )
        ),
      ],
    );
  }
}
