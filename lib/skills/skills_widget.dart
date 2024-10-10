import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'skill_field.dart';
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
          SkillField(label: 'Acrobatics', skillValue: skills.acrobatics),
          SkillField(label: 'Animal Handling', skillValue: skills.animalHandling),
          SkillField(label: 'Arcana', skillValue: skills.arcana),
          SkillField(label: 'Athletics', skillValue: skills.athletics),
          SkillField(label: 'Deception', skillValue: skills.deception),
          SkillField(label: 'History', skillValue: skills.history),
          SkillField(label: 'Insight', skillValue: skills.insight),
          SkillField(label: 'Intimidation', skillValue: skills.intimidation),
          SkillField(label: 'Investigation', skillValue: skills.investigation),
          SkillField(label: 'Medicine', skillValue: skills.medicine),
          SkillField(label: 'Nature', skillValue: skills.nature),
          SkillField(label: 'Perception', skillValue: skills.perception),
          SkillField(label: 'Performance', skillValue: skills.performance),
          SkillField(label: 'Persuasion', skillValue: skills.persuasion),
          SkillField(label: 'Religion', skillValue: skills.religion),
          SkillField(label: 'Sleight of Hand', skillValue: skills.sleightOfHand),
          SkillField(label: 'Stealth', skillValue: skills.stealth),
          SkillField(label: 'Survival', skillValue: skills.survival),
        ],
      ),
    );
  }
}
