import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

class AbilityScoreField extends ConsumerWidget {
  final String label;
  final StateNotifierProvider<KeyPathNotifier, dynamic> abilityScoreProvider;

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
    final abilityScoreNotifier = ref.read(abilityScoreProvider.notifier);
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
          child: ConsumerStatefulTextInput(
            initialValue: abilityScore.toString(),
            label: label,
            isNumeric: true,
            onChanged: (value) => abilityScoreNotifier.update(int.parse(value)),
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
