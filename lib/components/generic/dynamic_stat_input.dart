import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/providers.dart';
import 'consumer_stateful_text_input.dart';

class DynamicStatInput extends ConsumerWidget {
  final String label;
  final String currentValueKey;
  final String maxValueKey;

  const DynamicStatInput({
    super.key,
    required this.label,
    required this.currentValueKey,
    required this.maxValueKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentValue = ref.watch(sheetDataProvider.select((state) => state?.get(currentValueKey)));
    final maxValue = ref.watch(sheetDataProvider.select((state) => state?.get(maxValueKey)));

    final currentValueUpdater = ref.read(sheetDataProvider.notifier).getUpdater(currentValueKey);
    final maxValueUpdater = ref.read(sheetDataProvider.notifier).getUpdater(maxValueKey);

    return Column(
      children: [
        Text(label),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ConsumerStatefulTextInput(
                initialValue: currentValue.toString(),
                textInputType: TextInputType.number,
                onChanged: (value) => currentValueUpdater(int.tryParse(value) ?? 0),
              ),
            ),
            const Text(' / ', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 50,
              width: 50,
              child: ConsumerStatefulTextInput(
                initialValue: maxValue.toString(),
                textInputType: TextInputType.number,
                onChanged: (value) => maxValueUpdater(int.tryParse(value) ?? 0),
              )
            ),
          ],
        ),
      ],
    );
  }
}
