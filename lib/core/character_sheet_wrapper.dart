import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'character_sheet_widget.dart';
import 'providers.dart';

class CharacterSheetWrapper extends ConsumerWidget {
  const CharacterSheetWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final sheetData = ref.watch(sheetDataProvider);

    if (layout != null && sheetData != null) {
      return CharacterSheet();
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              if (layout == null) Text('Please load a valid layout file'),
              if (sheetData == null) Text('Please load a valid sheet file'),
            ],
          ),
        ),
      );
    }
  }
}
