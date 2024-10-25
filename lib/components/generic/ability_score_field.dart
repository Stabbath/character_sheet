import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/key_path_providers.dart';

class AbilityScoreField extends ConsumerWidget {
  final String label;
  final Provider<dynamic> abilityScoreProvider;

  const AbilityScoreField({
    super.key,
    required this.label,
    required this.abilityScoreProvider,
  });

  AbilityScoreField.fromKeyPaths({
    super.key,
    required this.label,
    required abilityScoreKeyPath,
  }) : abilityScoreProvider = getKeyPathProvider(abilityScoreKeyPath);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abilityScore = ref.watch(abilityScoreProvider);
    final modifier = (abilityScore - 10) ~/ 2;

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
            controller: TextEditingController(text: abilityScore.toString()),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              final int? newScore = int.tryParse(value);
              if (newScore != null) {
                ref.read(abilityScore.notifier).update(label.toLowerCase(), newScore);
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
