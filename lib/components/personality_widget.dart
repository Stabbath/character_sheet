import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/text_block_input.dart';

class PersonalityWidget extends ConsumerWidget {
  final String id;
  final StateNotifierProvider<KeyPathNotifier, dynamic> traitsProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> idealsProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> bondsProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> flawsProvider;

  PersonalityWidget({
    super.key,
    required this.id,
    required traitsKeyPath,
    required idealsKeyPath,
    required bondsKeyPath,
    required flawsKeyPath,
  }) : traitsProvider = getKeyPathProvider(traitsKeyPath),
       idealsProvider = getKeyPathProvider(idealsKeyPath),
       bondsProvider = getKeyPathProvider(bondsKeyPath),
       flawsProvider = getKeyPathProvider(flawsKeyPath);

  factory PersonalityWidget.fromComponent(Component component) {
    return PersonalityWidget(
      id: component.id,
      traitsKeyPath: component.dataBindings['traits'],
      idealsKeyPath: component.dataBindings['ideals'],
      bondsKeyPath: component.dataBindings['bonds'],
      flawsKeyPath: component.dataBindings['flaws'],
    );
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final traits = ref.watch(traitsProvider);
    final ideals = ref.watch(idealsProvider);
    final bonds = ref.watch(bondsProvider);
    final flaws = ref.watch(flawsProvider);
    final traitsNotifier = ref.read(traitsProvider.notifier);
    final idealsNotifier = ref.read(idealsProvider.notifier);
    final bondsNotifier = ref.read(bondsProvider.notifier);
    final flawsNotifier = ref.read(flawsProvider.notifier);

    return Column(
      children: [
        Expanded(child: Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Personality Traits',
                initialValue: traits,
                onChanged: (newValue) {
                  traitsNotifier.update(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Ideals',
                initialValue: ideals,
                onChanged: (newValue) {
                  idealsNotifier.update(newValue);
                },
              ),
            ),
          ],
        )),
        const SizedBox(height: 16),
        Expanded(child: Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Bonds',
                initialValue: bonds,
                onChanged: (newValue) {
                  bondsNotifier.update(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Flaws',
                initialValue: flaws,
                onChanged: (newValue) {
                  flawsNotifier.update(newValue);
                },
              ),
            ),
          ]
        )),
      ],
    );
  }
}
