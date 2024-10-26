import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';

class NamesWidget extends ConsumerWidget {
  final String id;
  final Provider<dynamic> namesProvider;
  final Provider<dynamic> titlesProvider;

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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: names),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            onSubmitted: (newValue) => ref.read(names.notifier).update(newValue),
            decoration: const InputDecoration(
              hintText: 'Character Name',
              border: InputBorder.none,
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: titles),
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            onSubmitted: (newValue) => ref.read(titles.notifier).update(newValue),
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
