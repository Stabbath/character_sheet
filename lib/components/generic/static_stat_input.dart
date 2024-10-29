import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:character_sheet/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/layout/data_bindings.dart';

class StaticStatInput extends ConsumerWidget {
  final String label;
  final DataBinding statDataBinding;

  const StaticStatInput({
    super.key,
    required this.label, 
    required this.statDataBinding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stat = ref.watch(sheetDataProvider.select((state) => state != null ? statDataBinding.getInSheet(state) : null));
    final statUpdater = statDataBinding.createStateUpdater(ref.read(sheetDataProvider.notifier));

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


