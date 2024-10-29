import 'package:character_sheet/core/data_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import 'consumer_stateful_text_input.dart';

class DynamicStatInput extends ConsumerWidget {
  final String label;
  final DataBinding currentValueDataBinding;
  final DataBinding maxValueDataBinding;

  const DynamicStatInput({
    super.key,
    required this.label,
    required this.currentValueDataBinding,
    required this.maxValueDataBinding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentValue = ref.watch(sheetDataProvider.select((state) => state != null ? currentValueDataBinding.getInSheet(state) : null));
    final maxValue = ref.watch(sheetDataProvider.select((state) => state != null ? maxValueDataBinding.getInSheet(state) : null));
    final currentValueUpdater = currentValueDataBinding.createStateUpdater(ref.read(sheetDataProvider.notifier));
    final maxValueUpdater = maxValueDataBinding.createStateUpdater(ref.read(sheetDataProvider.notifier));

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
