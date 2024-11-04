import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/providers.dart';

class AbilityScoreField extends ConsumerWidget {
  final String label;
  final String baseValueKey;
  final String bonusValueKey;

  const AbilityScoreField({
    super.key,
    required this.label,
    required this.baseValueKey,
    required this.bonusValueKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseValue = ref.watch(sheetDataProvider.select((state) => state?.get(baseValueKey)));
    final bonusValue = ref.watch(sheetDataProvider.select((state) => state?.get(bonusValueKey)));

    final baseValueUpdater = ref.read(sheetDataProvider.notifier).getUpdater(baseValueKey);
    final bonusValueUpdater = ref.read(sheetDataProvider.notifier).getUpdater(bonusValueKey);

    final total = baseValue + bonusValue;
    final modifier = (total - 10) ~/ 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        SizedBox(
          width: 50,
          child: ConsumerStatefulTextInput(
            initialValue: baseValue.toString(),
            textInputType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) => baseValueUpdater(int.tryParse(value) ?? 0),
          ),
        ),
        const Icon(
          Icons.add,
        ),
        SizedBox(
          width: 50,
          child: ConsumerStatefulTextInput(
            initialValue: bonusValue.toString(),
            textInputType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) => bonusValueUpdater(int.tryParse(value) ?? 0),
          ),
        ),
        const Icon(
          Icons.drag_handle,
        ),
        SizedBox( 
          width: 50,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(4.0), // Optional: rounded corners
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              total.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          )
        ),
        const Icon(
          Icons.arrow_right,
        ),
        SizedBox( 
          width: 50,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              modifier >= 0 ? '+$modifier' : '$modifier',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          )
        ),
      ],
    );
  }
}
