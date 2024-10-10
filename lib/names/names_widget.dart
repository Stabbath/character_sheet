import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'names_provider.dart';

class NamesWidget extends ConsumerWidget {
  const NamesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    final notifier = ref.read(namesProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: names.name),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            onSubmitted: (newValue) => notifier.updateName(newValue),
            decoration: const InputDecoration(
              hintText: 'Character Name',
              border: InputBorder.none,
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: names.titles),
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            onSubmitted: (newValue) => notifier.updateTitles(newValue),
            decoration: const InputDecoration(
              hintText: 'Titles',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
