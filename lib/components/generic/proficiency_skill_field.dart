import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/providers.dart';
import 'consumer_stateful_text_input.dart';
import 'cycle_checkbox.dart';

class ProficiencySkillField extends ConsumerWidget {
  final String label;
  final String bonusValueKey;
  final String proficiencyTierKey;
  final String proficiencyBonusKey;

  const ProficiencySkillField({
    super.key,
    required this.label,
    required this.bonusValueKey,
    required this.proficiencyTierKey,
    required this.proficiencyBonusKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bonusValue = ref.watch(sheetDataProvider.select((state) => state?.get(bonusValueKey)));
    final proficiencyTier = ref.watch(sheetDataProvider.select((state) => state?.get(proficiencyTierKey)));
    final proficiencyBonus = ref.watch(sheetDataProvider.select((state) => state?.get(proficiencyBonusKey)));

    final bonusValueUpdater = ref.read(sheetDataProvider.notifier).getUpdater(bonusValueKey);
    final proficiencyTierUpdater = ref.read(sheetDataProvider.notifier).getUpdater(proficiencyTierKey);

    const proficiencyValues = [0, 0.5, 1, 2];

    final total = (proficiencyTier * proficiencyBonus + bonusValue).floor();

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
            initialIndex: proficiencyValues.indexOf(proficiencyTier),
            onChangedIndex: ((index) => proficiencyTierUpdater(proficiencyValues[index])),
          ),
        ),
        SizedBox(
          width: 50,
          child: ConsumerStatefulTextInput(
            initialValue: bonusValue.toString(),
            textInputType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) => bonusValueUpdater(int.tryParse(value) ?? 0),
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
