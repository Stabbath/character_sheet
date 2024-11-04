import 'package:character_sheet/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/components.dart';
import 'generic/proficiency_skill_field.dart';
import 'generic/section_header.dart';

class SkillsWidget extends Component {
  const SkillsWidget({
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
              const SectionHeader(title: 'Skills'),
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
