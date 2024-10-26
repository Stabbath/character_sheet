import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

class StaticStatInput extends ConsumerWidget {
  final String label;
  final StateNotifierProvider<KeyPathNotifier, dynamic> statProvider;

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
    final statNotifier = ref.read(statProvider.notifier);

    return Column(
      children: [
        Text(label),
        SizedBox(
          width: 50,
          height: 50,
          child: ConsumerStatefulTextInput(
            initialValue: stat.toString(),
            isNumeric: true,
            onChanged: (value) => statNotifier.update(int.parse(value)),
          ),
        ),
      ],
    );
  }
}


