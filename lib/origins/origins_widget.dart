import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'origins_provider.dart';

class OriginsWidget extends ConsumerWidget {
  const OriginsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final origins = ref.watch(originsProvider);
    final originsNotifier = ref.read(originsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Race'),
          controller: TextEditingController(text: origins.race),
          onChanged: (value) => originsNotifier.updateRace(value),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(labelText: 'Background'),
          controller: TextEditingController(text: origins.background),
          onChanged: (value) => originsNotifier.updateBackground(value),
        ),
      ],
    );
  }
}
