import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:character_sheet/core/layout/data_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

class AbilityScoreField extends ConsumerWidget {
  static const requiredFields = [
    'base',
    'bonus',
  ];

  final String label;
  final Map<String, DataBinding> dataBindings;

  const AbilityScoreField({
    super.key,
    required this.label,
    required this.dataBindings,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> values = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings.map((key, value) => MapEntry(key, value.getInSheet(state))) : null))!;
    final Map<String, Function(dynamic)> updaters = dataBindings.map((key, value) => MapEntry(key, value.createStateUpdater(ref.read(sheetDataProvider.notifier))));

    final total = values['base'] + values['bonus'];
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
            initialValue: values['base'].toString(),
            textInputType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) => updaters['base']!(int.parse(value)),
          ),
        ),
        const Icon(
          Icons.add,
        ),
        SizedBox(
          width: 50,
          child: ConsumerStatefulTextInput(
            initialValue: values['bonus'].toString(),
            textInputType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) => updaters['bonus']!(int.parse(value)),
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
        ),        const Icon(
          Icons.arrow_right,
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
