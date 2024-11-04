import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components.dart';
import '../core/providers/providers.dart';
import 'generic/consumer_stateful_text_input.dart';

class BiometricsWidget extends Component {
  const BiometricsWidget({
    super.key,
    required super.definition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ageKey = definition.sourceKeys['age']!;
    final heightKey = definition.sourceKeys['height']!;
    final weightKey = definition.sourceKeys['weight']!;
    final eyesKey = definition.sourceKeys['eyes']!;
    final skinKey = definition.sourceKeys['skin']!;
    final hairKey = definition.sourceKeys['hair']!;

    final age = ref.watch(sheetDataProvider.select((state) => state?.get(ageKey)));
    final height = ref.watch(sheetDataProvider.select((state) => state?.get(heightKey)));
    final weight = ref.watch(sheetDataProvider.select((state) => state?.get(weightKey)));
    final eyes = ref.watch(sheetDataProvider.select((state) => state?.get(eyesKey)));
    final skin = ref.watch(sheetDataProvider.select((state) => state?.get(skinKey)));
    final hair = ref.watch(sheetDataProvider.select((state) => state?.get(hairKey)));

    final ageUpdater = ref.read(sheetDataProvider.notifier).getUpdater(ageKey);
    final heightUpdater = ref.read(sheetDataProvider.notifier).getUpdater(heightKey);
    final weightUpdater = ref.read(sheetDataProvider.notifier).getUpdater(weightKey);
    final eyesUpdater = ref.read(sheetDataProvider.notifier).getUpdater(eyesKey);
    final skinUpdater = ref.read(sheetDataProvider.notifier).getUpdater(skinKey);
    final hairUpdater = ref.read(sheetDataProvider.notifier).getUpdater(hairKey);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: age.toString(),
                label: 'Age',
                textInputType: TextInputType.number,
                onChanged: (value) => ageUpdater(int.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: height.toString(),
                label: 'Height',
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => heightUpdater(double.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: weight.toString(),
                label: 'Weight',
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => weightUpdater(double.tryParse(value) ?? 0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: eyes.toString(),
                label: 'Eye Color',
                onChanged: (value) => eyesUpdater(value),
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: skin.toString(),
                label: 'Skin Color',
                onChanged: (value) => skinUpdater(value),
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: hair.toString(),
                label: 'Hair Color',
                onChanged: (value) => hairUpdater(value),
                textInputType: TextInputType.text,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
