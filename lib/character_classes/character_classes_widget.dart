import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'character_class_model.dart';
import 'character_classes_provider.dart';
import 'single_class_input.dart';

class CharacterClassesWidget extends ConsumerWidget {
  const CharacterClassesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterClasses = ref.watch(characterClassesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < characterClasses.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: SingleClassInput(
                    index: i,
                    characterClass: characterClasses[i],
                    onNameChanged: (newName) {
                      final updatedClass = CharacterClassModel(
                        name: newName,
                        level: characterClasses[i].level,
                      );
                      ref
                        .read(characterClassesProvider.notifier)
                        .updateClass(i, updatedClass);
                    },
                    onLevelChanged: (newLevel) {
                      final updatedClass = CharacterClassModel(
                        name: characterClasses[i].name,
                        level: newLevel,
                      );
                      ref
                        .read(characterClassesProvider.notifier)
                        .updateClass(i, updatedClass);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => ref
                    .read(characterClassesProvider.notifier)
                    .removeClass(i),
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () =>
                ref.read(characterClassesProvider.notifier).addClass(),
              icon: const Icon(Icons.add),
              label: const Text('Add Class'),
            ),
          ],
        ),
      ],
    );
  }
}
