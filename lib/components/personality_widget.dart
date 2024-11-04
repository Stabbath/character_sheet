import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components.dart';
import '../core/providers/providers.dart';
import 'generic/text_block_input.dart';

class PersonalityWidget extends Component {
  const PersonalityWidget({
    super.key,
    required super.definition,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final traitsKey = definition.sourceKeys['traits']!;
    final idealsKey = definition.sourceKeys['ideals']!;
    final bondsKey = definition.sourceKeys['bonds']!;
    final flawsKey = definition.sourceKeys['flaws']!;

    final traits = ref.watch(sheetDataProvider.select((state) => state?.get(traitsKey)));
    final ideals = ref.watch(sheetDataProvider.select((state) => state?.get(idealsKey)));
    final bonds = ref.watch(sheetDataProvider.select((state) => state?.get(bondsKey)));
    final flaws = ref.watch(sheetDataProvider.select((state) => state?.get(flawsKey)));

    final traitsUpdater = ref.read(sheetDataProvider.notifier).getUpdater(traitsKey);
    final idealsUpdater = ref.read(sheetDataProvider.notifier).getUpdater(idealsKey);
    final bondsUpdater = ref.read(sheetDataProvider.notifier).getUpdater(bondsKey);
    final flawsUpdater = ref.read(sheetDataProvider.notifier).getUpdater(flawsKey);

    return Column(
      children: [
        Expanded(child: Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Personality Traits',
                initialValue: traits,
                onChanged: (newValue) {
                  traitsUpdater(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Ideals',
                initialValue: ideals,
                onChanged: (newValue) {
                  idealsUpdater(newValue);
                },
              ),
            ),
          ],
        )),
        const SizedBox(height: 16),
        Expanded(child: Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Bonds',
                initialValue: bonds,
                onChanged: (newValue) {
                  bondsUpdater(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Flaws',
                initialValue: flaws,
                onChanged: (newValue) {
                  flawsUpdater(newValue);
                },
              ),
            ),
          ]
        )),
      ],
    );
  }
}
