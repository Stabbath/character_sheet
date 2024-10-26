import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/single_class_input.dart';

class CharacterClassesWidget extends ConsumerWidget {
  final String id;
  final StateNotifierProvider<KeyPathNotifier, dynamic> classListProvider;
  
  CharacterClassesWidget({
    super.key,
    required this.id,
    required classListKeyPath,
  }) : classListProvider = getKeyPathProvider(classListKeyPath);

  factory CharacterClassesWidget.fromComponent(Component component) {
    return CharacterClassesWidget(
      id: component.id,
      classListKeyPath: component.dataBindings['list'],
    );
  }

  num getTotalLevel(WidgetRef ref) {
    final classList = ref.watch(classListProvider);
    num totalLevel = 0;
    for (int i = 0; i < classList.length; i++) {
      totalLevel += classList[i]["level"];
    }
    return totalLevel;
  }

  num getProficiencyBonus(WidgetRef ref) {
    final totalLevel = getTotalLevel(ref);
    return ((totalLevel - 1) / 4).floor() + 2;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classList = ref.watch(classListProvider);
    final classListNotifier = ref.read(classListProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < classList.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: SingleClassInput(
                    index: i,
                    className: classList[i]["name"],
                    classLevel: classList[i]["level"],
                    onNameChanged: (newName) {
                      var newClassList = List.from(classList);
                      newClassList[i] = {
                        "name": newName,
                        "level": classList[i]["level"],
                      };
                      classListNotifier.update(newClassList);
                    },
                    onLevelChanged: (newLevel) {
                      var newClassList = List.from(classList);
                      newClassList[i] = {
                        "name": classList[i]["name"],
                        "level": newLevel,
                      };
                      classListNotifier.update(newClassList);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    var newClassList = List.from(classList);
                    newClassList.removeAt(i);
                    classListNotifier.update(newClassList);
                  }
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Character Level: ${getTotalLevel(ref)}'),
            const Spacer(),
            Text('Proficiency Modifier: ${getProficiencyBonus(ref)}'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                var newClassList = List.from(classList);
                newClassList.add({"name": "", "level": 0});
                classListNotifier.update(newClassList);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Class'),
            ),
          ],
        ),
      ],
    );
  }
}
