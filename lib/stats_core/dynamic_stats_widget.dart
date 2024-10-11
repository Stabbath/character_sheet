import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generic/dynamic_stat_input.dart';
import '../generic/static_stat_input.dart';
import 'stats_core_provider.dart';

class DynamicStatsWidget extends ConsumerWidget {
  const DynamicStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsCore = ref.watch(statsCoreProvider);

    return Column(
      children: [
        ...statsCore.dynamicStats.entries.map(
          (entry) => DynamicStatInput(
            label: entry.key,
            currentValue: entry.value['currentValue'] as int,
            maxValue: entry.value['maxValue'] as int,
            onChanged: (updatedStat) {
              ref.read(statsCoreProvider.notifier).updateDynamicStat(entry.key, updatedStat['currentValue'] as int, updatedStat['maxValue'] as int);
            },
          ),
        ),
        ...statsCore.staticStats.entries.map(
          (entry) => StaticStatInput(
            label: entry.key,
            value: entry.value,
            onChanged: (newValue) {
              ref.read(statsCoreProvider.notifier).updateStaticStat(entry.key, newValue);
            },
          ),
        ),
      ],
    );
  }
}

