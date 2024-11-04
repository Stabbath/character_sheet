import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/file_utils.dart';
import '../sheet_data.dart';
import 'providers.dart';

final sheetDataProvider = StateNotifierProvider<SheetDataNotifier, SheetData?>((ref) {
  return SheetDataNotifier(ref);
});

class SheetDataNotifier extends StateNotifier<SheetData?> {
  final Ref ref;
  Timer? _debounce;

  SheetDataNotifier(this.ref) : super(null);

  void initialize(SheetData? sheetData) {
    state = sheetData;
  }

  Function(dynamic value) getUpdater(String key) {
    return (newValue) {
      setValue(key, newValue);
    };
  }

  void setValue(String keyPath, dynamic newValue) {
    state = state?.copyWith(keyPath, newValue);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      String filePath = ref.read(sheetFilePathProvider);
      writeSheetToPath(filePath, state!);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
