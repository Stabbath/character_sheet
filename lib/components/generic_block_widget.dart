import 'package:character_sheet/components/generic/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components.dart';
import '../core/providers/providers.dart';
import 'generic/text_block_input.dart';

class GenericBlockWidget extends Component {
  const GenericBlockWidget({
    super.key,
    required super.definition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['title']!)));
    final content = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['content']!)));

    final contentUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['content']!);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          const SizedBox(height: 8),
          Expanded(
            child: TextBlockInput(
              initialValue: content,
              onChanged: (value) => contentUpdater(value),
            ),
          ),
        ],
      ),
    );
  }
}
