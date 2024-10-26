import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';

class NamesWidget extends ConsumerWidget {
  final String id;
  final StateNotifierProvider<KeyPathNotifier, dynamic> namesProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> titlesProvider;

  NamesWidget({
    super.key,
    required this.id,
    required namesKeyPath,
    required titlesKeyPath,
  }) : namesProvider = getKeyPathProvider(namesKeyPath),
       titlesProvider = getKeyPathProvider(titlesKeyPath);

  factory NamesWidget.fromComponent(Component component) {
    return NamesWidget(
      id: component.id, 
      namesKeyPath: component.dataBindings['names'],
      titlesKeyPath: component.dataBindings['titles'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    final titles = ref.watch(titlesProvider);
    final namesNotifier = ref.read(namesProvider.notifier);
    final titlesNotifier = ref.read(titlesProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: names),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            onChanged: (newValue) => namesNotifier.update(newValue),
            decoration: const InputDecoration(
              hintText: 'Character Name',
              border: InputBorder.none,
            ),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: titles),
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            onChanged: (newValue) => titlesNotifier.update(newValue),
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
