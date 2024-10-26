import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/single_class_input.dart';

class CharacterClassesWidget extends ConsumerWidget {
  final String id;
  final Provider<dynamic> classListProvider;
  
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classList = ref.watch(classListProvider);

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
                      ref.read(classList.notifier).update(newClassList);
                    },
                    onLevelChanged: (newLevel) {
                      var newClassList = List.from(classList);
                      newClassList[i] = {
                        "name": classList[i]["name"],
                        "level": newLevel,
                      };
                      ref.read(classList.notifier).update(newClassList);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => ref
                    .read(classList.notifier)
                    .removeClass(i),
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Character Level: ${ref.read(classList.notifier).getTotalLevel()}'),
            const Spacer(),
            Text('Proficiency Modifier: ${ref.read(classList.notifier).getProficiencyBonus()}'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                var newClassList = List.from(classList);
                newClassList.add({"name": "", "level": 0});
                ref.read(classList.notifier).update(newClassList);
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
