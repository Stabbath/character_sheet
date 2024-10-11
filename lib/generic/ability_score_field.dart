import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ability_scores/ability_scores_provider.dart';

class AbilityScoreField extends ConsumerWidget {
  final String label;
  final int score;
  final int modifier;

  const AbilityScoreField({
    super.key,
    required this.label,
    required this.score,
  }) : modifier = (score - 10) ~/ 2;

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
        const Spacer(),
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
        const Icon(
          Icons.arrow_right,
        ),
        SizedBox( 
          width: 50,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(4.0), // Optional: rounded corners
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              modifier >= 0 ? '+$modifier' : '$modifier',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          )
        ),
      ],
    );
  }
}
