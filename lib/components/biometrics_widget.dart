import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';

class BiometricsWidget extends ConsumerWidget {
  final String id;
  final StateNotifierProvider<KeyPathNotifier, dynamic> ageProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> heightProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> weightProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> eyesProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> skinProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> hairProvider;

  BiometricsWidget({
    super.key,
    required this.id,
    required ageKeyPath,
    required heightKeyPath,
    required weightKeyPath,
    required eyesKeyPath,
    required skinKeyPath,
    required hairKeyPath,
  }) : ageProvider = getKeyPathProvider(ageKeyPath),
       heightProvider = getKeyPathProvider(heightKeyPath),
       weightProvider = getKeyPathProvider(weightKeyPath),
       eyesProvider = getKeyPathProvider(eyesKeyPath),
       skinProvider = getKeyPathProvider(skinKeyPath),
       hairProvider = getKeyPathProvider(hairKeyPath);

  factory BiometricsWidget.fromComponent(Component component) {
    return BiometricsWidget(
      id: component.id,
      ageKeyPath: component.dataBindings['age'],
      heightKeyPath: component.dataBindings['height'],
      weightKeyPath: component.dataBindings['weight'],
      eyesKeyPath: component.dataBindings['eyes'],
      skinKeyPath: component.dataBindings['skin'],
      hairKeyPath: component.dataBindings['hair'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final age = ref.watch(ageProvider);
    final height = ref.watch(heightProvider);
    final weight = ref.watch(weightProvider);
    final eyes = ref.watch(eyesProvider);
    final skin = ref.watch(skinProvider);
    final hair = ref.watch(hairProvider);
    final ageNotifier = ref.read(ageProvider.notifier);
    final heightNotifier = ref.read(heightProvider.notifier);
    final weightNotifier = ref.read(weightProvider.notifier);
    final eyesNotifier = ref.read(eyesProvider.notifier);
    final skinNotifier = ref.read(skinProvider.notifier);
    final hairNotifier = ref.read(hairProvider.notifier);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: age.toString(),
                label: 'Age',
                textInputType: TextInputType.number,
                onChanged: (value) => ageNotifier.update(int.parse(value)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: height.toString(),
                label: 'Height',
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => heightNotifier.update(double.parse(value)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: weight.toString(),
                label: 'Weight',
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => weightNotifier.update(double.parse(value)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: eyes.toString(),
                label: 'Eye Color',
                onChanged: (value) => eyesNotifier.update(value),
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: skin.toString(),
                label: 'Skin Color',
                onChanged: (value) => skinNotifier.update(value),
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: hair.toString(),
                label: 'Hair Color',
                onChanged: (value) => hairNotifier.update(value),
                textInputType: TextInputType.text,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
