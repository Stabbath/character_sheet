
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generic/text_block_input.dart';
import 'personality_provider.dart'; // Import your Riverpod provider here

class PersonalityWidget extends ConsumerWidget {
  const PersonalityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personality = ref.watch(personalityProvider);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Personality Traits',
                initialValue: personality.personalityTraits,
                onChanged: (newValue) {
                  ref.read(personalityProvider.notifier).updatePersonalityTraits(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Ideals',
                initialValue: personality.ideals,
                onChanged: (newValue) {
                  ref.read(personalityProvider.notifier).updateIdeals(newValue);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Bonds',
                initialValue: personality.bonds,
                onChanged: (newValue) {
                  ref.read(personalityProvider.notifier).updateBonds(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Flaws',
                initialValue: personality.flaws,
                onChanged: (newValue) {
                  ref.read(personalityProvider.notifier).updateFlaws(newValue);
                },
              ),
            ),
          ]
        ),
      ],
    );
  }
}
