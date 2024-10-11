import 'package:character_sheet/generic/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../generic/text_block_input.dart';
import 'generic_block_provider.dart';

class GenericBlockWidget extends ConsumerWidget {
  final String blockId;

  const GenericBlockWidget({super.key, required this.blockId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genericBlock = ref.watch(genericBlockProviderFamily(blockId));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: genericBlock.title),
          const SizedBox(height: 8),
          Expanded(
            child: TextBlockInput(
              onChanged: (value) =>
                ref.read(genericBlockProviderFamily(blockId).notifier).updateContent(value),
            ),
          ),
        ],
      ),
    );
  }
}
