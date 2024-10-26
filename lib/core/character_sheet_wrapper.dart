// character_sheet_wrapper.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'character_sheet_widget.dart';

class CharacterSheetWrapper extends ConsumerWidget {
  const CharacterSheetWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutAsyncValue = ref.watch(layoutProvider);
    final sheetDataAsyncValue = ref.watch(sheetDataProvider);

    return layoutAsyncValue.when(
      data: (layoutData) {
        return sheetDataAsyncValue.when(
          data: (sheetData) {
            return CharacterSheet(layoutData: layoutData, sheetData: sheetData);
          },
          loading: () => Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        error: (error, stack) {
           throw(error, stack); 
          },
          // error: (error, stack) => Scaffold(
          //   body: Center(
          //     child: Text('Error loading sheet data: $error'),
          //   ),
          // ),
        );
      },
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) {
        throw(error, stack); 
      },
      // error: (error, stack) => Scaffold(
      //   body: Center(
      //     child: Text('Error loading layout data: $error'),
      //   ),
      // ),
    );
  }
}
