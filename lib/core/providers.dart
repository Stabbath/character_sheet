import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/file_utils.dart';
import 'layout_data.dart';
import 'sheet_data.dart';

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
      writeSheetToPath(ref.read(sheetFilePathProvider), state!);
    });
  }

  dynamic getValue(String keyPath) => state?.getValue(keyPath);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final layoutFilePathProvider = StateProvider<String>((ref) => '');
final sheetFilePathProvider = StateProvider<String>((ref) => '');

// Provider for SheetData
final sheetDataProvider = StateNotifierProvider<SheetDataNotifier, SheetData?>((ref) {
  return SheetDataNotifier(ref);
});

// Provider for LayoutData
final layoutProvider = StateProvider<LayoutData?>((ref) => null);

// Provider for specific key paths
StateNotifierProvider<KeyPathNotifier, dynamic> getKeyPathProvider(String keyPath) {
  return StateNotifierProvider<KeyPathNotifier, dynamic>((ref) {
    return KeyPathNotifier(ref, keyPath);
  });
}

// Notifier for KeyPath to handle updates to a specific path in SheetData
class KeyPathNotifier extends StateNotifier<dynamic> {
  KeyPathNotifier(this.ref, this._keyPath) : super(null) {
    // Initialize the state to the current value at the key path
    state = ref.read(sheetDataProvider.notifier).getValue(_keyPath);
  }

  final Ref ref;
  final String _keyPath;

  // Update function to notify SheetDataNotifier of a value change
  void update(dynamic newValue) {
    ref.read(sheetDataProvider.notifier).updateValue(_keyPath, newValue);
    state = newValue;
  }
}

// Initialize providers with loaded or default data
Future<void> initializeProviders(ProviderContainer container, String layoutPath, String sheetPath) async {
  LayoutData? layoutData = loadLayoutFromPath(layoutPath);
  container.read(layoutProvider.notifier).state = layoutData;

  if (layoutData != null) {
    SheetData? sheetData = loadSheetFromPath(sheetPath, layoutData);
    container.read(sheetDataProvider.notifier).initialize(sheetData);
  }
}
