import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../generic/ability_score_field.dart';
import '../generic/section_header.dart';
import 'ability_scores_provider.dart';

class AbilityScoresWidget extends ConsumerWidget {
  const AbilityScoresWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abilityScores = ref.watch(abilityScoresProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Ability Scores'),
          AbilityScoreField(label: 'Strength', score: abilityScores.strength),
          const SizedBox(height: 10),
          AbilityScoreField(label: 'Dexterity', score: abilityScores.dexterity),
          const SizedBox(height: 10),
          AbilityScoreField(label: 'Constitution', score: abilityScores.constitution),
          const SizedBox(height: 10),
          AbilityScoreField(label: 'Intelligence', score: abilityScores.intelligence),
          const SizedBox(height: 10),
          AbilityScoreField(label: 'Wisdom', score: abilityScores.wisdom),
          const SizedBox(height: 10),
          AbilityScoreField(label: 'Charisma', score: abilityScores.charisma),
        ],
      ),
    );
  }
}