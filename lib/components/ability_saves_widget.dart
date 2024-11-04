import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components.dart';
import '../utils/string_utils.dart';
import 'generic/proficiency_skill_field.dart';
import 'generic/section_header.dart';

class AbilitySavesWidget extends Component {
  const AbilitySavesWidget({
    super.key,
    required super.definition,
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
              const SectionHeader(title: 'Ability Saves'),
              ...definition.type.getIterableSourceKeys().map((field) {
                return ProficiencySkillField(
                  label: underscoreToNormal(field),
                  bonusValueKey: definition.sourceKeys['$field.bonus']!,
                  proficiencyTierKey: definition.sourceKeys['$field.proficiency']!,
                  proficiencyBonusKey: definition.sourceKeys['proficiency_bonus']!,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
