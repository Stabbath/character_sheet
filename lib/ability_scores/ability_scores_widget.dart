import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ability_score_field.dart';
import 'ability_scores_provider.dart';

class AbilityScoresWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abilityScores = ref.watch(abilityScoresProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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