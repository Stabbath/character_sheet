import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout_data.dart';
import '../sheet_data.dart';
import 'layout_data_provider.dart';
import 'sheet_data_provider.dart';

export 'layout_data_provider.dart';
export 'sheet_data_provider.dart';

final layoutFilePathProvider = StateNotifierProvider<FilePathNotifier, String>((ref) {
  return FilePathNotifier();
});

final sheetFilePathProvider = StateNotifierProvider<FilePathNotifier, String>((ref) {
  return FilePathNotifier();
});

class FilePathNotifier extends StateNotifier<String> {
  FilePathNotifier() : super('');

  void update(String newPath) {
    state = newPath;
  }
}

void initializeProviders(ProviderContainer container, String layoutPath, String sheetPath) {
  LayoutData layoutData = LayoutData.fromFilePath(layoutPath);
  container.read(layoutFilePathProvider.notifier).update(layoutPath);
  container.read(layoutProvider.notifier).initialize(layoutData);

  SheetData sheetData = SheetData.fromFilePath(sheetPath);
  layoutData.crossCheckAndUpdateSheetData(sheetData);
  container.read(sheetFilePathProvider.notifier).update(sheetPath);
  container.read(sheetDataProvider.notifier).initialize(sheetData);
}
