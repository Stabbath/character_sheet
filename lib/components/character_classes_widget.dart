import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components.dart';
import '../core/providers/providers.dart';
import 'generic/single_class_input.dart';

class CharacterClassesWidget extends Component {
  const CharacterClassesWidget({
    super.key,
    required super.definition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['list']!))) ?? [];
    final characterLevel = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['character_level']!)));
    final proficiencyBonus = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['proficiency_bonus']!)));

    final listUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['list']!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < list.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: SingleClassInput(
                    index: i,
                    className: list[i]["name"],
                    classLevel: list[i]["level"],
                    onNameChanged: (newName) {
                      var newClassList = List.from(list);
                      newClassList[i] = {
                        "name": newName,
                        "level": list[i]["level"],
                      };
                      listUpdater(newClassList);
                    },
                    onLevelChanged: (newLevel) {
                      var newClassList = List.from(list);
                      newClassList[i] = {
                        "name": list[i]["name"],
                        "level": newLevel,
                      };
                      listUpdater(newClassList);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    var newClassList = List.from(list);
                    newClassList.removeAt(i);
                    listUpdater(newClassList);
                  }
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Character Level: $characterLevel'),
            const Spacer(),
            Text('Proficiency Modifier: $proficiencyBonus'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                var newClassList = List.from(list);
                newClassList.add({"name": "", "level": 0});
                listUpdater(newClassList);
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
