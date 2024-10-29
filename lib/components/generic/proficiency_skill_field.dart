import 'package:character_sheet/components/generic/cycle_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import 'consumer_stateful_text_input.dart';

class ProficiencySkillField extends ConsumerWidget {
  final String label;
  final Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>> providers;

  const ProficiencySkillField({
    super.key,
    required this.label,
    required this.providers,
  });

  ProficiencySkillField.fromKeyPaths({
    super.key,
    required this.label,
    required skillBonusKeyPath,
    required skillProficiencyKeyPath,
  }) : providers = {
    'bonus': getKeyPathProvider(skillBonusKeyPath),
    'proficiency': getKeyPathProvider(skillProficiencyKeyPath),
  };

  ProficiencySkillField.fromProviders({
    super.key,
    required this.label,
    required skillBonusProvider,
    required skillProficiencyProvider,
  }) : providers = {
    'bonus': skillBonusProvider,
    'proficiency': skillProficiencyProvider,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillBonus = ref.watch(providers['bonus']!);
    final skillBonusNotifier = ref.read(providers['bonus']!.notifier);

    final skillProficiency = ref.watch(providers['proficiency']!) as int;
    final skillProficiencyNotifier = ref.read(providers['proficiency']!.notifier);

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
            symbols: [Text('0'), Text('1'), Text('2')],
            initialIndex: skillProficiency,
            onChangedIndex: ((index) => skillProficiencyNotifier.update(index)),
          )
        ),
        SizedBox(
          width: 50,
          child: ConsumerStatefulTextInput(
            initialValue: skillBonus.toString(),
            textInputType: TextInputType.number,
            onChanged: (value) => skillBonusNotifier.update(int.parse(value)),
          ),
        ),
      ],
    );
  }
}
