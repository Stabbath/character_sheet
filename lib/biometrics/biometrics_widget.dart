import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'biometrics_provider.dart';

class BiometricsWidget extends ConsumerWidget {
  const BiometricsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(biometricsProvider.notifier);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (value) => notifier.updateAge(int.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.number,
                onChanged: (value) => notifier.updateHeight(double.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                onChanged: (value) => notifier.updateWeight(double.tryParse(value) ?? 0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Eye Color'),
                onChanged: (value) => notifier.updateEyes(value),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Skin Color'),
                onChanged: (value) => notifier.updateSkin(value),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Hair Color'),
                onChanged: (value) => notifier.updateHair(value),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
