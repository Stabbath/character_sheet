import 'package:character_sheet/components/generic/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/text_block_input.dart';

class GenericBlockWidget extends ConsumerWidget {
  final String id;
  final String title;
  final StateNotifierProvider<KeyPathNotifier, dynamic> contentProvider;

  GenericBlockWidget({
    super.key, 
    required this.id,
    required this.title,
    required contentKeyPath,
  }) : contentProvider = getKeyPathProvider(contentKeyPath);

  factory GenericBlockWidget.fromComponent(Component component) {
    return GenericBlockWidget(
      id: component.id,
      title: component.readOnlyData['title'],
      contentKeyPath: component.dataBindings['content'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(contentProvider);
    final contentNotifier = ref.read(contentProvider.notifier);

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
                contentNotifier.update(value),
            ),
          ),
        ],
      ),
    );
  }
}
