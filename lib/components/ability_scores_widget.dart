import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/components.dart';
import 'generic/ability_score_field.dart';
import 'generic/section_header.dart';

class AbilityScoresWidget extends Component {
  const AbilityScoresWidget({
    super.key,
    required super.definition
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Ability Scores'),
              AbilityScoreField(
                label: 'Strength',
                baseValueKey: definition.sourceKeys['strength.base']!,
                bonusValueKey: definition.sourceKeys['strength.bonus']!,
              ),
              const SizedBox(height: 10),
              AbilityScoreField(
                label: 'Dexterity',
                baseValueKey: definition.sourceKeys['dexterity.base']!,
                bonusValueKey: definition.sourceKeys['dexterity.bonus']!,
              ),
              const SizedBox(height: 10),
              AbilityScoreField(
                label: 'Constitution',
                baseValueKey: definition.sourceKeys['constitution.base']!,
                bonusValueKey: definition.sourceKeys['constitution.bonus']!,
              ),
              const SizedBox(height: 10),
              AbilityScoreField(
                label: 'Intelligence',
                baseValueKey: definition.sourceKeys['intelligence.base']!,
                bonusValueKey: definition.sourceKeys['intelligence.bonus']!,
              ),
              const SizedBox(height: 10),
              AbilityScoreField(
                label: 'Wisdom',
                baseValueKey: definition.sourceKeys['wisdom.base']!,
                bonusValueKey: definition.sourceKeys['wisdom.bonus']!,
              ),
              const SizedBox(height: 10),
              AbilityScoreField(
                label: 'Charisma',
                baseValueKey: definition.sourceKeys['charisma.base']!,
                bonusValueKey: definition.sourceKeys['charisma.bonus']!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
