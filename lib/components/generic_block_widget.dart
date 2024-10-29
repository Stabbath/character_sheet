import 'package:character_sheet/components/generic/section_header.dart';
import 'package:character_sheet/core/layout/data_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/component.dart';
import '../core/providers.dart';
import 'generic/text_block_input.dart';

class GenericBlockWidget extends ConsumerWidget {
  final String id;
  final String title;
  final DataBinding dataBinding;

  const GenericBlockWidget({
    super.key,
    required this.id,
    required this.title,
    required this.dataBinding,
  });

  factory GenericBlockWidget.fromComponent(Component component) {
    return GenericBlockWidget(
      id: component.id,
      title: component.readOnlyData['title'],
      dataBinding: component.dataBindings['content']!,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(sheetDataProvider.select((state) => state != null ? dataBinding.getInSheet(state) : null));
    final updater = dataBinding.createStateUpdater(ref.read(sheetDataProvider.notifier));

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
              onChanged: (value) =>
                updater(value),
            ),
          ),
        ],
      ),
    );
  }
}
