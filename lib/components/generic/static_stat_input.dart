import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:character_sheet/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaticStatInput extends ConsumerWidget {
  final String label;
  final String statKey;

  const StaticStatInput({
    super.key,
    required this.label, 
    required this.statKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stat = ref.watch(sheetDataProvider.select((state) => state?.get(statKey)));

    final statUpdater = ref.read(sheetDataProvider.notifier).getUpdater(statKey);

    return Column(
      children: [
        Text(label),
        SizedBox(
          width: 50,
          height: 50,
          child: ConsumerStatefulTextInput(
            initialValue: stat.toString(),
            textInputType: TextInputType.number,
            onChanged: (value) => statUpdater(int.parse(value)),
          ),
        ),
      ],
    );
  }
}


