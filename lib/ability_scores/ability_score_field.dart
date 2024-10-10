import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ability_scores_provider.dart';

class AbilityScoreField extends ConsumerWidget {
  final String label;
  final int score;

  const AbilityScoreField({
    super.key,
    required this.label,
    required this.score,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(abilityScoresProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 50,
          child: TextField(
            controller: TextEditingController(text: score.toString()),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              final int? newScore = int.tryParse(value);
              if (newScore != null) {
                notifier.updateScore(label.toLowerCase(), newScore);
              }
            },
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
