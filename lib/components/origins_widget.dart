import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/component.dart';
import '../core/providers.dart';

class OriginsWidget extends ConsumerWidget {
  final String id;
  final StateNotifierProvider<KeyPathNotifier, dynamic> raceProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> backgroundProvider;

  OriginsWidget({
    super.key,
    required this.id,
    required raceKeyPath,
    required backgroundKeyPath,
  }) : raceProvider = getKeyPathProvider(raceKeyPath),
       backgroundProvider = getKeyPathProvider(backgroundKeyPath);

  factory OriginsWidget.fromComponent(Component component) {
    return OriginsWidget(
      id: component.id, 
      raceKeyPath: component.dataBindings['race'],
      backgroundKeyPath: component.dataBindings['background'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final race = ref.watch(raceProvider);
    final background = ref.watch(backgroundProvider);
    final raceNotifier = ref.read(raceProvider.notifier);
    final backgroundNotifier = ref.read(backgroundProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Race'),
          controller: TextEditingController(text: race),
          onChanged: (value) => raceNotifier.update(value),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Background'),
          controller: TextEditingController(text: background),
          onChanged: (value) => backgroundNotifier.update(value),
        ),
      ],
    );
  }
}

