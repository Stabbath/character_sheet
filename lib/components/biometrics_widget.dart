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
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: age.toString()),
                onChanged: (value) => ageNotifier.update(int.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: height.toString()),
                onChanged: (value) => heightNotifier.update(double.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: weight.toString()),
                onChanged: (value) => weightNotifier.update(double.tryParse(value) ?? 0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Eye Color'),
                controller: TextEditingController(text: eyes.toString()),
                onChanged: (value) => eyesNotifier.update(value),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Skin Color'),
                controller: TextEditingController(text: skin.toString()),
                onChanged: (value) => skinNotifier.update(value),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Hair Color'),
                controller: TextEditingController(text: hair.toString()),
                onChanged: (value) => hairNotifier.update(value),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
