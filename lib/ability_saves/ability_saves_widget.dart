import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generic/section_header.dart';
import '../generic/skill_field.dart';
import 'ability_saves_provider.dart';

class AbilitySavesWidget extends ConsumerWidget {
  const AbilitySavesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abilityScores = ref.watch(abilityScoresProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Ability Saves'),
          SkillField(label: 'Strength', value: abilityScores.strength),
          const SizedBox(height: 10),
          SkillField(label: 'Dexterity', value: abilityScores.dexterity),
          const SizedBox(height: 10),
          SkillField(label: 'Constitution', value: abilityScores.constitution),
          const SizedBox(height: 10),
          SkillField(label: 'Intelligence', value: abilityScores.intelligence),
          const SizedBox(height: 10),
          SkillField(label: 'Wisdom', value: abilityScores.wisdom),
          const SizedBox(height: 10),
          SkillField(label: 'Charisma', value: abilityScores.charisma),
        ],
      ),
    );
  }
}