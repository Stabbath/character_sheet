import 'package:character_sheet/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/components.dart';
import 'generic/consumer_stateful_text_input.dart';

class OriginsWidget extends Component {
  const OriginsWidget({
    super.key,
    required super.definition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final race = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['race']!)));
    final background = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['background']!)));

    final raceUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['race']!);
    final backgroundUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['background']!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConsumerStatefulTextInput(
          initialValue: race,
          label: 'Race',
          onChanged: (value) => raceUpdater(value),
          textInputType: TextInputType.text,
        ),
        const SizedBox(height: 16),
        ConsumerStatefulTextInput(
          initialValue: background,
          label: 'Background',
          onChanged: (value) => backgroundUpdater(value),
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}
