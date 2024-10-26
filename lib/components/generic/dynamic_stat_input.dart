import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import 'consumer_stateful_text_input.dart';

class DynamicStatInput extends ConsumerWidget {
  final String label;
  final StateNotifierProvider<KeyPathNotifier, dynamic> currentValueProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> maxValueProvider;

  const DynamicStatInput({
    super.key,
    required this.label,
    required this.currentValueProvider,
    required this.maxValueProvider,
  });

  DynamicStatInput.fromKeyPaths({
    super.key,
    required this.label,
    required currentValueKeyPath,
    required maxValueKeyPath,
  }) : currentValueProvider = getKeyPathProvider(currentValueKeyPath),
       maxValueProvider = getKeyPathProvider(maxValueKeyPath);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentValue = ref.watch(currentValueProvider);
    final maxValue = ref.watch(maxValueProvider);
    final currentValueNotifier = ref.read(currentValueProvider.notifier);
    final maxValueNotifier = ref.read(maxValueProvider.notifier);

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
                isNumeric: true,
                onChanged: (value) => currentValueNotifier.update(int.parse(value)),
              ),
            ),
            const Text(' / ', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 50,
              width: 50,
              child: ConsumerStatefulTextInput(
                initialValue: maxValue.toString(),
                isNumeric: true,
                onChanged: (value) => maxValueNotifier.update(int.parse(value)),
              )
            ),
          ],
        ),
      ],
    );
  }
}
