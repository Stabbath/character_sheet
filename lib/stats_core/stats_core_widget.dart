import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generic/dynamic_stat_input.dart';
import '../generic/static_stat_input.dart';
import 'stats_core_provider.dart';

class StatsCoreWidget extends ConsumerWidget {
  const StatsCoreWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsCore = ref.watch(statsCoreProvider);

    return Column(
      children: [
        Expanded(
          child: Row(children: [
            Expanded(
              child: DynamicStatInput(
                label: 'Hit Points',
                currentValue: statsCore.dynamicStats['hp']?['currentValue'] ?? 0,
                maxValue: statsCore.dynamicStats['hp']?['maxValue'] ?? 0,
                onChanged: (updatedStat) {
                  ref.read(statsCoreProvider.notifier).updateDynamicStat('hp', updatedStat['currentValue'] as int, updatedStat['maxValue'] as int);
                },
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Temporary Hit Points',
                value: statsCore.staticStats['temp_hp'] ?? 0,
                onChanged: (newValue) {
                  ref.read(statsCoreProvider.notifier).updateStaticStat('temp_hp', newValue);
                },
              ),
            ),
            Expanded(
              child: DynamicStatInput(
                label: 'Exhaustion',
                currentValue: statsCore.dynamicStats['exhaustion']?['currentValue'] ?? 0,
                maxValue: statsCore.dynamicStats['exhaustion']?['maxValue'] ?? 0,
                onChanged: (updatedStat) {
                  ref.read(statsCoreProvider.notifier).updateDynamicStat('exhaustion', updatedStat['currentValue'] as int, updatedStat['maxValue'] as int);
                },
              ),
            ),
          ],),
        ),
        Expanded(
          child: Row(children: [
            Expanded(
              child: StaticStatInput(
                label: 'Armor Class',
                value: statsCore.staticStats['armor_class'] ?? 0,
                onChanged: (newValue) {
                  ref.read(statsCoreProvider.notifier).updateStaticStat('armor_class', newValue);
                },
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Initiative',
                value: statsCore.staticStats['initiative'] ?? 0,
                onChanged: (newValue) {
                  ref.read(statsCoreProvider.notifier).updateStaticStat('initiative', newValue);
                },
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Speed',
                value: statsCore.staticStats['speed'] ?? 0,
                onChanged: (newValue) {
                  ref.read(statsCoreProvider.notifier).updateStaticStat('speed', newValue);
                },
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Proficiency Bonus',
                value: statsCore.staticStats['proficiency_bonus'] ?? 0,
                onChanged: (newValue) {
                  ref.read(statsCoreProvider.notifier).updateStaticStat('proficiency_bonus', newValue);
                },
              ),
            ),
          ],),
        ),
      ],
    );
  }
}