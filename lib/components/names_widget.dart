import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components.dart';
import '../core/providers/providers.dart';

class NamesWidget extends Component {
  const NamesWidget({
    super.key,
    required super.definition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['names']!)));
    final titles = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['titles']!)));

    final namesUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['names']!);
    final titlesUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['titles']!);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: names),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            onChanged: (newValue) => namesUpdater(newValue),
            decoration: const InputDecoration(
              hintText: 'Character Name',
              border: InputBorder.none,
            ),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: titles),
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            onChanged: (newValue) => titlesUpdater(newValue),
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
