import 'package:character_sheet/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/data_bindings.dart';
import '../core/layout/component.dart';
import '../formulae/character_level_from_list.dart';
import '../formulae/proficiency_bonus.dart';
import 'generic/single_class_input.dart';

class CharacterClassesWidget extends ConsumerWidget {
  final String id;
  final DataBinding dataBinding;
  
  const CharacterClassesWidget({
    super.key,
    required this.id,
    required this.dataBinding,
  });

  factory CharacterClassesWidget.fromComponent(Component component) {
    return CharacterClassesWidget(
      id: component.id,
      dataBinding: component.dataBindings['list']!,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classList = ref.watch(sheetDataProvider.select((state) => state != null ? dataBinding.getInSheet(state) : null)) ?? [];
    final updater = dataBinding.createStateUpdater(ref.read(sheetDataProvider.notifier));

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
                      updater(newClassList);
                    },
                    onLevelChanged: (newLevel) {
                      var newClassList = List.from(classList);
                      newClassList[i] = {
                        "name": classList[i]["name"],
                        "level": newLevel,
                      };
                      updater(newClassList);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    var newClassList = List.from(classList);
                    newClassList.removeAt(i);
                    updater(newClassList);
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
                updater(newClassList);
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
