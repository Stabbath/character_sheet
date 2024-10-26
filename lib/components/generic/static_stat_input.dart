import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

class StaticStatInput extends ConsumerWidget {
  final String label;
  final Provider<dynamic> statProvider;

  const StaticStatInput({
    super.key,
    required this.label, 
    required this.statProvider,
  });

  StaticStatInput.fromKeyPath({
    super.key,
    required this.label,
    required statKeyPath,
  }) : statProvider = getKeyPathProvider(statKeyPath);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stat = ref.watch(statProvider);

    return Column(
      children: [
        Text(label),
        SizedBox(
          width: 50,
          height: 50,
          child: TextFormField(
            initialValue: stat.toString(),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8.0),
            ),
            onChanged: (newValue) {
              ref.read(stat.notifier).update(int.tryParse(newValue) ?? stat);
            },
          ),
        ),
      ],
    );
  }
}


