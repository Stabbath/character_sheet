import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../generic/section_header.dart';
import '../generic/skill_field.dart';
import 'skills_provider.dart';

class SkillsWidget extends ConsumerWidget {
  const SkillsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = ref.watch(skillsProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Skills'),
          SkillField(label: 'Acrobatics', value: skills.acrobatics),
          SkillField(label: 'Animal Handling', value: skills.animalHandling),
          SkillField(label: 'Arcana', value: skills.arcana),
          SkillField(label: 'Athletics', value: skills.athletics),
          SkillField(label: 'Deception', value: skills.deception),
          SkillField(label: 'History', value: skills.history),
          SkillField(label: 'Insight', value: skills.insight),
          SkillField(label: 'Intimidation', value: skills.intimidation),
          SkillField(label: 'Investigation', value: skills.investigation),
          SkillField(label: 'Medicine', value: skills.medicine),
          SkillField(label: 'Nature', value: skills.nature),
          SkillField(label: 'Perception', value: skills.perception),
          SkillField(label: 'Performance', value: skills.performance),
          SkillField(label: 'Persuasion', value: skills.persuasion),
          SkillField(label: 'Religion', value: skills.religion),
          SkillField(label: 'Sleight of Hand', value: skills.sleightOfHand),
          SkillField(label: 'Stealth', value: skills.stealth),
          SkillField(label: 'Survival', value: skills.survival),
        ],
      ),
    );
  }
}
