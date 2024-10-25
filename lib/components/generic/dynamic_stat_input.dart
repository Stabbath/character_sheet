import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/key_path_providers.dart';

class DynamicStatInput extends ConsumerWidget {
  final String label;
  final Provider<dynamic> currentValueProvider;
  final Provider<dynamic> maxValueProvider;

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

    return Column(
      children: [
        Text(label),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: TextFormField(
                initialValue: currentValue.toString(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                onChanged: (value) {
                  ref.read(currentValue.notifier).update(int.tryParse(value) ?? 0);
                },
              ),
            ),
            const Text(' / ', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 50,
              width: 50,
              child: TextFormField(
                initialValue: maxValue.toString(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                onChanged: (value) {
                  ref.read(maxValue.notifier).update(int.tryParse(value) ?? 0);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
