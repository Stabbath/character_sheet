import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/file_utils.dart';
import 'layout/layout_data.dart';
import 'sheet_data.dart';

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

class SheetDataNotifier extends StateNotifier<SheetData?> {
  final Ref ref;
  Timer? _debounce;

  SheetDataNotifier(this.ref) : super(null);

  void initialize(SheetData? sheetData) {
    state = sheetData;
  }

  void updateValue(String keyPath, dynamic newValue) {
    state?.setValue(keyPath, newValue);
    state = state;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      String filePath = ref.read(sheetFilePathProvider);
      writeSheetToPath(filePath, state!);
    });
  }

  dynamic getValue(String keyPath) => state?.getValue(keyPath);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

// Provider for SheetData
final sheetDataProvider = StateNotifierProvider<SheetDataNotifier, SheetData?>((ref) {
  return SheetDataNotifier(ref);
});

// Provider for LayoutData
final layoutProvider = StateNotifierProvider<LayoutNotifier, LayoutData?>((ref) {
  return LayoutNotifier(ref);
});

class LayoutNotifier extends StateNotifier<LayoutData?> {
  final Ref ref;
  LayoutNotifier(this.ref) : super(null);

  void initialize(LayoutData? layoutData) {
    state = layoutData;
  }
}

void initializeProviders(ProviderContainer container, String layoutPath, String sheetPath) {
  LayoutData? layoutData = loadLayoutFromPath(layoutPath);
  container.read(layoutFilePathProvider.notifier).update(layoutPath);
  container.read(layoutProvider.notifier).initialize(layoutData);

  if (layoutData != null) {
    SheetData? sheetData = loadSheetFromPath(sheetPath, layoutData);
    container.read(sheetFilePathProvider.notifier).update(sheetPath);
    container.read(sheetDataProvider.notifier).initialize(sheetData);
  }
}
